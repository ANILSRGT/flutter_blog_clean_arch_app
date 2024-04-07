import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/image/image_aspect_container.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/image/network_memory_image.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/context_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/datetime_ago_calculator.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/format_date.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_viewer_page_mixin.dart';

class BlogViewerPage extends StatefulWidget {
  const BlogViewerPage({super.key});

  @override
  State<BlogViewerPage> createState() => _BlogViewerPageState();
}

class _BlogViewerPageState extends State<BlogViewerPage>
    with BlogViewerPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.blog.title!),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Scrollbar _buildBody() {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildBodyContent(),
        ),
      ),
    );
  }

  Column _buildBodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBlogTitle(),
        const SizedBox(height: 16),
        _buildOwnerName(),
        const SizedBox(height: 16),
        _buildBlogUpdateDateAndAgo(),
        const SizedBox(height: 16),
        _buildBlogImage(),
        const SizedBox(height: 16),
        _buildBlogContent(),
      ],
    );
  }

  Text _buildBlogTitle() {
    return Text(
      args.blog.title!,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Text _buildOwnerName() {
    return Text(
      args.blog.resParams!.ownerName!,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
    );
  }

  Text _buildBlogUpdateDateAndAgo() {
    return Text(
      '${FormatDate.formatDateBydMMMyyyy(args.blog.updatedAt!, context.fullLocaleCode)} . ${DateTimeAgoCalculator.calculate(args.blog.updatedAt!)}',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppPallete.grey,
          ),
    );
  }

  ClipRRect _buildBlogImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ImageAspectContainer(
        image: NetworkMemoryImage.fromUrl(args.blog.imageUrl!),
      ),
    );
  }

  Text _buildBlogContent() {
    return Text(
      args.blog.content!,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 2,
          ),
    );
  }
}
