import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/data_source.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/models/blog_model.dart';

abstract class IBlogRemoteDataSource extends DataSource {
  /// Uploads a blog to the blogs table and returns the blog model.
  Future<ResponseModel<BlogModel>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  });

  /// Updates a blog in the blogs table and returns the blog model.
  Future<ResponseModel<BlogModel>> updateBlog({
    required String blogId,
    Uint8List? image,
    String? title,
    String? content,
    String? ownerUserId,
    List<String>? topics,
  });
}
