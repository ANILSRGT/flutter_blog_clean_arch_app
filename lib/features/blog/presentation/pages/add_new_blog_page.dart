import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/add_new_blog_page_mixin.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage>
    with AddNewBlogPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Blog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
    );
  }
}
