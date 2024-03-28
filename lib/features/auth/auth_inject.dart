import 'package:flutter_blog_clean_arch_app/core/base/iinject.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_env_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_envs.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_in_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_out_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth_page/auth_page_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthInject implements IInject {
  static AuthInject instance = AuthInject._();
  AuthInject._();

  @override
  Future<void> init(GetIt sl) async {
    final supabaseAdminClient = SupabaseClient(
        AppSecrets.instance.read(AppEnvKeys.supabaseUrl),
        AppSecrets.instance.read(AppEnvKeys.supabaseServiceRoleKey),
        authOptions: AuthClientOptions(
          authFlowType: AuthFlowType.pkce,
          pkceAsyncStorage: SharedPreferencesGotrueAsyncStorage(),
        ));
    sl.registerLazySingleton(() => supabaseAdminClient);

    sl.registerFactory<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(supabaseClient: sl()),
    );

    sl.registerFactory<IAuthRepository>(
      () => AuthRepository(remoteDataSource: sl()),
    );

    sl.registerFactory(() => AuthSignInUseCase(authRepository: sl()));
    sl.registerFactory(() => AuthSignUpUseCase(authRepository: sl()));
    sl.registerFactory(() => AuthSignOutUseCase(authRepository: sl()));

    sl.registerLazySingleton(() => AuthPageCubit());
  }
}
