import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';

enum AuthErrorCodes implements IErrorCodesEnum {
  signIn(code: 1),
  signInUserNotFound(code: 2),
  signUp(code: 3),
  signUpUserExist(code: 4),
  signUpUserInvalid(code: 5),
  getCurrentUser(code: 6);

  const AuthErrorCodes({required this.code});

  @override
  final int code;

  @override
  String get message {
    return switch (this) {
      AuthErrorCodes.signIn => LocalKeys.errorsServerAuthSignIn.local,
      AuthErrorCodes.signInUserNotFound =>
        LocalKeys.errorsServerAuthSignInUserNotFound.local,
      AuthErrorCodes.signUp => LocalKeys.errorsServerAuthSignUp.local,
      AuthErrorCodes.signUpUserExist =>
        LocalKeys.errorsServerAuthSignUpUserExists.local,
      AuthErrorCodes.signUpUserInvalid =>
        LocalKeys.errorsServerAuthSignUpUserInvalid.local,
      AuthErrorCodes.getCurrentUser =>
        LocalKeys.errorsServerAuthGetCurrentUser.local,
    };
  }
}
