import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/network/internet_connection/connection_checker.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/auth_inject.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/blog_inject.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

    _sl
      ..registerLazySingleton(() => supabaseClient)
      ..registerLazySingleton(() => internetConnection)
      // Dependencies
      ..registerLazySingleton(
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
