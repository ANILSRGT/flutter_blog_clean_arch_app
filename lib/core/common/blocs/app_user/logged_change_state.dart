import 'package:flutter_blog_clean_arch_app/core/common/entities/user/user_entity.dart';

final class LoggedChangeState {
  const LoggedChangeState({
    required this.isLoggedIn,
    required this.user,
  }) : assert(
          user != null || !isLoggedIn,
          'If user is logged in, user must not be null',
        );
  final bool isLoggedIn;
  final UserEntity? user;
}
