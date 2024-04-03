import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity with EquatableMixin {
  const UserEntity({
    required this.name,
    required this.email,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  final String name;
  final String email;

  @override
  List<Object?> get props => [name, email];

  UserEntity copyWith({
    String? name,
    String? email,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
