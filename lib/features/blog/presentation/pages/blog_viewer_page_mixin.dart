import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_viewer_page.dart';

final class BlogViewerPageArgs {
  BlogViewerPageArgs({
    required this.blog,
  });
  final BlogEntity blog;
}

mixin BlogViewerPageMixin on State<BlogViewerPage> {
  late final BlogViewerPageArgs args;

  @override
  void initState() {
    super.initState();
    args = ModalRoute.of(context)!.settings.arguments! as BlogViewerPageArgs;
  }
}
