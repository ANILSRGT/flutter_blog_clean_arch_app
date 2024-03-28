import 'dart:developer';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/auth/auth_error_codes.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/collection_extensions.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  AuthRemoteDataSource({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  ResponseModelFail<T> _authErrorCode<T>(AuthErrorCodes code) {
    final toErrorCode = Errors.toErrorCode(
      type: ErrorTypes.server,
      contentType: ErrorContentTypes.auth,
      codeType: code,
    );

    return ResponseModelFail(
      code: toErrorCode,
      message: code.message,
      throwMessage: code.message,
    );
  }

  @override
  Future<ResponseModel<UserModel>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) {
        return _authErrorCode<UserModel>(AuthErrorCodes.signInUserNotFound);
      }

      final user = UserModel(
        id: res.user!.id,
        name: res.user!.userMetadata!['name'] as String,
        email: email,
      );
      return ResponseModelSuccess(data: user);
    } catch (e) {
      return _authErrorCode<UserModel>(AuthErrorCodes.signIn);
    }
  }

  @override
  Future<ResponseModel<UserModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final existUsers = await _supabaseClient.auth.admin.listUsers();

      final existUser = existUsers.firstWhereOrNull(
        (element) => element.email == email,
      );

      if (existUser != null) {
        return _authErrorCode<UserModel>(AuthErrorCodes.signUpUserExist);
      }

      final res = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (res.user == null) {
        return _authErrorCode<UserModel>(AuthErrorCodes.signUpUserInvalid);
      }

      final user = UserModel(
        id: res.user!.id,
        name: name,
        email: email,
      );
      return ResponseModelSuccess(data: user);
    } catch (e) {
      log(e.toString());
      return _authErrorCode<UserModel>(AuthErrorCodes.signUp);
    }
  }

  @override
  Future<void> signOut() async {
    return _supabaseClient.auth.signOut();
  }
}
