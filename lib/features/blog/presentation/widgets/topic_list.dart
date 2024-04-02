import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/widgets/topic_chip.dart';

class TopicList extends StatefulWidget {
  const TopicList({
    required this.topics,
    required this.onChanged,
    super.key,
  });

  final List<String> topics;
  final void Function(List<String> selectedTopics)? onChanged;

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  final List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.topics.length,
      itemBuilder: (BuildContext context, int index) {
        return _topicChip(widget.topics[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 10);
      },
    );
  }

  Widget _topicChip(String label) {
    return TopicChip(
      label: label,
      isSelected: selectedTopics.contains(label),
      onSelected: (label) {
        setState(() {
          if (selectedTopics.contains(label)) {
            selectedTopics.remove(label);
          } else {
            selectedTopics.add(label);
          }
        });

        widget.onChanged?.call(selectedTopics);
      },
    );
  }
}
