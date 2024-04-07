import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/network/network_error_codes.dart';
import 'package:flutter_blog_clean_arch_app/core/network/internet_connection/iconnection_checker.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_local_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/repositories/iblog_repository.dart';

class BlogRepository implements IBlogRepository {
  BlogRepository({
    required IBlogRemoteDataSource remoteDataSource,
    required IBlogLocalDataSource localDataSource,
    required IConnectionChecker connectionChecker,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _connectionChecker = connectionChecker;

  final IBlogRemoteDataSource _remoteDataSource;
  final IBlogLocalDataSource _localDataSource;
  final IConnectionChecker _connectionChecker;

  @override
  Future<ResponseModel<BlogEntity>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    final isConnected = await _connectionChecker.hasConnection;
    if (!isConnected) {
      return _remoteDataSource.serverErrorToResponseFail(
        code: NetworkErrorCodes.noInternetConnection,
        contentType: ErrorContentTypes.network,
        throwMessage: 'No internet connection',
      );
    }

    return _remoteDataSource.uploadBlog(
      image: image,
      title: title,
      content: content,
      ownerUserId: ownerUserId,
      topics: topics,
    );
  }

  @override
  Future<ResponseModel<BlogEntity>> updateBlog({
    required String blogId,
    Uint8List? image,
    String? title,
    String? content,
    String? ownerUserId,
    List<String>? topics,
  }) async {
    final isConnected = await _connectionChecker.hasConnection;
    if (!isConnected) {
      return _remoteDataSource.serverErrorToResponseFail(
        code: NetworkErrorCodes.noInternetConnection,
        contentType: ErrorContentTypes.network,
        throwMessage: 'No internet connection',
      );
    }

    return _remoteDataSource.updateBlog(
      blogId: blogId,
      image: image,
      title: title,
      content: content,
      ownerUserId: ownerUserId,
      topics: topics,
    );
  }

  @override
  Future<ResponseModel<List<BlogEntity>>> getAllBlogs() async {
    final isConnected = await _connectionChecker.hasConnection;
    if (!isConnected) {
      final blogs = _localDataSource.loadBlogs();
      return ResponseModelSuccess(data: blogs);
    }

    final blogsRes = await _remoteDataSource.getAllBlogs();
    if (blogsRes.isSuccess) {
      _localDataSource.uploadLocalBlogs(blogs: blogsRes.asSuccess.data);
    }

    return blogsRes;
  }
}
