import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/models/user_model.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';

class AuthRepository implements IAuthRepository {
  const AuthRepository({
    required this.remoteDataSource,
  });

  final IAuthRemoteDataSource remoteDataSource;

  @override
  Future<ResponseModel<UserModel>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return remoteDataSource.signInWithEmailPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<ResponseModel<UserModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return remoteDataSource.signUpWithEmailPassword(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    return remoteDataSource.signOut();
  }
}
