import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
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

  Future<ResponseModel<String>> _uploadBlogImage({
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
  Future<ResponseModel<BlogModel>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    try {
      final blog = BlogEntity(
        ownerUserId: ownerUserId,
        title: title,
        content: content,
        topics: topics,
        updatedAt: DateTime.now().toUtc(),
      );

      final blogData = await _blogTable.insert(blog.toJson()).single();

      final blogEntity = BlogEntity.fromJson(blogData);

      final blogImageRes = await _uploadBlogImage(
        image: image,
        blogId: blogEntity.id!,
      );

      if (blogImageRes.isFail) return blogImageRes.castTo();

      final blogModel = BlogModel.fromEntity(
        blogEntity.copyWith(imageUrl: blogImageRes.asSuccess.data),
      );

      return ResponseModelSuccess(data: blogModel);
    } catch (e) {
      return serverErrorToResponseFail<BlogModel>(
        code: BlogErrorCodes.uploadBlog,
        contentType: ErrorContentTypes.blog,
      );
    }
  }

  @override
  Future<ResponseModel<BlogModel>> updateBlog({
    required String blogId,
    Uint8List? image,
    String? title,
    String? content,
    String? ownerUserId,
    List<String>? topics,
  }) async {
    try {
      final blogData = await _blogTable.select().eq('id', blogId).single();

      if (blogData.isEmpty) {
        return serverErrorToResponseFail(
          code: BlogErrorCodes.notFoundBlog,
          contentType: ErrorContentTypes.blog,
        );
      }

      String? blogDataImageUrl;
      if (image != null) {
        final blogDataImageRes =
            await _uploadBlogImage(blogId: blogId, image: image);
        if (blogDataImageRes.isFail) return blogDataImageRes.castTo();
        blogDataImageUrl = blogDataImageRes.asSuccess.data;
      }

      final blogModel = BlogModel.fromEntity(
        BlogEntity.fromJson(blogData).copyWith(
          title: title,
          content: content,
          imageUrl: blogDataImageUrl,
          topics: topics,
          updatedAt: DateTime.now().toUtc(),
        ),
      );

      final updatedBlogData =
          await _blogTable.update(blogModel.toJson()).eq('id', blogId).single();

      if (updatedBlogData.isEmpty) {
        return serverErrorToResponseFail(
          code: BlogErrorCodes.notFoundBlog,
          contentType: ErrorContentTypes.blog,
        );
      }

      return ResponseModelSuccess(data: blogModel);
    } catch (e) {
      return serverErrorToResponseFail(
        code: BlogErrorCodes.updateBlog,
        contentType: ErrorContentTypes.blog,
      );
    }
  }
}
