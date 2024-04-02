import 'package:flutter/material.dart';

final class AppContainer extends StatelessWidget {
  const AppContainer({
    required this.child,
    super.key,
    this.maxWidth,
    this.backgroundColor,
    this.padding,
    this.margin,
  });

  final Widget child;
  final double? maxWidth;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        padding: padding,
        margin: margin,
        color: backgroundColor,
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 1200,
        ),
        child: SizedBox(
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
