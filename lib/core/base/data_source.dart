import 'package:flutter/foundation.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';

abstract class DataSource {
  /// [code] -> error code
  /// [contentType] -> error content type
  /// [throwMessage] -> only developer message
  ResponseModelFail<T> serverErrorToResponseFail<T>({
    required IErrorCodesEnum code,
    required ErrorContentTypes contentType,
    required String throwMessage,
  }) {
    final toErrorCode = Errors.toErrorCode(
      type: ErrorTypes.server,
      contentType: ErrorContentTypes.auth,
      codeType: code,
    );

    return ResponseModelFail(
      code: toErrorCode,
      message: code.message,
      throwMessage: kDebugMode ? throwMessage : code.message,
    );
  }
}
