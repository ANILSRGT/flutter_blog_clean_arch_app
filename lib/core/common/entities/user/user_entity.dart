import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity with EquatableMixin {
  const UserEntity({
    this.id,
    this.name,
    this.email,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  @JsonKey(required: true)
  final String? id;
  @JsonKey(required: true)
  final String? name;
  @JsonKey(required: true)
  final String? email;

  @override
  List<Object?> get props => [id, email];

  UserEntity copyWith({
    String? name,
    String? email,
  }) {
    return UserEntity(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
