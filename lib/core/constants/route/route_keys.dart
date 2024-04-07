import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_guards.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/collection_extensions.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_viewer_page.dart';

enum RouteKeys {
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
  ),
  blogViewer(
    path: '/blog/viewer',
    page: BlogViewerPage(),
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

  static RouteKeys? getPageKey(String? path) {
    final route =
        RouteKeys.values.firstWhereOrNull((element) => element.path == path);
    return route;
  }

  static RouteKeys? getPageKeyByPage(Widget? page) {
    final route =
        RouteKeys.values.firstWhereOrNull((element) => element.page == page);
    return route;
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteKeys.blog.path,
              (route) => false,
            );
          },
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
