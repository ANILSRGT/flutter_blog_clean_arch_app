part of 'blog_cubit.dart';

sealed class BlogState with EquatableMixin {
  const BlogState();

  @override
  List<Object?> get props => [];
}

final class BlogStateInitial extends BlogState {
  const BlogStateInitial();
}

final class BlogStateLoading extends BlogState {
  const BlogStateLoading();
}

final class BlogStateDone extends BlogState {
  const BlogStateDone({
    required this.blog,
  });

  final ResponseModel<BlogEntity> blog;

  @override
  List<Object?> get props => [blog];
}
