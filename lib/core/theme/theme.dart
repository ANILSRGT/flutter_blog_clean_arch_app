import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';

final class AppTheme {
  static _border({Color color = AppPallete.border}) => OutlineInputBorder(
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
    ),
  );
}
