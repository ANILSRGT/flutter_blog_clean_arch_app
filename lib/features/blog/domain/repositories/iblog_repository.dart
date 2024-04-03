import 'dart:typed_data' show Uint8List;

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';

abstract interface class IBlogRepository {
  /// Uploads a blog to the blogs table and
  /// <br>upload an image to the blog-images storage.
  /// <br>Returns the blog.
  Future<ResponseModel<EntityWithId<BlogEntity>>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  });
}
