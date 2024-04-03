import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user/user_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_current_user_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_in_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:flutter_blog_clean_arch_app/injection.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AppUserCubit appUserCubit,
  })  : _appUserCubit = appUserCubit,
        super(const AuthStateInitial());

  final AppUserCubit _appUserCubit;

  void toggleAuthState() {
    emit(state.copyWith(isSignInState: !state.isSignInState));
  }

  Future<ResponseModel<UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    final params = AuthSignInUseCaseParams(
      email: email,
      password: password,
    );

    final res =
        await Injection.instance.read<AuthSignInUseCase>().execute(params);

    if (res.isSuccess) _appUserCubit.updateUser(res.asSuccess.data);
    return res;
  }

  Future<ResponseModel<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final params = AuthSignUpUseCaseParams(
      name: name,
      email: email,
      password: password,
    );

    final res =
        await Injection.instance.read<AuthSignUpUseCase>().execute(params);

    return res;
  }

  Future<void> get signOut async {
    final res =
        await Injection.instance.read<AuthCurrentUserUseCase>().execute();
    if (res.isSuccess) _appUserCubit.updateUser(null);
  }

  Future<void> get checkUser async {
    final res =
        await Injection.instance.read<AuthCurrentUserUseCase>().execute();
    if (res.isSuccess) {
      _appUserCubit.updateUser(res.asSuccess.data);
    }
    if (res.isFail) _appUserCubit.updateUser(null);
  }
}
