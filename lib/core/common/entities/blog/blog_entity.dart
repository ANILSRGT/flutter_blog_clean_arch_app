import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_entity.g.dart';

@JsonSerializable()
class BlogEntity with EquatableMixin {
  const BlogEntity({
    this.id,
    this.ownerUserId,
    this.title,
    this.content,
    this.imageUrl,
    this.topics,
    this.updatedAt,
  });
  factory BlogEntity.fromJson(Map<String, dynamic> json) =>
      _$BlogEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BlogEntityToJson(this);

  @JsonKey(required: true)
  final String? id;
  @JsonKey(required: true)
  final String? ownerUserId;
  @JsonKey(required: true)
  final String? title;
  @JsonKey(required: true)
  final String? content;
  @JsonKey(required: true)
  final String? imageUrl;
  @JsonKey(defaultValue: [], required: true)
  final List<String>? topics;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _dateTimeFromJson, required: true)
  final DateTime? updatedAt;

  static String _dateTimeToJson(DateTime? value) =>
      (value ?? DateTime.now()).toUtc().toIso8601String();
  static DateTime _dateTimeFromJson(String value) =>
      DateTime.parse(value).toLocal();

  @override
  List<Object?> get props => [id];

  BlogEntity copyWith({
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogEntity(
      id: id,
      ownerUserId: ownerUserId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? DateTime.now().toUtc(),
    );
  }
}
