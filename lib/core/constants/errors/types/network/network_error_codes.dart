import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';

enum NetworkErrorCodes implements IErrorCodesEnum {
  noInternetConnection(code: 1);

  const NetworkErrorCodes({required this.code});

  @override
  final int code;

  @override
  String get message {
    return switch (this) {
      NetworkErrorCodes.noInternetConnection =>
        LocalKeys.errorsNetworkNoInternetConnection.local,
    };
  }
}
