import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/route/my_router.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_page_mixin.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/widgets/blog_card.dart';

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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator.adaptive(
      onRefresh: refresh,
      child: SingleChildScrollView(
        primary: true,
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildBlogList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogList() {
    return ListView.separated(
      itemCount: watchBlogCubit.state.allBlogs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final blog = watchBlogCubit.state.allBlogs[index];
        return BlogCard(
          blog: blog,
          bgColor: index % 3 == 0
              ? AppPallete.gradient1
              : index % 3 == 1
                  ? AppPallete.gradient2
                  : AppPallete.gradient3,
        );
      },
    );
  }
}
