import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/base/usecase.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user/user_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';

class AuthCurrentUserUseCase
    implements UseCaseNoResponse<ResponseModel<UserEntity>> {
  AuthCurrentUserUseCase({
    required this.authRepository,
  });

  final IAuthRepository authRepository;

  @override
  Future<ResponseModel<UserEntity>> execute() async {
    return authRepository.currentUser;
  }
}
