import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/models/user_model.dart';

abstract interface class IAuthRemoteDataSource {
  Future<ResponseModel<UserModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<ResponseModel<UserModel>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
