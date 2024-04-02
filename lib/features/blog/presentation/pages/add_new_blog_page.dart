import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/container/app_container.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/image/image_aspect_container.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/context_extensions.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/add_new_blog_page_mixin.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/widgets/add_new_blog_field_border.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/widgets/blog_edit_field.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/widgets/topic_list.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage>
    with AddNewBlogPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalKeys.pagesAddNewBlogTitle.local),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: AppContainer(
        padding: const EdgeInsets.all(20),
        child: _bodyContent(),
      ),
    );
  }

  Column _bodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _blogImageSelectFieldButton(),
        const SizedBox(height: 20),
        _topicsList(),
        const SizedBox(height: 20),
        _titleField(),
        const SizedBox(height: 20),
        _contentField(),
      ],
    );
  }

  GestureDetector _blogImageSelectFieldButton() {
    return GestureDetector(
      onTap: selectImage,
      child: selectedImage == null ? _blogImageSelectField() : _blogImage(),
    );
  }

  SizedBox _blogImageSelectField() {
    return SizedBox(
      width: double.infinity,
      child: AddNewBlogFieldBorder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.folder_rounded,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              LocalKeys.pagesAddNewBlogInputsSelectImageLabel.local,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Center _blogImage() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ImageAspectContainer(
          imageMemory: selectedImage!,
          dynamicHeight: context.screenHeight * 0.4,
          maxHeight: 150,
        ),
      ),
    );
  }

  TopicList _topicsList() {
    // TODO: Remove dummy data and implement real data
    return const TopicList(
      onChanged: null,
      topics: [
        'Technology',
        'Business',
        'Programming',
        'Entertainment',
      ],
    );
  }

  BlogEditField _titleField() {
    return BlogEditField(
      hintText: LocalKeys.pagesAddNewBlogInputsTitleLabel.local,
      controller: titleController,
      validator: null,
    );
  }

  BlogEditField _contentField() {
    return BlogEditField(
      hintText: LocalKeys.pagesAddNewBlogInputsContentLabel.local,
      controller: contentController,
      validator: null,
      maxLines: null,
    );
  }
}
