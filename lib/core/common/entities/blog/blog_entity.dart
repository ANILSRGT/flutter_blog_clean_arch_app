import 'package:equatable/equatable.dart';

class BlogEntity with EquatableMixin {
  const BlogEntity({
    this.id,
    this.ownerUserId,
    this.title,
    this.content,
    this.imageUrl,
    this.topics,
    this.updatedAt,
    this.resParams,
  });

  factory BlogEntity.fromJson(Map<String, dynamic> json) {
    return BlogEntity(
      id: json['id'] as String?,
      ownerUserId: json['owner_user_id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      imageUrl: json['image_url'] as String?,
      topics: (json['topics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      updatedAt: DateTime.parse(json['updated_at'] as String).toLocal(),
    );
  }

  Map<String, dynamic> get toJson {
    return <String, dynamic>{
      'id': id,
      'owner_user_id': ownerUserId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': (updatedAt ?? DateTime.now()).toUtc().toIso8601String(),
    };
  }

  final String? id;
  final String? ownerUserId;
  final String? title;
  final String? content;
  final String? imageUrl;
  final List<String>? topics;
  final DateTime? updatedAt;
  final BlogEntityResParams? resParams;

  @override
  List<Object?> get props => [id];

  BlogEntity copyWith({
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    BlogEntityResParams? resParams,
  }) {
    return BlogEntity(
      id: id,
      ownerUserId: ownerUserId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: (updatedAt ?? DateTime.now()).toLocal(),
      resParams: resParams ?? this.resParams,
    );
  }
}

class BlogEntityResParams {
  const BlogEntityResParams({
    this.ownerName,
  });

  final String? ownerName;

  BlogEntityResParams copyWith({
    String? ownerName,
  }) {
    return BlogEntityResParams(
      ownerName: ownerName ?? this.ownerName,
    );
  }
}
