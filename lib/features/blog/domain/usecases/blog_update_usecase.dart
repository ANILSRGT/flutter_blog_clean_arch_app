import 'dart:typed_data';

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/base/usecase.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/entity_with_id.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/repositories/iblog_repository.dart';

class BlogUpdateUseCase
    implements
        UseCaseWithParams<EntityWithId<BlogEntity>, BlogUpdateUseCaseParams> {
  BlogUpdateUseCase({
    required this.blogRepository,
  });

  final IBlogRepository blogRepository;

  @override
  Future<ResponseModel<EntityWithId<BlogEntity>>> execute(
    BlogUpdateUseCaseParams params,
  ) async {
    return blogRepository.uploadBlog(
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
    required this.image,
    required this.title,
    required this.content,
    required this.ownerUserId,
    required this.topics,
  });

  final Uint8List image;
  final String title;
  final String content;
  final String ownerUserId;
  final List<String> topics;
}
