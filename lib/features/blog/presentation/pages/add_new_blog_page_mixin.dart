import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/custom_toast.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/data/blog_topics.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/route/my_router.dart';
import 'package:flutter_blog_clean_arch_app/core/utils/pick_image.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/blocs/blog/blog_cubit.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/add_new_blog_page.dart';

mixin AddNewBlogPageMixin on State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Set<BlogTopics> selectedTopics = {};
  Uint8List? selectedImage;

  BlogCubit get _readBlogCubit => context.read<BlogCubit>();
  AppUserCubit get _readAppUserCubit => context.read<AppUserCubit>();
  AppCubit get _readAppCubit => context.read<AppCubit>();
  AppCubit get watchAppCubit => context.watch<AppCubit>();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    formKey.currentState?.dispose();
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
    log('Content is required');
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

  Future<void> onSaveBlog() async {
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

    final currentUserId = _readAppUserCubit.state.authSession.user?.id;

    if (currentUserId == null) {
      CustomToast.show(
        message: 'User not found',
        context: context,
      );
      return;
    }

    _readAppCubit.setBusy(true);
    final res = await _readBlogCubit.createBlog(
      image: selectedImage!,
      title: titleController.text,
      content: contentController.text,
      ownerUserId: currentUserId,
      topics: selectedTopics.map((e) => e.value).toList(),
    );

    if (res.isFail && mounted) {
      CustomToast.show(
        message: res.asFail.throwMessage,
        context: context,
      );

      _readAppCubit.setBusy(false);
      return;
    }

    _readAppCubit.setBusy(false);
    await MyRouter.instance.routerNav.pushAndRemoveAll(RouteKeys.blog);
  }
}
