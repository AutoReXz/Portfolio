import { createClient } from '@supabase/supabase-js';
import type { Database } from './database.types';

let client: ReturnType<typeof createClient<Database>> | undefined;

export function getSupabaseClient() {
  const url = import.meta.env.SUPABASE_URL;
  const publishableKey = import.meta.env.SUPABASE_PUBLISHABLE_KEY;

  if (!url && !publishableKey) return null;
  if (!url || !publishableKey) {
    throw new Error('Both SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY must be configured.');
  }

  if (!client) {
    client = createClient<Database>(url, publishableKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
        detectSessionInUrl: false,
      },
      global: {
        fetch: (input, init) =>
          fetch(input, { ...init, signal: AbortSignal.timeout(10_000) }),
      },
    });
  }

  return client;
}
