import 'package:flutter_blog_clean_arch_app/core/base/iinject.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_current_user_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_in_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_out_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthInject implements IInject {
  AuthInject._();
  static AuthInject instance = AuthInject._();

  @override
  Future<void> init(GetIt sl) async {
    // final supabaseAdminClient = SupabaseClient(
    //   AppSecrets.instance.read(AppEnvKeys.supabaseUrl),
    //   AppSecrets.instance.read(AppEnvKeys.supabaseServiceRoleKey),
    //   authOptions: AuthClientOptions(
    //     pkceAsyncStorage: SharedPreferencesGotrueAsyncStorage(),
    //   ),
    // );
    final supabaseClient = Supabase.instance.client;

    // Registering dependencies
    sl
      ..registerLazySingleton(() => supabaseClient)
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
        () => AuthCubit(
          appCubit: sl(),
          appUserCubit: sl(),
        ),
      );
  }
}
