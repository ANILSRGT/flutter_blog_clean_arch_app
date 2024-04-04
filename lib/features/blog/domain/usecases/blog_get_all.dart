import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/base/usecase.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/repositories/iblog_repository.dart';

class BlogGetAllUseCase implements UseCase<List<BlogEntity>> {
  BlogGetAllUseCase({
    required this.blogRepository,
  });

  final IBlogRepository blogRepository;

  @override
  Future<ResponseModel<List<BlogEntity>>> execute() async {
    return blogRepository.getAllBlogs();
  }
}
