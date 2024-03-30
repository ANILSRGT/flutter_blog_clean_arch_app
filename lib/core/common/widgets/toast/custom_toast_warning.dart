import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/base_custom_toast_overlay.dart';

class CustomToastWarning extends BaseCustomToastOverlay {
  CustomToastWarning(BaseCustomToastOverlayParams params)
      : super(
          params: params,
          bgColor: Colors.yellowAccent.shade700,
          leadingIcon: const Icon(
            Icons.warning_rounded,
            color: Color(0xFF1D1D1D),
          ),
          textColor: const Color(0xFF1D1D1D),
        );
}
