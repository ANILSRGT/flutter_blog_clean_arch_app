import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/data/blog_topics.dart';

class TopicChip extends StatelessWidget {
  const TopicChip({
    required this.topic,
    required this.onSelected,
    required this.isSelected,
    super.key,
  });

  final BlogTopics topic;
  final void Function(BlogTopics topic) onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(topic),
      child: Chip(
        color: isSelected
            ? MaterialStatePropertyAll(
                Theme.of(context).chipTheme.selectedColor,
              )
            : null,
        side: isSelected ? BorderSide.none : null,
        label: Text(topic.value),
      ),
    );
  }
}
