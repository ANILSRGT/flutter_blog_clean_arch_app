import 'package:flutter/material.dart';

class TopicChip extends StatelessWidget {
  const TopicChip({
    required this.label,
    required this.onSelected,
    required this.isSelected,
    super.key,
  });

  final String label;
  final void Function(String label) onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(label),
      child: Chip(
        color: isSelected
            ? MaterialStatePropertyAll(
                Theme.of(context).chipTheme.selectedColor,
              )
            : null,
        side: isSelected ? BorderSide.none : null,
        label: Text(label),
      ),
    );
  }
}
