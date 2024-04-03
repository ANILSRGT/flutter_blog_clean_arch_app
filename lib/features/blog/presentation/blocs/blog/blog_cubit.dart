import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_update_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_upload_usecase.dart';
import 'package:flutter_blog_clean_arch_app/injection.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(const BlogStateInitial());

  Future<void> createBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    emit(const BlogStateLoading());
    final res = await Injection.instance.read<BlogUploadUseCase>().execute(
          BlogUploadUseCaseParams(
            image: image,
            title: title,
            content: content,
            ownerUserId: ownerUserId,
            topics: topics,
          ),
        );
    emit(BlogStateDone(blog: res));
  }

  Future<void> updateBlog({
    required String blogId,
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    emit(const BlogStateLoading());
    final res = await Injection.instance.read<BlogUpdateUseCase>().execute(
          BlogUpdateUseCaseParams(
            blogId: blogId,
            image: image,
            title: title,
            content: content,
            ownerUserId: ownerUserId,
            topics: topics,
          ),
        );
    emit(BlogStateDone(blog: res));
  }
}
