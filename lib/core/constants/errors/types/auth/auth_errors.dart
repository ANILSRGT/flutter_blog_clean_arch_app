import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/auth/auth_error_codes.dart';

final class AuthErrors extends Errors<AuthErrorCodes> {
  AuthErrors({required super.contentType});
}
