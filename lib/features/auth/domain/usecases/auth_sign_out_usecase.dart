import 'package:flutter_blog_clean_arch_app/core/base/usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';

class AuthSignOutUseCase implements UseCaseNoResponse<void> {
  AuthSignOutUseCase({
    required this.authRepository,
  });

  final IAuthRepository authRepository;

  @override
  Future<void> execute() async {
    return await authRepository.signOut();
  }
}
