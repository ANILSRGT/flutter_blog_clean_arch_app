import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user/user_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/auth/auth_error_codes.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/collection_extensions.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource extends IAuthRemoteDataSource {
  AuthRemoteDataSource({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;
  final SupabaseClient _supabaseClient;

  Session? get _userSession => _supabaseClient.auth.currentSession;

  @override
  Future<ResponseModel<UserEntity>> get currentUser async {
    try {
      if (_userSession == null) {
        return serverErrorToResponseFail<UserEntity>(
          code: AuthErrorCodes.getCurrentUser,
          contentType: ErrorContentTypes.auth,
          throwMessage: 'User session is null',
        );
      }

      final userData = await _supabaseClient
          .from('profiles')
          .select()
          .eq(
            'id',
            _userSession!.user.id,
          )
          .single();

      userData.addAll({
        'email': _userSession!.user.email,
      });

      final user = UserEntity.fromJson(userData);

      return ResponseModelSuccess(data: user);
    } catch (e) {
      return serverErrorToResponseFail<UserEntity>(
        code: AuthErrorCodes.getCurrentUser,
        contentType: ErrorContentTypes.auth,
        throwMessage: e.toString(),
      );
    }
  }

  @override
  Future<ResponseModel<UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) {
        return serverErrorToResponseFail<UserEntity>(
          code: AuthErrorCodes.signInUserNotFound,
          contentType: ErrorContentTypes.auth,
          throwMessage: 'User is null',
        );
      }

      final current = await currentUser;

      return ResponseModelSuccess(data: current.asSuccess.data);
    } catch (e) {
      return serverErrorToResponseFail<UserEntity>(
        code: AuthErrorCodes.signIn,
        contentType: ErrorContentTypes.auth,
        throwMessage: e.toString(),
      );
    }
  }

  @override
  Future<ResponseModel<UserEntity>> signUpWithEmailPassword({
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
        return serverErrorToResponseFail<UserEntity>(
          code: AuthErrorCodes.signUpUserExist,
          contentType: ErrorContentTypes.auth,
          throwMessage: 'User already exist',
        );
      }

      final res = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (res.user == null) {
        return serverErrorToResponseFail<UserEntity>(
          code: AuthErrorCodes.signUpUserInvalid,
          contentType: ErrorContentTypes.auth,
          throwMessage: 'User is null',
        );
      }

      final user = UserEntity(
        name: name,
        email: email,
      );

      return ResponseModelSuccess(data: user);
    } catch (e) {
      return serverErrorToResponseFail<UserEntity>(
        code: AuthErrorCodes.signUp,
        contentType: ErrorContentTypes.auth,
        throwMessage: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    return _supabaseClient.auth.signOut();
  }
}
