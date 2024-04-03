import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user_entity.dart';

abstract interface class IAuthRepository {
  Future<ResponseModel<EntityWithId<UserEntity>>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<ResponseModel<EntityWithId<UserEntity>>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<ResponseModel<EntityWithId<UserEntity>>> get currentUser;
  Future<void> signOut();
}
