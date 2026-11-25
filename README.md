# Galang Rakha Ahnanta — Portfolio

A static, minimalist portfolio built with Astro and TypeScript. Published profile and portfolio content is read from Supabase during the Astro build; the public website is generated as static files and uses bundled content whenever Supabase is unavailable.

## Local development

```powershell
npm install
npm run dev
```

Copy `.env.example` to `.env` and set `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` to the values from the existing Supabase project. These are build-time variables; do not use a service-role or secret key. `.env` is ignored by Git.

## Supabase setup

The SQL is version controlled but is **not** run automatically:

1. Open the existing **Portofolio** project in the Supabase Dashboard and choose **SQL Editor**.
2. Open `supabase/migrations/20261125000000_create_portfolio_content.sql`, copy its contents into a new SQL Editor query, and run it.
3. Open `supabase/seed.sql`, copy its contents into a second query, and run it.
4. Confirm the seeded rows and published flags in the Table Editor.

The seed content is based on the existing portfolio and reference documents. Project images and certificate PDFs remain local static assets; their relative paths are stored in Supabase, so these files must be included in the deployment.

## Content updates

Update rows using the Supabase Dashboard. Only rows with `is_published = true` are read by the public build. Set a row to unpublished to hide it. Add project technologies and images through their linked tables. Existing case-study pages for HOPTIMA and TA-Guide AI remain locally authored; other published projects get a generated overview page from their stored fields.

Content is fetched at build time, not per visitor. After editing published content, trigger a new Vercel deployment (for example, open **Deployments** and choose **Redeploy** on the latest deployment) to publish the changes. No Supabase webhook or server-side API is configured.

## Vercel deployment

1. Import this repository into Vercel. Use `npm run build` as the build command and `dist` as the output directory.
2. In **Project Settings → Environment Variables**, add:
   - `SUPABASE_URL`
   - `SUPABASE_PUBLISHABLE_KEY`
3. Set them for the production and preview environments as needed, then deploy.

The Supabase publishable key is intended for public clients. Row Level Security limits anonymous access to published rows, and anonymous write privileges are revoked. Never configure a service-role key in this website.

## Validation

```powershell
npm run check
npm run build
npm run preview
```

If Supabase is paused, unreachable, returns no published profile, or returns invalid data, the build logs a warning and uses the bundled local content. The resulting website is static and remains available without a live Supabase connection.
