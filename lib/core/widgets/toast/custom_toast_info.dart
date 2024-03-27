import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/base_custom_toast_overlay.dart';

class CustomToastInfo extends BaseCustomToastOverlay {
  CustomToastInfo(BaseCustomToastOverlayParams params)
      : super(
          params: params,
          bgColor: Colors.blue.shade900,
          leadingIcon: const Icon(Icons.error_rounded),
        );
}
