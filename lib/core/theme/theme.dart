import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';

final class AppTheme {
  static OutlineInputBorder _border({Color color = AppPallete.border}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppPallete.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.background,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(color: AppPallete.gradient2),
      errorBorder: _border(color: AppPallete.error),
      border: _border(),
      focusedErrorBorder: _border(color: AppPallete.error),
      disabledBorder: _border(color: AppPallete.grey),
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        AppPallete.background,
      ),
      side: BorderSide(color: AppPallete.border),
      selectedColor: AppPallete.gradient1,
    ),
  );
}
