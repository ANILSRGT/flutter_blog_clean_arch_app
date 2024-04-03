import 'package:flutter_blog_clean_arch_app/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
  });

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        name: entity.name,
        email: entity.email,
      );

  @override
  List<Object?> get props => [name, email];
}
