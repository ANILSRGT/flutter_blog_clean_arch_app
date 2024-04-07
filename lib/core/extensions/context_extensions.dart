import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  Orientation get orientation => MediaQuery.of(this).orientation;

  T orientationValue<T>({
    required T portrait,
    required T landscape,
  }) {
    return orientation == Orientation.portrait ? portrait : landscape;
  }
}

/// Easy localization extension
extension EasyLocaleExt on BuildContext {
  String get fullLocaleCode => locale.countryCode == null
      ? locale.languageCode
      : '${locale.languageCode}_${locale.countryCode}';
}
