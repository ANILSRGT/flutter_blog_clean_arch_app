import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_guards.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_page.dart';

enum RouteKeys {
  notFound(
    path: '/not-found',
    page: _NotFoundPage(),
  ),
  auth(
    path: '/auth',
    page: AuthPage(),
  ),
  blog(
    path: '/blog',
    page: BlogPage(),
    guards: {RouteGuards.auth},
  ),
  addNewBlog(
    path: '/blog/add',
    page: AddNewBlogPage(),
    guards: {RouteGuards.auth},
  );

  const RouteKeys({
    required this.path,
    required this.page,
    this.guards = const {},
  });
  final String path;
  final Widget page;
  final Set<RouteGuards> guards;

  static RouteKeys getPageKey(String path) {
    if (!RouteKeys.values.any((element) => element.path == path)) {
      return RouteKeys.notFound;
    }
    final route =
        RouteKeys.values.firstWhere((element) => element.path == path);
    return route;
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.home_rounded,
          ),
        ),
      ),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  }
}
