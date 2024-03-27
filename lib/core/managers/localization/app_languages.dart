import 'package:flutter/material.dart';

enum AppLanguages {
  enUS(locale: Locale('en', 'US')),
  trTR(locale: Locale('tr', 'TR'));

  const AppLanguages({required this.locale});
  final Locale locale;
}
