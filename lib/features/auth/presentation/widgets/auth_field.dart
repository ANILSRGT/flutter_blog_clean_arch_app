import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    required this.hintText,
    required this.controller,
    required this.validator,
    super.key,
    this.focusNode,
    this.isObscureText = false,
    this.isBusy = false,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isObscureText;
  final bool isBusy;
  final FocusNode? focusNode;

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
    );
  }
}
