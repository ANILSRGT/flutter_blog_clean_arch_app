import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  AuthRemoteDataSource({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;
  String _authError(String process) => 'auth_${process}_error';

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
        return ResponseModelFail(
          code: _authError('sign_in'),
          message: 'User not found!',
          throwMessage: 'User not found!',
        );
      }

      final user = UserModel.fromJson(res.user!.toJson());
      return ResponseModelSuccess(data: user);
    } catch (e) {
      return ResponseModelFail(
        code: _authError('sign_in'),
        message: 'An error occurred while signing in!',
        throwMessage: e.toString(),
      );
    }
  }

  @override
  Future<ResponseModel<UserModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );

      if (res.user == null) {
        return ResponseModelFail(
          code: _authError('sign_up'),
          message: 'User is null!',
          throwMessage: 'User is null',
        );
      }

      final user = UserModel.fromJson(res.user!.toJson());
      return ResponseModelSuccess(data: user);
    } catch (e) {
      return ResponseModelFail(
        code: _authError('sign_up'),
        message: 'An error occurred while signing up!',
        throwMessage: e.toString(),
      );
    }
  }
}
