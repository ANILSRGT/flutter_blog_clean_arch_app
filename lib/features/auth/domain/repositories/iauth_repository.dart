import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/entities/user_entity.dart';

abstract interface class IAuthRepository {
  Future<ResponseModel<UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<ResponseModel<UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
