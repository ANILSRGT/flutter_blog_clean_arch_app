part of 'injection.dart';

final class Injection {
  Injection._();
  static Injection instance = Injection._();

  final GetIt _sl = GetIt.instance;

  Future<void> init() async {
    await _initFeatures();
  }

  Future<void> _initFeatures() async {
    // final supabaseAdminClient = SupabaseClient(
    //   AppSecrets.instance.read(AppEnvKeys.supabaseUrl),
    //   AppSecrets.instance.read(AppEnvKeys.supabaseServiceRoleKey),
    //   authOptions: AuthClientOptions(
    //     pkceAsyncStorage: SharedPreferencesGotrueAsyncStorage(),
    //   ),
    // );
    final supabaseClient = Supabase.instance.client;
    final internetConnection = InternetConnection.createInstance();
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

    _sl
      ..registerLazySingleton(() => supabaseClient)
      ..registerLazySingleton(
        () => Hive.box<Map<String, dynamic>>(name: 'blogs'),
      )
      ..registerLazySingleton(() => internetConnection)
      // Dependencies
      ..registerLazySingleton<IConnectionChecker>(
        () => ConnectionChecker(internetConnection: _sl()),
      )
      // Core Blocs
      ..registerLazySingleton(AppCubit.new)
      ..registerLazySingleton(AppUserCubit.new);

    await AuthInject.instance.init(_sl);
    await BlogInject.instance.init(_sl);
  }

  T read<T extends Object>() {
    return _sl.get<T>();
  }
}
