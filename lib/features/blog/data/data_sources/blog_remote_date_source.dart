import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/blog/blog_error_codes.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSource extends IBlogRemoteDataSource {
  BlogRemoteDataSource({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;
  final SupabaseClient _supabaseClient;

  SupabaseQueryBuilder get _blogTable => _supabaseClient.from('blogs');
  StorageFileApi get _blogImagesStorage =>
      _supabaseClient.storage.from('blog-images');

  @override
  Future<ResponseModel<EntityWithId<BlogModel>>> uploadBlog(
    BlogModel blog,
  ) async {
    try {
      final blogData = await _blogTable.insert(blog.toJson()).single();
      final blogId = blogData['id'] as String;

      final blogModel = BlogModel.fromEntity(BlogEntity.fromJson(blogData));

      return ResponseModelSuccess(
        data: EntityWithId<BlogModel>(
          id: blogId,
          entity: blogModel,
        ),
      );
    } catch (e) {
      return serverErrorToResponseFail<EntityWithId<BlogModel>>(
        code: BlogErrorCodes.uploadBlog,
        contentType: ErrorContentTypes.blog,
      );
    }
  }

  @override
  Future<ResponseModel<String>> uploadBlogImage({
    required Uint8List image,
    required String blogId,
  }) async {
    try {
      await _blogImagesStorage.uploadBinary(blogId, image);

      final url = _blogImagesStorage.getPublicUrl(blogId);

      return ResponseModelSuccess(data: url);
    } catch (e) {
      return serverErrorToResponseFail<String>(
        code: BlogErrorCodes.uploadBlogImage,
        contentType: ErrorContentTypes.blog,
      );
    }
  }

  @override
  Future<ResponseModel<EntityWithId<BlogModel>>> updateBlog(
    EntityWithId<BlogModel> blog,
  ) async {
    try {
      final blogData = await _blogTable
          .update(blog.entity.toJson())
          .eq('id', blog.id)
          .single();

      final blogId = blogData['id'] as String;

      final blogModel = BlogModel.fromEntity(BlogEntity.fromJson(blogData));

      return ResponseModelSuccess(
        data: EntityWithId<BlogModel>(
          id: blogId,
          entity: blogModel,
        ),
      );
    } catch (e) {
      return serverErrorToResponseFail(
        code: BlogErrorCodes.updateBlog,
        contentType: ErrorContentTypes.blog,
      );
    }
  }
}
