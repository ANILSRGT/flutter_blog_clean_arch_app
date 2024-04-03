import 'package:equatable/equatable.dart';

class EntityWithId<T extends Object> with EquatableMixin {
  const EntityWithId({
    required this.id,
    required this.entity,
  });

  final String id;
  final T entity;

  @override
  List<Object?> get props => [id, entity];

  EntityWithId<T> copyWithEntity({
    T? entity,
  }) {
    return EntityWithId<T>(
      id: id,
      entity: entity ?? this.entity,
    );
  }
}
