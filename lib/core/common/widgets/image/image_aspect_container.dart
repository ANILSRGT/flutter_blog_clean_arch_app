import 'dart:math' show min;
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageAspectContainer extends StatelessWidget {
  const ImageAspectContainer({
    required this.imageMemory,
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
  final Uint8List imageMemory;
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
        child: Image.memory(
          imageMemory,
          fit: fit,
          width: double.infinity,
        ),
      ),
    );
  }
}
