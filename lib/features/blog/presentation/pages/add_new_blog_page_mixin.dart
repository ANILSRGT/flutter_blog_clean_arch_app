import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/custom_toast.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/pick_image.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/add_new_blog_page.dart';

mixin AddNewBlogPageMixin on State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  Set<String> selectedTopics = {};

  Uint8List? selectedImage;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
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
}
