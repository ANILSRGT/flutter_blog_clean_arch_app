import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/app.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_env_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_envs.dart';
import 'package:flutter_blog_clean_arch_app/core/widgets/toast/custom_toast.dart';
import 'package:flutter_blog_clean_arch_app/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSecrets.instance.init();
  await Supabase.initialize(
    url: AppSecrets.instance.read(AppEnvKeys.supabaseUrl),
    anonKey: AppSecrets.instance.read(AppEnvKeys.supabaseAnonKey),
  );
  await CustomToast.init();
  await Injection.instance.init();
  runApp(const MainApp());
}
