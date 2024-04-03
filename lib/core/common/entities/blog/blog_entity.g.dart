// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogEntity _$BlogEntityFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'ownerUserId',
      'title',
      'content',
      'imageUrl',
      'topics',
      'updatedAt'
    ],
  );
  return BlogEntity(
    id: json['id'] as String?,
    ownerUserId: json['ownerUserId'] as String?,
    title: json['title'] as String?,
    content: json['content'] as String?,
    imageUrl: json['imageUrl'] as String?,
    topics:
        (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    updatedAt: BlogEntity._dateTimeFromJson(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$BlogEntityToJson(BlogEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerUserId': instance.ownerUserId,
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'topics': instance.topics,
      'updatedAt': BlogEntity._dateTimeToJson(instance.updatedAt),
    };
