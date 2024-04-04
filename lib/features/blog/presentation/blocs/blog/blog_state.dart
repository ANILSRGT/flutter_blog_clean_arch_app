part of 'blog_cubit.dart';

final class BlogState with EquatableMixin {
  const BlogState({
    this.blog,
  });

  final ResponseModel<BlogEntity>? blog;

  @override
  List<Object?> get props => [];

  BlogState copyWith({
    ResponseModel<BlogEntity>? blog,
  }) {
    return BlogState(
      blog: blog ?? this.blog,
    );
  }
}

final class BlogStateInitial extends BlogState {
  const BlogStateInitial();
}
