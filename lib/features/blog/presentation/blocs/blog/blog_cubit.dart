import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';
import 'package:flutter_blog_clean_arch_app/core/common/entities/blog/blog_entity.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_get_all.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_update_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_upload_usecase.dart';
import 'package:flutter_blog_clean_arch_app/injection.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(const BlogStateInitial());

  Future<ResponseModel<BlogEntity>> createBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
    final res = await Injection.instance.read<BlogUploadUseCase>().execute(
          BlogUploadUseCaseParams(
            image: image,
            title: title,
            content: content,
            ownerUserId: ownerUserId,
            topics: topics,
          ),
        );
    if (res.isSuccess) emit(state.copyWith(blog: res.asSuccess.data));
    return res;
  }

  Future<ResponseModel<BlogEntity>> updateBlog({
    required String blogId,
    required Uint8List image,
    required String title,
    required String content,
    required String ownerUserId,
    required List<String> topics,
  }) async {
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
    if (res.isSuccess) emit(state.copyWith(blog: res.asSuccess.data));
    return res;
  }

  Future<ResponseModel<List<BlogEntity>>> getAllBlogs() async {
    final res = await Injection.instance.read<BlogGetAllUseCase>().execute();
    if (res.isSuccess) emit(state.copyWith(allBlogs: res.asSuccess.data));
    return res;
  }
}
