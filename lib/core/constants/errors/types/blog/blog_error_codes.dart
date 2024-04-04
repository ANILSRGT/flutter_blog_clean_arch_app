import 'package:flutter_blog_clean_arch_app/core/constants/errors/errors.dart';

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
      BlogErrorCodes.uploadBlog => 'Blog creation failed',
      BlogErrorCodes.uploadBlogImageByUploadBlog =>
        'Blog image upload failed by blog creation',
      BlogErrorCodes.uploadBlogImage => 'Blog image upload failed',
      BlogErrorCodes.updateBlog => 'Blog update failed',
      BlogErrorCodes.notFoundBlog => 'Blog not found',
      BlogErrorCodes.getAllBlogs => 'Blogs fetching failed',
    };
  }
}
