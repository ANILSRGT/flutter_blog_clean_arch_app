import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/base_custom_toast_overlay.dart';

class CustomToastError extends BaseCustomToastOverlay {
  CustomToastError(BaseCustomToastOverlayParams params)
      : super(
          params: params,
          bgColor: Colors.red.shade900,
          leadingIcon: const Icon(Icons.error_rounded),
        );
}
