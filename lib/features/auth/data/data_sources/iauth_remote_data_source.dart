import 'package:flutter_blog_clean_arch_app/core/base/data_source.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user/user_entity.dart';

abstract class IAuthRemoteDataSource extends DataSource {
  /// Returns the current user.
  Future<ResponseModel<UserEntity>> get currentUser;

  /// Signs up a user with email and password.
  /// <br>Returns the user model.
  Future<ResponseModel<UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  /// Signs in a user with email and password.
  /// <br>Returns the user model.
  Future<ResponseModel<UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
