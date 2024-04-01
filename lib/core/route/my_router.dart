import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/loader/loader_widget.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_guards.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_keys.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth_page/auth_page_cubit.dart';

final class MyRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    return _navigateTo(settings.name);
  }

  Route<dynamic> _navigateTo(String? path) {
    if (kIsWeb || !Platform.isIOS) {
      return MaterialPageRoute(
        builder: (ctx) => _guardCheck(ctx, path),
      );
    }

    return CupertinoPageRoute(
      builder: (ctx) => _guardCheck(ctx, path),
    );
  }

  Widget _guardCheck(BuildContext context, String? path) {
    context.read<AuthPageCubit>().checkUser;
    final pageKey = RouteKeys.getPageKey(path ?? RouteKeys.notFound.path);
    final hasAuthGuard = pageKey.guards.contains(RouteGuards.auth);
    final isBusy = context.watch<AppCubit>().state.isBusy;
    final authSession = context.watch<AppUserCubit>().state.authSession;
    return LoaderWidget(
      isLoading: isBusy,
      child: (!hasAuthGuard ||
              (authSession.isLoggedIn && authSession.user != null))
          ? pageKey.page
          : RouteKeys.auth.page,
    );
  }
}
