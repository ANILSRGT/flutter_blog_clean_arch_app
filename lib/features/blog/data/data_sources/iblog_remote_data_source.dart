import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/data_source.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/models/blog_model.dart';

abstract class IBlogRemoteDataSource extends DataSource {
  /// Uploads a blog to the blogs table and returns the blog model.
  Future<ResponseModel<EntityWithId<BlogModel>>> uploadBlog(BlogModel blog);

  /// Uploads an image to the blog-images storage and returns the public URL.
  Future<ResponseModel<String>> uploadBlogImage({
    required Uint8List image,
    required String blogId,
  });

  /// Updates a blog in the blogs table and returns the blog model.
  Future<ResponseModel<EntityWithId<BlogModel>>> updateBlog(
    EntityWithId<BlogModel> blog,
  );
}
