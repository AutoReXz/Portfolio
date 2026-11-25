type Table<Row> = {
  Row: Row;
  Insert: Partial<Row>;
  Update: Partial<Row>;
  Relationships: [];
};

export type Database = {
  public: {
    Tables: {
      profiles: Table<{
        id: string;
        full_name: string;
        professional_title: string;
        location: string;
        email: string;
        linkedin_url: string;
        github_url: string;
        description: string;
        is_published: boolean;
      }>;
      projects: Table<{
        slug: string;
        title: string;
        subtitle: string;
        project_type: string;
        status: string;
        summary: string;
        description: string | null;
        sort_order: number;
        is_published: boolean;
      }>;
      project_images: Table<{
        id: string;
        project_slug: string;
        image_url: string;
        alt_text: string | null;
        is_cover: boolean;
        sort_order: number;
      }>;
      project_technologies: Table<{
        project_slug: string;
        technology: string;
        sort_order: number;
      }>;
      skills: Table<{
        id: string;
        category: string;
        name: string;
        sort_order: number;
        is_published: boolean;
      }>;
      experiences: Table<{
        id: string;
        period: string;
        organization: string;
        role: string;
        detail: string;
        sort_order: number;
        is_published: boolean;
      }>;
      education: Table<{
        id: string;
        period: string;
        institution: string;
        degree: string;
        detail: string;
        sort_order: number;
        is_published: boolean;
      }>;
      certifications: Table<{
        id: string;
        title: string;
        issuer: string;
        category: string;
        file_path: string | null;
        credential_url: string | null;
        is_featured: boolean;
        sort_order: number;
        is_published: boolean;
      }>;
    };
    Views: Record<string, never>;
    Functions: Record<string, never>;
    Enums: Record<string, never>;
    CompositeTypes: Record<string, never>;
  };
};
