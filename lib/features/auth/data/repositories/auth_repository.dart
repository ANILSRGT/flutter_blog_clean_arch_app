import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/user/user_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/network/network_error_codes.dart';
import 'package:flutter_blog_clean_arch_app/core/network/internet_connection/iconnection_checker.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/data/data_sources/iauth_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/domain/repositories/iauth_repository.dart';

class AuthRepository implements IAuthRepository {
  const AuthRepository({
    required IAuthRemoteDataSource remoteDataSource,
    required IConnectionChecker connectionChecker,
  })  : _remoteDataSource = remoteDataSource,
        _connectionChecker = connectionChecker;

  final IAuthRemoteDataSource _remoteDataSource;
  final IConnectionChecker _connectionChecker;

  @override
  Future<ResponseModel<UserEntity>> get currentUser async {
    final hasConnection = await _connectionChecker.hasConnection;
    if (!hasConnection) {
      return _remoteDataSource.serverErrorToResponseFail(
        code: NetworkErrorCodes.noInternetConnection,
        contentType: ErrorContentTypes.network,
        throwMessage: 'No internet connection',
      );
    }

    return _remoteDataSource.currentUser;
  }

  @override
  Future<ResponseModel<UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _remoteDataSource.signInWithEmailPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<ResponseModel<UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _remoteDataSource.signUpWithEmailPassword(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    return _remoteDataSource.signOut();
  }
}
