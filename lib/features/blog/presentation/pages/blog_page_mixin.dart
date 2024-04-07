import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/custom_toast.dart';
import 'package:flutter_blog_clean_arch_app/core/constants/route/route_keys.dart';
import 'package:flutter_blog_clean_arch_app/core/route/my_router.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/blocs/blog/blog_cubit.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/pages/blog_page.dart';

mixin BlogPageMixin on State<BlogPage> {
  BlogCubit get _readBlogCubit => context.read<BlogCubit>();
  BlogCubit get watchBlogCubit => context.watch<BlogCubit>();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    final resBlog = await _readBlogCubit.getAllBlogs();
    if (resBlog.isFail && mounted) {
      CustomToast.show(
        context: context,
        type: CustomToastType.error,
        message: resBlog.asFail.throwMessage,
      );
    }
  }

  void onAddBlog() {
    MyRouter.instance.routerNav.push(RouteKeys.addNewBlog);
  }
}
