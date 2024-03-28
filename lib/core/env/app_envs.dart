import 'package:flutter/foundation.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_env_keys.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final class AppSecrets {
  AppSecrets._();
  static AppSecrets instance = AppSecrets._();

  String _envPath() {
    if (kReleaseMode) return 'assets/env/.env';
    return 'assets/env/.dev.env';
  }

  Future<void> init() async {
    final path = _envPath();
    return dotenv.load(fileName: path);
  }

  String read(AppEnvKeys key) {
    return dotenv.get(key.keyName);
  }
}
