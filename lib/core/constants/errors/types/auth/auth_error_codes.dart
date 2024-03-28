import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';

enum AuthErrorCodes implements IErrorCodesEnum {
  signIn(code: 1),
  signInUserNotFound(code: 2),
  signUp(code: 3),
  signUpUserExist(code: 4),
  signUpUserInvalid(code: 5);

  const AuthErrorCodes({required this.code});

  @override
  final int code;

  @override
  String get message {
    return switch (this) {
      AuthErrorCodes.signIn => LocalKeys.errorsServerSignIn.local,
      AuthErrorCodes.signInUserNotFound =>
        LocalKeys.errorsServerSignInUserNotFound.local,
      AuthErrorCodes.signUp => LocalKeys.errorsServerSignUp.local,
      AuthErrorCodes.signUpUserExist =>
        LocalKeys.errorsServerSignUpUserExists.local,
      AuthErrorCodes.signUpUserInvalid =>
        LocalKeys.errorsServerSignUpUserInvalid.local,
    };
  }
}
