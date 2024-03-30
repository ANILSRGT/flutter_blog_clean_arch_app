import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/base_custom_toast_overlay.dart';

class CustomToastSuccess extends BaseCustomToastOverlay {
  CustomToastSuccess(BaseCustomToastOverlayParams params)
      : super(
          params: params,
          bgColor: Colors.green.shade900,
          leadingIcon: const Icon(Icons.check),
        );
}
