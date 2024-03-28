import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/managers/localization/app_languages.dart';

final class LocalizationManager {
  static LocalizationManager instance = LocalizationManager._();
  LocalizationManager._();

  final String path = 'assets/language';

  final Locale fallbackLocale = AppLanguages.enUS.locale;

  final List<Locale> supportedLocales = [
    AppLanguages.enUS.locale,
    AppLanguages.trTR.locale,
  ];

  Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }
}
