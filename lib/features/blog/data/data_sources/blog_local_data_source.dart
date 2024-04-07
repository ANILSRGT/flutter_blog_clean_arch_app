import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_local_data_source.dart';
import 'package:hive/hive.dart';

class BlogLocalDataSource extends IBlogLocalDataSource {
  BlogLocalDataSource({
    required this.box,
  });

  final Box<Map<String, dynamic>> box;

  @override
  List<BlogEntity> loadBlogs() {
    final blogs = <BlogEntity>[];
    box.read(() {
      for (var i = 0; i < box.length; i++) {
        final data = box.get(i.toString());
        if (data != null) {
          blogs.add(BlogEntity.fromJson(data));
        }
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogEntity> blogs}) {
    box
      ..clear()
      ..write(() {
        for (var i = 0; i < blogs.length; i++) {
          box.put(i.toString(), blogs[i].toJson);
        }
      });
  }
}
