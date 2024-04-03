import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/models/blog_model.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/repositories/iblog_repository.dart';

class BlogRepository implements IBlogRepository {
  BlogRepository({
    required IBlogRemoteDataSource blogRemoteDataSource,
  }) : _blogRemoteDataSource = blogRemoteDataSource;

  final IBlogRemoteDataSource _blogRemoteDataSource;

  @override
  Future<ResponseModel<EntityWithId<BlogModel>>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    final blog = BlogModel(
      imageUrl: '',
      content: content,
      ownerUserId: ownerUserId,
      title: title,
      topics: topics,
      updatedAt: DateTime.now().toUtc(),
    );

    final blogData = await _blogRemoteDataSource.uploadBlog(blog);

    if (blogData is ResponseModelFail) return blogData;

    final blogId = blogData.asSuccess.data.id;
    final imageUrlData = await _blogRemoteDataSource.uploadBlogImage(
      image: image,
      blogId: blogId,
    );

    if (imageUrlData is ResponseModelFail) return imageUrlData.castTo();

    final entityToModel = BlogModel.fromEntity(
      blog.copyWith(
        imageUrl: imageUrlData.asSuccess.data,
      ),
    );

    final updateBlogData = await _blogRemoteDataSource.updateBlog(
      EntityWithId<BlogModel>(
        id: blogId,
        entity: entityToModel,
      ),
    );

    if (updateBlogData is ResponseModelFail) return updateBlogData.castTo();

    return updateBlogData;
  }
}
