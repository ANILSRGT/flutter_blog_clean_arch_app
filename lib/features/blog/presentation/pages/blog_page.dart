import 'package:flutter/material.dart';
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
        title: const Text('Blog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}
