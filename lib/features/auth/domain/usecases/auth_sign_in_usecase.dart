import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/base/usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';

class AuthSignInUseCase
    implements UseCaseWithParams<UserEntity, AuthSignInUseCaseParams> {
  AuthSignInUseCase({
    required this.authRepository,
  });

  final IAuthRepository authRepository;

  @override
  Future<ResponseModel<UserEntity>> execute(
      AuthSignInUseCaseParams params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class AuthSignInUseCaseParams {
  AuthSignInUseCaseParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}