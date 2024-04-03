import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_entity.g.dart';

@JsonSerializable()
class BlogEntity with EquatableMixin {
  const BlogEntity({
    required this.ownerUserId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });
  factory BlogEntity.fromJson(Map<String, dynamic> json) =>
      _$BlogEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BlogEntityToJson(this);

  final String ownerUserId;
  final String title;
  final String content;
  final String imageUrl;
  @JsonKey(defaultValue: [])
  final List<String> topics;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _dateTimeFromJson)
  final DateTime updatedAt;

  static String _dateTimeToJson(DateTime value) =>
      value.toUtc().toIso8601String();
  static DateTime _dateTimeFromJson(String value) =>
      DateTime.parse(value).toLocal();

  @override
  List<Object?> get props => [
        ownerUserId,
        title,
        content,
        imageUrl,
        topics,
        updatedAt,
      ];

  BlogEntity copyWith({
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogEntity(
      ownerUserId: ownerUserId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
