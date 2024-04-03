import 'package:flutter_blog_clean_arch_app/core/base/data_source.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/models/user_model.dart';

abstract class IAuthRemoteDataSource extends DataSource {
  /// Returns the current user.
  Future<ResponseModel<EntityWithId<UserModel>>> get currentUser;

  /// Signs up a user with email and password.
  /// <br>Returns the user model.
  Future<ResponseModel<EntityWithId<UserModel>>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  /// Signs in a user with email and password.
  /// <br>Returns the user model.
  Future<ResponseModel<EntityWithId<UserModel>>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
