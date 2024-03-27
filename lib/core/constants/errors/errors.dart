import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_types.dart';

/// [T] is the type of error code enum
abstract class Errors<T extends IErrorCodesEnum> {
  final ErrorContentTypes _contentType;
  const Errors({required ErrorContentTypes contentType})
      : _contentType = contentType;

  /// ex. `S/AU#0001`<br>
  /// `S` is the type of error<br>
  /// `AU` is the content type of error<br>
  /// `0001` is the error code<br>
  /// `type` is the type of error by [ErrorTypes]<br>
  /// `codeType` is the error code by [T]/[IErrorCodesEnum]
  String toErrorCode({
    required ErrorTypes type,
    required T codeType,
  }) {
    return '${type.codeCharacter}.${_contentType.codeCharacter}-${codeType.code.toString().padLeft(4, '0')}';
  }
}

abstract interface class IErrorCodesEnum implements Enum {
  const IErrorCodesEnum({required this.code});

  /// [code] is the error code<br>
  /// Unique error code for each error type<br>
  /// ex. 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 etc.
  final int code;
}
