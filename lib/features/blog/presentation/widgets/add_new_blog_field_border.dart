import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/theme/app_pallete.dart';

class AddNewBlogFieldBorder extends StatelessWidget {
  const AddNewBlogFieldBorder({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(2),
    this.margin = EdgeInsets.zero,
  });
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        color: AppPallete.border,
        radius: const Radius.circular(8),
        padding: padding,
        strokeWidth: 2,
        dashPattern: const [10, 6],
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
