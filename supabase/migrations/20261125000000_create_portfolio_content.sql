create table if not exists public.profiles (
  id text primary key default 'primary' check (id = 'primary'),
  full_name text not null,
  professional_title text not null,
  location text not null,
  email text not null,
  linkedin_url text not null,
  github_url text not null,
  description text not null,
  is_published boolean not null default false
);

create table if not exists public.projects (
  slug text primary key check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  title text not null,
  subtitle text not null,
  project_type text not null,
  status text not null,
  summary text not null,
  description text,
  sort_order integer not null default 0,
  is_published boolean not null default false
);

create table if not exists public.project_images (
  id text primary key,
  project_slug text not null references public.projects(slug) on delete cascade,
  image_url text not null,
  alt_text text,
  is_cover boolean not null default false,
  sort_order integer not null default 0,
  unique (project_slug, image_url)
);

create table if not exists public.project_technologies (
  project_slug text not null references public.projects(slug) on delete cascade,
  technology text not null,
  sort_order integer not null default 0,
  primary key (project_slug, technology)
);

create table if not exists public.skills (
  id text primary key,
  category text not null,
  name text not null,
  sort_order integer not null default 0,
  is_published boolean not null default false,
  unique (category, name)
);

create table if not exists public.experiences (
  id text primary key,
  period text not null,
  organization text not null,
  role text not null,
  detail text not null,
  sort_order integer not null default 0,
  is_published boolean not null default false
);

create table if not exists public.education (
  id text primary key,
  period text not null,
  institution text not null,
  degree text not null,
  detail text not null,
  sort_order integer not null default 0,
  is_published boolean not null default false
);

create table if not exists public.certifications (
  id text primary key,
  title text not null,
  issuer text not null,
  category text not null,
  file_path text,
  credential_url text,
  is_featured boolean not null default false,
  sort_order integer not null default 0,
  is_published boolean not null default false,
  check (file_path is null or file_path like '/certifications/%')
);

alter table public.profiles enable row level security;
alter table public.projects enable row level security;
alter table public.project_images enable row level security;
alter table public.project_technologies enable row level security;
alter table public.skills enable row level security;
alter table public.experiences enable row level security;
alter table public.education enable row level security;
alter table public.certifications enable row level security;

revoke all on public.profiles, public.projects, public.project_images,
  public.project_technologies, public.skills, public.experiences,
  public.education, public.certifications from public, anon, authenticated;

grant select on public.profiles, public.projects, public.project_images,
  public.project_technologies, public.skills, public.experiences,
  public.education, public.certifications to anon;

drop policy if exists "Public can read published profiles" on public.profiles;
create policy "Public can read published profiles"
  on public.profiles for select to anon using (is_published);

drop policy if exists "Public can read published projects" on public.projects;
create policy "Public can read published projects"
  on public.projects for select to anon using (is_published);

drop policy if exists "Public can read images of published projects" on public.project_images;
create policy "Public can read images of published projects"
  on public.project_images for select to anon
  using (exists (
    select 1 from public.projects
    where projects.slug = project_images.project_slug and projects.is_published
  ));

drop policy if exists "Public can read technologies of published projects" on public.project_technologies;
create policy "Public can read technologies of published projects"
  on public.project_technologies for select to anon
  using (exists (
    select 1 from public.projects
    where projects.slug = project_technologies.project_slug and projects.is_published
  ));

drop policy if exists "Public can read published skills" on public.skills;
create policy "Public can read published skills"
  on public.skills for select to anon using (is_published);

drop policy if exists "Public can read published experiences" on public.experiences;
create policy "Public can read published experiences"
  on public.experiences for select to anon using (is_published);

drop policy if exists "Public can read published education" on public.education;
create policy "Public can read published education"
  on public.education for select to anon using (is_published);

drop policy if exists "Public can read published certifications" on public.certifications;
create policy "Public can read published certifications"
  on public.certifications for select to anon using (is_published);
