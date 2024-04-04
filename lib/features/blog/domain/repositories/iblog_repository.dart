import 'dart:typed_data' show Uint8List;

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';

abstract interface class IBlogRepository {
  /// Uploads a blog to the blogs table and
  /// <br>upload an image to the blog-images storage.
  /// <br>Returns the blog.
  Future<ResponseModel<BlogEntity>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  });

  /// Updates a blog in the blogs table and
  /// <br>updates the image in the blog-images storage.
  /// <br>Returns the updated blog.
  Future<ResponseModel<BlogEntity>> updateBlog({
    required String blogId,
    Uint8List? image,
    String? title,
    String? content,
    String? ownerUserId,
    List<String>? topics,
  });

  /// Returns all blogs from the blogs table.
  Future<ResponseModel<List<BlogEntity>>> getAllBlogs();
}
