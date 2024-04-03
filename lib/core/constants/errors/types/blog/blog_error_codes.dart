import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';

enum BlogErrorCodes implements IErrorCodesEnum {
  uploadBlog(code: 1),
  uploadBlogImage(code: 2),
  updateBlog(code: 3);

  const BlogErrorCodes({required this.code});

  @override
  final int code;

  @override
  String get message {
    return switch (this) {
      BlogErrorCodes.uploadBlog => 'Blog creation failed',
      BlogErrorCodes.uploadBlogImage => 'Blog image upload failed',
      BlogErrorCodes.updateBlog => 'Blog update failed',
    };
  }
}
