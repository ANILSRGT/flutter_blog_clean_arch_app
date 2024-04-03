import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/app.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/custom_toast.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_env_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/env/app_envs.dart';
import 'package:flutter_blog_clean_arch_app/core/managers/localization/localization_manager.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/blocs/blog/blog_cubit.dart';
import 'package:flutter_blog_clean_arch_app/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSecrets.instance.init();
  await Supabase.initialize(
    url: AppSecrets.instance.read(AppEnvKeys.supabaseUrl),
    anonKey: AppSecrets.instance.read(AppEnvKeys.supabaseAnonKey),
  );
  await LocalizationManager.instance.init();
  await CustomToast.init();
  await Injection.instance.init();

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationManager.instance.supportedLocales,
      path: LocalizationManager.instance.path,
      fallbackLocale: LocalizationManager.instance.fallbackLocale,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => Injection.instance.read<AppCubit>()),
          BlocProvider(create: (_) => Injection.instance.read<AppUserCubit>()),
          BlocProvider(create: (_) => Injection.instance.read<AuthCubit>()),
          BlocProvider(create: (_) => Injection.instance.read<BlogCubit>()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}
