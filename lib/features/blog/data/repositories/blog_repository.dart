import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/repositories/iblog_repository.dart';

class BlogRepository implements IBlogRepository {
  BlogRepository({
    required IBlogRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final IBlogRemoteDataSource _remoteDataSource;

  @override
  Future<ResponseModel<BlogModel>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    final blogData = await _remoteDataSource.uploadBlog(
      image: image,
      title: title,
      content: content,
      ownerUserId: ownerUserId,
      topics: topics,
    );

    return blogData;
  }

  @override
  Future<ResponseModel<BlogModel>> updateBlog({
    required String blogId,
    Uint8List? image,
    String? title,
    String? content,
    String? ownerUserId,
    List<String>? topics,
  }) {
    final blogData = _remoteDataSource.updateBlog(
      blogId: blogId,
      image: image,
      title: title,
      content: content,
      ownerUserId: ownerUserId,
      topics: topics,
    );

    return blogData;
  }
}
