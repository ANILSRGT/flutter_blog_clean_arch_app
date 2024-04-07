import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';

abstract class IBlogLocalDataSource {
  void uploadLocalBlogs({
    required List<BlogEntity> blogs,
  });
  List<BlogEntity> loadBlogs();
}
