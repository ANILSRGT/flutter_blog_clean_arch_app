import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/base/usecase.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';

class AuthSignUpUseCase
    implements
        UseCaseWithParams<EntityWithId<UserEntity>, AuthSignUpUseCaseParams> {
  AuthSignUpUseCase({
    required this.authRepository,
  });

  final IAuthRepository authRepository;

  @override
  Future<ResponseModel<EntityWithId<UserEntity>>> execute(
    AuthSignUpUseCaseParams params,
  ) async {
    return authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class AuthSignUpUseCaseParams {
  AuthSignUpUseCaseParams({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}
