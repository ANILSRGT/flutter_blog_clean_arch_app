import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';

enum AuthErrorCodes implements IErrorCodesEnum {
  signIn(code: 1),
  signUp(code: 2);

  const AuthErrorCodes({
    required this.code,
  });

  @override
  final int code;
}
