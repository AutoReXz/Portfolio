import { z } from 'zod';
import { site, projects, skills, experience } from './site';
import { localCertificationCategories } from './local-certifications';
import { getSupabaseClient } from '../lib/supabase';

const httpsUrlSchema = z.url({ protocol: /^https$/ });
const imageUrlSchema = z.union([
  z.string().regex(/^\/(?!\/).+/),
  httpsUrlSchema,
]);

const profileSchema = z.object({
  id: z.string().min(1),
  full_name: z.string().min(1),
  professional_title: z.string().min(1),
  location: z.string().min(1),
  email: z.email(),
  linkedin_url: httpsUrlSchema,
  github_url: httpsUrlSchema,
  description: z.string().min(1),
  is_published: z.boolean(),
});

const projectSchema = z.object({
  slug: z.string().regex(/^[a-z0-9]+(?:-[a-z0-9]+)*$/),
  title: z.string().min(1),
  subtitle: z.string().min(1),
  project_type: z.string().min(1),
  status: z.string().min(1),
  summary: z.string().min(1),
  description: z.string().nullable(),
  sort_order: z.number().int(),
  is_published: z.boolean(),
});

const projectImageSchema = z.object({
  id: z.string().min(1),
  project_slug: z.string().min(1),
  image_url: imageUrlSchema,
  alt_text: z.string().nullable(),
  is_cover: z.boolean(),
  sort_order: z.number().int(),
});

const projectTechnologySchema = z.object({
  project_slug: z.string().min(1),
  technology: z.string().min(1),
  sort_order: z.number().int(),
});

const skillSchema = z.object({
  id: z.string().min(1),
  category: z.string().min(1),
  name: z.string().min(1),
  sort_order: z.number().int(),
  is_published: z.boolean(),
});

const experienceSchema = z.object({
  id: z.string().min(1),
  period: z.string().min(1),
  organization: z.string().min(1),
  role: z.string().min(1),
  detail: z.string().min(1),
  sort_order: z.number().int(),
  is_published: z.boolean(),
});

const educationSchema = z.object({
  id: z.string().min(1),
  period: z.string().min(1),
  institution: z.string().min(1),
  degree: z.string().min(1),
  detail: z.string().min(1),
  sort_order: z.number().int(),
  is_published: z.boolean(),
});

const certificationSchema = z.object({
  id: z.string().min(1),
  title: z.string().min(1),
  issuer: z.string().min(1),
  category: z.string().min(1),
  file_path: z.string().regex(/^\/certifications\/[^?#]+$/).nullable(),
  credential_url: httpsUrlSchema.nullable(),
  is_featured: z.boolean(),
  sort_order: z.number().int(),
  is_published: z.boolean(),
});

let portfolioContentPromise: ReturnType<typeof loadPortfolioContent> | undefined;

type Certification = {
  title: string;
  issuer: string;
  file: string | null;
  url: string | null;
  featured: boolean;
};

type CategorizedCertification = Certification & { category: string };

function localCertifications(): Map<string, Certification[]> {
  const grouped = new Map<string, Certification[]>();

  for (const category of localCertificationCategories) {
    grouped.set(
      category.title,
      category.items.map(([title, issuer, file]) => ({
        title,
        issuer,
        file,
        url: null,
        featured: false,
      })),
    );
  }

  const featuredCertifications = [
    ['Dev Certification for Machine Learning with TensorFlow', 'dev.cert by dev.id'],
    ['Associate Data Scientist', 'Digital Talent Scholarship'],
    ['DeepLearning.AI TensorFlow Developer Specialization', 'DeepLearning.AI'],
    ['Machine Learning Specialization', 'DeepLearning.AI'],
    ['AI Advanced: AI Track elevAIte', 'Digital Talent Scholarship'],
    ['Belajar Analisis Data dengan Python', 'Dicoding Indonesia'],
  ];

  for (const [title, issuer] of featuredCertifications) {
    const item = [...grouped.values()].flat().find((cert) => cert.title === title);
    if (item) {
      item.featured = true;
    } else {
      const category = 'Artificial Intelligence & Machine Learning';
      grouped.get(category)?.push({ title, issuer, file: null, url: null, featured: true });
    }
  }

  return grouped;
}

function groupedCertifications(rows: CategorizedCertification[]) {
  const grouped = new Map<string, Certification[]>();
  for (const row of rows) {
    const category = grouped.get(row.category) ?? [];
    category.push(row);
    grouped.set(row.category, category);
  }
  return [...grouped].map(([title, items]) => ({ title, items }));
}

export function getPortfolioContent() {
  portfolioContentPromise ??= loadPortfolioContent();
  return portfolioContentPromise;
}

async function loadPortfolioContent() {
  const fallback = {
    site,
    projects: projects.map((project) => ({
      ...project,
      description: null,
      images: [{ src: project.image, alt: project.alt }],
    })),
    skills,
    experience,
    certifications: groupedCertifications([...localCertifications()].flatMap(([category, items]) =>
      items.map((item) => ({ ...item, category })),
    )),
    featuredCertifications: [...localCertifications().values()]
      .flat()
      .filter((certification) => certification.featured)
      .map(({ title, issuer }) => ({ title, issuer })),
  };

  try {
    const supabase = getSupabaseClient();
    if (!supabase) {
      console.info('[portfolio] Content source: bundled local fallback (Supabase variables are not configured).');
      return fallback;
    }

    const [
      profilesResult,
      projectsResult,
      imagesResult,
      technologiesResult,
      skillsResult,
      experiencesResult,
      educationResult,
      certificationsResult,
    ] = await Promise.all([
      supabase.from('profiles').select('*').eq('is_published', true).limit(2),
      supabase.from('projects').select('*').eq('is_published', true).order('sort_order'),
      supabase.from('project_images').select('*').order('sort_order'),
      supabase.from('project_technologies').select('*').order('sort_order'),
      supabase.from('skills').select('*').eq('is_published', true).order('sort_order'),
      supabase.from('experiences').select('*').eq('is_published', true).order('sort_order'),
      supabase.from('education').select('*').eq('is_published', true).order('sort_order'),
      supabase.from('certifications').select('*').eq('is_published', true).order('sort_order'),
    ]);

    const results = [
      profilesResult,
      projectsResult,
      imagesResult,
      technologiesResult,
      skillsResult,
      experiencesResult,
      educationResult,
      certificationsResult,
    ];
    if (results.some(({ error }) => error)) {
      throw new Error('One or more published content queries failed.');
    }

    const profiles = z.array(profileSchema).parse(profilesResult.data);
    const projectRows = z.array(projectSchema).parse(projectsResult.data);
    const imageRows = z.array(projectImageSchema).parse(imagesResult.data);
    const technologyRows = z.array(projectTechnologySchema).parse(technologiesResult.data);
    const skillRows = z.array(skillSchema).parse(skillsResult.data);
    const experienceRows = z.array(experienceSchema).parse(experiencesResult.data);
    const educationRows = z.array(educationSchema).parse(educationResult.data);
    const certificationRows = z.array(certificationSchema).parse(certificationsResult.data);

    if (profiles.length !== 1) {
      throw new Error('Expected exactly one published profile.');
    }

    console.info(
      `[portfolio] Content source: Supabase (${projectRows.length} projects, ${skillRows.length} skills, ${experienceRows.length + educationRows.length} experience and education entries, ${certificationRows.length} certifications).`,
    );

    const activeProjectSlugs = new Set(projectRows.map(({ slug }) => slug));
    const publishedImages = imageRows.filter(({ project_slug }) => activeProjectSlugs.has(project_slug));
    const publishedTechnologies = technologyRows.filter(({ project_slug }) =>
      activeProjectSlugs.has(project_slug),
    );
    const profile = profiles[0];
    const remoteCertifications = certificationRows.map((row) => ({
      category: row.category,
      title: row.title,
      issuer: row.issuer,
      file: row.file_path,
      url: row.credential_url,
      featured: row.is_featured,
    }));

    return {
      site: {
        name: profile.full_name,
        title: profile.professional_title,
        location: profile.location,
        email: profile.email,
        linkedin: profile.linkedin_url,
        github: profile.github_url,
        description: profile.description,
      },
      projects: projectRows.map((project) => {
        const projectImages = publishedImages.filter((image) => image.project_slug === project.slug);
        const cover = projectImages.find((image) => image.is_cover) ?? projectImages[0];
        return {
          slug: project.slug,
          title: project.title,
          subtitle: project.subtitle,
          type: project.project_type,
          status: project.status,
          summary: project.summary,
          description: project.description,
          image: cover?.image_url,
          alt: cover?.alt_text ?? project.title,
          images: projectImages.map(({ image_url, alt_text }) => ({
            src: image_url,
            alt: alt_text ?? project.title,
          })),
          tags: publishedTechnologies
            .filter(({ project_slug }) => project_slug === project.slug)
            .map(({ technology }) => technology),
        };
      }),
      skills: skillRows.reduce<{ title: string; items: string[] }[]>((groups, skill) => {
        let group = groups.find(({ title }) => title === skill.category);
        if (!group) {
          group = { title: skill.category, items: [] };
          groups.push(group);
        }
        group.items.push(skill.name);
        return groups;
      }, []),
      experience: [
        ...experienceRows.map((row) => ({
          period: row.period,
          organization: row.organization,
          role: row.role,
          detail: row.detail,
          sortOrder: row.sort_order,
        })),
        ...educationRows.map((row) => ({
          period: row.period,
          organization: row.institution,
          role: row.degree,
          detail: row.detail,
          sortOrder: row.sort_order,
        })),
      ]
        .sort((a, b) => a.sortOrder - b.sortOrder)
        .map(({ sortOrder: _sortOrder, ...item }) => item),
      certifications: groupedCertifications(remoteCertifications),
      featuredCertifications: remoteCertifications
        .filter((certification) => certification.featured)
        .map(({ title, issuer }) => ({ title, issuer })),
    };
  } catch (error) {
    console.warn(
      '[portfolio] Content source: bundled local fallback (Supabase content was unavailable or invalid).',
      error instanceof Error ? error.name : 'Unknown error',
    );
    return fallback;
  }
}
