import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';

enum NetworkErrorCodes implements IErrorCodesEnum {
  noInternetConnection(code: 1);

  const NetworkErrorCodes({required this.code});

  @override
  final int code;

  @override
  String get message {
    return switch (this) {
      NetworkErrorCodes.noInternetConnection => 'No internet connection',
    };
  }
}
