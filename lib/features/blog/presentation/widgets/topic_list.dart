import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/data/blog_topics.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/widgets/topic_chip.dart';

class TopicList extends StatefulWidget {
  const TopicList({
    required this.onChanged,
    super.key,
  });

  final void Function(Set<BlogTopics> selectedTopics)? onChanged;

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  final Set<BlogTopics> _selectedTopics = {};
  late final ScrollController _scrollController;
  ValueNotifier<bool> isVisibleLeftScrollBtn = ValueNotifier(false);
  ValueNotifier<bool> isVisibleRightScrollBtn = ValueNotifier(true);

  Set<BlogTopics> get _topics => BlogTopics.values.toSet();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        isVisibleLeftScrollBtn.value = _scrollController.offset >
            _scrollController.position.minScrollExtent;
        isVisibleRightScrollBtn.value = _scrollController.offset <
            _scrollController.position.maxScrollExtent;
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    isVisibleLeftScrollBtn.dispose();
    isVisibleRightScrollBtn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  _topics.length + _topics.length - 1,
                  (index) {
                    if (index.isEven) {
                      return _topicChip(_topics.elementAt(index ~/ 2));
                    } else {
                      return const SizedBox(width: 10);
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: _listScrollBtn(true),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: _listScrollBtn(false),
          ),
        ],
      ),
    );
  }

  Widget _listScrollBtn(bool isLeft) {
    final isVisible = isLeft ? isVisibleLeftScrollBtn : isVisibleRightScrollBtn;
    return AnimatedBuilder(
      animation: isLeft ? isVisibleLeftScrollBtn : isVisibleRightScrollBtn,
      builder: (context, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          opacity: isVisible.value ? 1 : 0,
          child: IgnorePointer(
            ignoring: !isVisible.value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          if (_scrollController.hasClients) {
            final maxScroll = _scrollController.position.maxScrollExtent;
            _scrollController.animateTo(
              isLeft ? 0 : maxScroll,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Card(
          color: AppPallete.grey,
          shape: const CircleBorder(),
          child: Icon(
            isLeft
                ? Icons.keyboard_double_arrow_left_rounded
                : Icons.keyboard_double_arrow_right_rounded,
            size: 24,
            color: AppPallete.black,
          ),
        ),
      ),
    );
  }

  Widget _topicChip(BlogTopics topic) {
    return TopicChip(
      topic: topic,
      isSelected: _selectedTopics.contains(topic),
      onSelected: (topic) {
        setState(() {
          if (_selectedTopics.contains(topic)) {
            _selectedTopics.remove(topic);
          } else {
            _selectedTopics.add(topic);
          }
        });

        widget.onChanged?.call(_selectedTopics);
      },
    );
  }
}
