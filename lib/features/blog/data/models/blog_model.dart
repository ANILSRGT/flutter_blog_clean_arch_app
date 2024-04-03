import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    super.id,
    super.ownerUserId,
    super.title,
    super.content,
    super.imageUrl,
    super.topics,
    super.updatedAt,
  });

  factory BlogModel.fromEntity(BlogEntity entity) => BlogModel(
        id: entity.id,
        ownerUserId: entity.ownerUserId,
        title: entity.title,
        content: entity.content,
        imageUrl: entity.imageUrl,
        topics: entity.topics,
        updatedAt: entity.updatedAt,
      );
}
