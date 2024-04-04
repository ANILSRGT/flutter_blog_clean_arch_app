import 'package:equatable/equatable.dart';

class UserEntity with EquatableMixin {
  const UserEntity({
    this.id,
    this.name,
    this.email,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson(UserEntity instance) {
    return <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
  }

  final String? id;
  final String? name;
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
