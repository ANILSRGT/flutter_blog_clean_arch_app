import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/custom_toast.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/data/blog_topics.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/pick_image.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/add_new_blog_page.dart';

mixin AddNewBlogPageMixin on State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Set<BlogTopics> selectedTopics = {};

  Uint8List? selectedImage;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  String? titleValidator(String? value) {
    if (value.isEmptyOrNull) {
      return 'Title is required';
    }
    return null;
  }

  String? contentValidator(String? value) {
    if (value.isEmptyOrNull) {
      return 'Content is required';
    }
    return null;
  }

  void selectImage() {
    PickImage.pickImage().then((value) {
      setState(() {
        if (value.isFail) {
          CustomToast.show(
            message: value.asFail.message,
            context: context,
          );
          selectedImage = null;
          return;
        }

        selectedImage = value.asSuccess.data;
      });
    });
  }

  void onSaveBlog() {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (!isValidForm) {
      CustomToast.show(
        message: 'Please fill all fields',
        context: context,
      );
      return;
    }

    if (selectedTopics.isEmpty) {
      CustomToast.show(
        message: 'Please select at least one topic',
        context: context,
      );
      return;
    }

    if (selectedImage == null) {
      CustomToast.show(
        message: 'Please select an image',
        context: context,
      );
      return;
    }
  }
}
