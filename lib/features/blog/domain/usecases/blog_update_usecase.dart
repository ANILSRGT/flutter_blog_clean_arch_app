import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/base/usecase.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/repositories/iblog_repository.dart';

class BlogUpdateUseCase
    implements UseCaseWithParams<BlogEntity, BlogUpdateUseCaseParams> {
  BlogUpdateUseCase({
    required this.blogRepository,
  });

  final IBlogRepository blogRepository;

  @override
  Future<ResponseModel<BlogEntity>> execute(
    BlogUpdateUseCaseParams params,
  ) async {
    return blogRepository.updateBlog(
      blogId: params.blogId,
      image: params.image,
      title: params.title,
      content: params.content,
      ownerUserId: params.ownerUserId,
      topics: params.topics,
    );
  }
}

class BlogUpdateUseCaseParams {
  BlogUpdateUseCaseParams({
    required this.blogId,
    this.image,
    this.title,
    this.content,
    this.ownerUserId,
    this.topics,
  });

  final String blogId;
  final Uint8List? image;
  final String? title;
  final String? content;
  final String? ownerUserId;
  final List<String>? topics;
}
