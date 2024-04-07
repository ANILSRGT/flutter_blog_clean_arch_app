import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/data/blog_topics.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/route/my_router.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/datetime_ago_calculator.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/separated_list_generate.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_viewer_page_mixin.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/widgets/topic_chip.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({
    required this.blog,
    required this.bgColor,
    super.key,
  });

  final BlogEntity blog;
  final Color bgColor;

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  void _onTapCard() {
    final toArgs = BlogViewerPageArgs(blog: widget.blog);
    MyRouter.instance.routerNav.push(
      RouteKeys.blogViewer,
      arguments: toArgs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapCard,
      child: Container(
        width: 200,
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopics(),
            const SizedBox(height: 8),
            _buildTitle(),
            const SizedBox(height: 8),
            _buildContent(),
            const SizedBox(height: 24),
            _buildAgo(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _buildTopics() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: _buildTopicsList(),
      ),
    );
  }

  List<Widget> _buildTopicsList() {
    return SeperatedListGenerate.generate(
      listLength: widget.blog.topics!.length,
      itemBuilder: _buildTopic,
      separatorBuilder: (index) => const SizedBox(width: 8),
    );
  }

  Widget _buildTopic(int index) {
    return TopicChip(
      topic: BlogTopics.fromString(widget.blog.topics![index]),
      onSelected: (_) {},
      isSelected: false,
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.blog.title!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildContent() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(4),
      color: AppPallete.white,
      padding: const EdgeInsets.all(8),
      dashPattern: const [4, 4],
      strokeWidth: 0.5,
      child: Text(
        widget.blog.content!,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildAgo() {
    return Text(
      DateTimeAgoCalculator.calculate(widget.blog.updatedAt!),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.end,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
