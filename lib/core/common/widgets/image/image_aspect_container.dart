import 'dart:math' show min;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageAspectContainer extends StatelessWidget {
  const ImageAspectContainer({
    required this.image,
    super.key,
    this.fit = BoxFit.cover,
    this.maxHeight,
    this.dynamicHeight,
    this.aspectRatio = 1.91,
  }) : assert(
          (maxHeight != null && dynamicHeight != null) ||
              (maxHeight == null && dynamicHeight == null),
          'maxHeight and dynamicHeight must be used together.',
        );
  final ImageProvider<Object> image;
  final BoxFit fit;
  final double? dynamicHeight;
  final double? maxHeight;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final height = maxHeight == null || dynamicHeight == null
        ? null
        : min(dynamicHeight!, maxHeight!);
    return SizedBox(
      width: height == null ? null : height * aspectRatio,
      height: height,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Image(
          image: image,
          fit: fit,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return DottedBorder(
              borderType: BorderType.RRect,
              strokeWidth: 2,
              dashPattern: const [4, 4],
              radius: const Radius.circular(8),
              color: Theme.of(context).colorScheme.error,
              child: const Tooltip(
                message: 'No image found!',
                triggerMode: TooltipTriggerMode.tap,
                showDuration: Duration(seconds: 2),
                child: Center(
                  child: Icon(Icons.error),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
