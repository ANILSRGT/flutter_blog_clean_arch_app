import 'package:flutter/material.dart';

class BlogEditField extends StatelessWidget {
  const BlogEditField({
    required this.hintText,
    required this.controller,
    required this.validator,
    super.key,
    this.focusNode,
    this.isObscureText = false,
    this.isBusy = false,
    this.minLines = 1,
    this.maxLines = 1,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isObscureText;
  final bool isBusy;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
