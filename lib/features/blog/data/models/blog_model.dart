import 'package:flutter_blog_clean_arch_app/core/common/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.ownerUserId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });

  factory BlogModel.fromEntity(BlogEntity entity) => BlogModel(
        ownerUserId: entity.ownerUserId,
        title: entity.title,
        content: entity.content,
        imageUrl: entity.imageUrl,
        topics: entity.topics,
        updatedAt: entity.updatedAt,
      );

  @override
  List<Object?> get props => [
        ownerUserId,
        title,
        content,
        imageUrl,
        topics,
        updatedAt,
      ];
}
