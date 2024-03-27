import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_in_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/usecases/auth_sign_up_usecase.dart';
import 'package:flutter_blog_clean_arch_app/injection.dart';

part 'auth_page_state.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  AuthPageCubit()
      : super(
          const AuthPageState(
            isSignInState: true,
            isBusy: false,
          ),
        );

  void toggleAuthState() {
    emit(state.copyWith(isSignInState: !state.isSignInState));
  }

  Future<ResponseModel<UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isBusy: true));
    final params = AuthSignInUseCaseParams(
      email: email,
      password: password,
    );

    final res =
        await Injection.instance.read<AuthSignInUseCase>().execute(params);

    emit(state.copyWith(isBusy: false));
    return res;
  }

  Future<ResponseModel<UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isBusy: true));
    final params = AuthSignUpUseCaseParams(
      name: name,
      email: email,
      password: password,
    );

    final res =
        await Injection.instance.read<AuthSignUpUseCase>().execute(params);

    emit(state.copyWith(isBusy: false));
    return res;
  }
}
