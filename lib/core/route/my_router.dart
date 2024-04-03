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
import 'package:flutter_blog_clean_arch_app/core/route/irouternav.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/blocs/auth/auth_cubit.dart';

part 'routernavs/adaptive_routernav.dart';

final class MyRouter {
  MyRouter._();
  static MyRouter instance = MyRouter._();

  bool _firstTime = true;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  IRouterNav get routerNav => _DefaultRouterNav(navigatorKey: navigatorKey);

  Map<String, Widget Function(BuildContext)> get routes => {
        RouteKeys.auth.path: (ctx) =>
            _generateRouteWidget(ctx, RouteKeys.auth.path),
        RouteKeys.blog.path: (ctx) =>
            _generateRouteWidget(ctx, RouteKeys.blog.path),
        RouteKeys.addNewBlog.path: (ctx) =>
            _generateRouteWidget(ctx, RouteKeys.addNewBlog.path),
      };

  Route<dynamic> navigateTo(String? path) {
    return kIsWeb || (!Platform.isIOS && !Platform.isMacOS)
        ? MaterialPageRoute(
            builder: (ctx) => _generateRouteWidget(ctx, path),
          )
        : CupertinoPageRoute(
            builder: (ctx) => _generateRouteWidget(ctx, path),
          );
  }

  Widget _generateRouteWidget(BuildContext context, String? path) {
    if (_firstTime) {
      context.read<AuthCubit>().checkUser;
      _firstTime = false;
    }
    final pageKey = RouteKeys.getPageKey(path);
    if (pageKey == null) return const NotFoundPage();
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
