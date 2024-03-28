enum AppEnvKeys {
  supabaseUrl(keyName: "SupabaseUrl"),
  supabaseAnonKey(keyName: "SupabaseAnonKey"),
  supabaseServiceRoleKey(keyName: "SupabaseServiceRoleKey");

  const AppEnvKeys({
    required this.keyName,
  });

  final String keyName;
}
