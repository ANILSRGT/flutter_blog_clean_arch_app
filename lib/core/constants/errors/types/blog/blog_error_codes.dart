import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/localization/local_keys.g.dart';
import 'package:flutter_blog_clean_arch_app/core/extensions/string_extensions.dart';

enum BlogErrorCodes implements IErrorCodesEnum {
  uploadBlog(code: 1),
  uploadBlogImageByUploadBlog(code: 2),
  uploadBlogImage(code: 3),
  updateBlog(code: 4),
  notFoundBlog(code: 5),
  getAllBlogs(code: 6);

  const BlogErrorCodes({required this.code});

  @override
  final int code;

  @override
  String get message {
    return switch (this) {
      BlogErrorCodes.uploadBlog => LocalKeys.errorsBlogUploadBlog.local,
      BlogErrorCodes.uploadBlogImageByUploadBlog =>
        LocalKeys.errorsBlogUploadBlogImageByUploadBlog.local,
      BlogErrorCodes.uploadBlogImage =>
        LocalKeys.errorsBlogUploadBlogImage.local,
      BlogErrorCodes.updateBlog => LocalKeys.errorsBlogUpdateBlog.local,
      BlogErrorCodes.notFoundBlog => LocalKeys.errorsBlogNotFoundBlog.local,
      BlogErrorCodes.getAllBlogs => LocalKeys.errorsBlogGetAllBlogs.local,
    };
  }
}
