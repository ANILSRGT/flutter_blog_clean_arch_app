import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/blog/blog_error_codes.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/id_generate.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSource extends IBlogRemoteDataSource {
  BlogRemoteDataSource({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;
  final SupabaseClient _supabaseClient;

  SupabaseQueryBuilder get _blogTable => _supabaseClient.from('blogs');
  StorageFileApi get _blogImagesStorage =>
      _supabaseClient.storage.from('blog_images');

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
        throwMessage: e.toString(),
      );
    }
  }

  @override
  Future<ResponseModel<BlogEntity>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    try {
      final blog = BlogEntity(
        id: IdGenerate.generateUUIDV4(),
        ownerUserId: ownerUserId,
        title: title,
        content: content,
        topics: topics,
        updatedAt: DateTime.now().toUtc(),
      );

      final blogData = await _blogTable.insert(blog.toJson).select();

      final blogEntity = BlogEntity.fromJson(blogData.first);

      final blogImageRes = await _uploadBlogImage(
        image: image,
        blogId: blogEntity.id!,
      );

      if (blogImageRes.isFail) return blogImageRes.asFail.convertTo();

      final updatedModel = blogEntity.copyWith(
        imageUrl: blogImageRes.asSuccess.data,
      );

      final updatedBlogData = await _blogTable
          .update(updatedModel.toJson)
          .eq('id', updatedModel.id!)
          .select();

      if (updatedBlogData.isEmpty) {
        return serverErrorToResponseFail<BlogEntity>(
          code: BlogErrorCodes.uploadBlogImageByUploadBlog,
          contentType: ErrorContentTypes.blog,
          throwMessage: 'Blog image upload failed by blog creation',
        );
      }

      return ResponseModelSuccess(data: updatedModel);
    } catch (e) {
      return serverErrorToResponseFail<BlogEntity>(
        code: BlogErrorCodes.uploadBlog,
        contentType: ErrorContentTypes.blog,
        throwMessage: e.toString(),
      );
    }
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
    try {
      final blogData = await _blogTable.select().eq('id', blogId).single();

      if (blogData.isEmpty) {
        return serverErrorToResponseFail(
          code: BlogErrorCodes.notFoundBlog,
          contentType: ErrorContentTypes.blog,
          throwMessage: 'Blog not found',
        );
      }

      String? blogDataImageUrl;
      if (image != null) {
        final blogDataImageRes =
            await _uploadBlogImage(blogId: blogId, image: image);
        if (blogDataImageRes.isFail) return blogDataImageRes.asFail.convertTo();
        blogDataImageUrl = blogDataImageRes.asSuccess.data;
      }

      final blogEntity = BlogEntity.fromJson(blogData).copyWith(
        title: title,
        content: content,
        imageUrl: blogDataImageUrl,
        topics: topics,
      );

      final updatedBlogData =
          await _blogTable.update(blogEntity.toJson).eq('id', blogId).single();

      if (updatedBlogData.isEmpty) {
        return serverErrorToResponseFail(
          code: BlogErrorCodes.notFoundBlog,
          contentType: ErrorContentTypes.blog,
          throwMessage: 'Blog not found',
        );
      }

      return ResponseModelSuccess(data: blogEntity);
    } catch (e) {
      return serverErrorToResponseFail(
        code: BlogErrorCodes.updateBlog,
        contentType: ErrorContentTypes.blog,
        throwMessage: e.toString(),
      );
    }
  }

  @override
  Future<ResponseModel<List<BlogEntity>>> getAllBlogs() async {
    try {
      final blogData = await _blogTable.select('*, profiles (name)');

      final blogEntities = blogData.map(
        (blog) {
          final toEntity = BlogEntity.fromJson(blog);
          final addResParams = toEntity.copyWith(
            resParams: BlogEntityResParams(
              ownerName:
                  (blog['profiles'] as Map<String, dynamic>)['name'] as String?,
            ),
          );

          return addResParams;
        },
      ).toList();

      return ResponseModelSuccess(data: blogEntities);
    } catch (e) {
      return serverErrorToResponseFail(
        code: BlogErrorCodes.getAllBlogs,
        contentType: ErrorContentTypes.blog,
        throwMessage: e.toString(),
      );
    }
  }
}
