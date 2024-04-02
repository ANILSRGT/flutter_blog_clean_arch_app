import 'dart:typed_data' show Uint8List;

import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_content_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/error_types.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/errors/types/utils/utils_error_codes.dart';
import 'package:image_picker/image_picker.dart';

final class PickImage {
  static Future<ResponseModel<Uint8List?>> pickImage() async {
    try {
      final xFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (xFile == null) return const ResponseModelSuccess(data: null);

      final bytes = await xFile.readAsBytes();

      return ResponseModelSuccess(data: bytes);
    } catch (e) {
      const codeType = UtilsErrorCodes.pickImage;
      final errorCode = Errors.toErrorCode(
        type: ErrorTypes.unknown,
        contentType: ErrorContentTypes.utils,
        codeType: codeType,
      );
      return ResponseModelFail(
        message: codeType.message,
        code: errorCode,
        throwMessage: e.toString(),
      );
    }
  }
}
