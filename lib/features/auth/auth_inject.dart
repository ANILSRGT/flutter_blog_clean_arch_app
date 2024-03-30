import 'package:flutter_blog_clean_arch_app/core/base/iinject.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_env_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_envs.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_current_user_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_in_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_out_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth_page/auth_page_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthInject implements IInject {
  AuthInject._();
  static AuthInject instance = AuthInject._();

  @override
  Future<void> init(GetIt sl) async {
    final supabaseAdminClient = SupabaseClient(
      AppSecrets.instance.read(AppEnvKeys.supabaseUrl),
      AppSecrets.instance.read(AppEnvKeys.supabaseServiceRoleKey),
      authOptions: AuthClientOptions(
        pkceAsyncStorage: SharedPreferencesGotrueAsyncStorage(),
      ),
    );

    // Registering dependencies
    sl
      ..registerLazySingleton(() => supabaseAdminClient)
      // Core Blocs
      ..registerLazySingleton(AppCubit.new)
      ..registerLazySingleton(AppUserCubit.new)
      // Data Sources
      ..registerFactory<IAuthRemoteDataSource>(
        () => AuthRemoteDataSource(supabaseClient: sl()),
      )
      // Repositories
      ..registerFactory<IAuthRepository>(
        () => AuthRepository(remoteDataSource: sl()),
      )
      // Use Cases
      ..registerFactory(() => AuthCurrentUserUseCase(authRepository: sl()))
      ..registerFactory(() => AuthSignInUseCase(authRepository: sl()))
      ..registerFactory(() => AuthSignUpUseCase(authRepository: sl()))
      ..registerFactory(() => AuthSignOutUseCase(authRepository: sl()))
      // Blocs
      ..registerLazySingleton(
        () => AuthPageCubit(
          appCubit: sl(),
          appUserCubit: sl(),
        ),
      );
  }
}
