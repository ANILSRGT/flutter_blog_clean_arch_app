enum AppEnvKeys {
  supabaseUrl(keyName: "SupabaseUrl"),
  supabaseAnonKey(keyName: "SupabaseAnonKey");

  const AppEnvKeys({
    required this.keyName,
  });

  final String keyName;
}
