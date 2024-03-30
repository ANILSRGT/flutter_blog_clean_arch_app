import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/loader/loader_widget.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/theme.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth_page/auth_page_cubit.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/pages/auth_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const AppNav(),
    );
  }
}

class AppNav extends StatefulWidget {
  const AppNav({super.key});

  @override
  State<AppNav> createState() => _AppNavState();
}

class _AppNavState extends State<AppNav> {
  @override
  void initState() {
    super.initState();
    context.read<AuthPageCubit>().checkUser;
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = context.watch<AppCubit>().state.isBusy;
    final authSession = context.watch<AppUserCubit>().state.authSession;
    return LoaderWidget(
      isLoading: isBusy,
      child: (authSession.isLoggedIn && authSession.user != null)
          ? Scaffold(
              appBar: AppBar(
                title: const Text('Blog App'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      context.read<AppUserCubit>().updateUser(null);
                    },
                  ),
                ],
              ),
              body: const Center(
                child: Text('Welcome to Blog App'),
              ),
            )
          : const AuthPage(),
    );
  }
}
