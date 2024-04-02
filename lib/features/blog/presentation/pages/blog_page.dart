import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/route/my_router.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_page_mixin.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> with BlogPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalKeys.pagesBlogTitle.local),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              MyRouter.instance.routerNav.push(RouteKeys.addNewBlog);
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
