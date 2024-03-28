import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/base_custom_toast_overlay.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/custom_toast_error.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/custom_toast_info.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/custom_toast_success.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/custom_toast_warning.dart';

enum CustomToastAlignment { top, center, bottom }

enum CustomToastType { success, error, info, warning }

class CustomToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static CustomToastAlignment _alignment = CustomToastAlignment.bottom;
  static CustomToastType _type = CustomToastType.info;

  static Future<void> init({
    CustomToastAlignment? alignment,
    CustomToastType? type,
  }) async {
    _overlayEntry = null;
    _timer = null;
    _alignment = alignment ?? _alignment;
    _type = type ?? _type;
  }

  static void show({
    required String message,
    required BuildContext context,
    String? title,
    CustomToastAlignment? alignment,
    CustomToastType? type,
  }) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _timer?.cancel();
    }

    final overlayParams = BaseCustomToastOverlayParams(
      title: title,
      context: context,
      message: message,
      alignment: alignment ?? _alignment,
    );

    _overlayEntry = _createOverlay(type ?? _type, overlayParams);

    _insertOverlay(context);
  }

  static BaseCustomToastOverlay _createOverlay(
    CustomToastType type,
    BaseCustomToastOverlayParams overlayParams,
  ) {
    return switch (type) {
      CustomToastType.success => CustomToastSuccess(overlayParams),
      CustomToastType.error => CustomToastError(overlayParams),
      CustomToastType.info => CustomToastInfo(overlayParams),
      CustomToastType.warning => CustomToastWarning(overlayParams),
    };
  }

  static Future<void> _insertOverlay(BuildContext context) async {
    final overlay = Navigator.of(context).overlay;
    if (_overlayEntry == null || overlay == null) return;
    overlay.insert(_overlayEntry!);

    _timer = Timer(
      const Duration(seconds: 3),
      () {
        if (_overlayEntry != null) {
          _overlayEntry?.remove();
          _overlayEntry = null;
          _timer?.cancel();
        }
      },
    );
  }
}
