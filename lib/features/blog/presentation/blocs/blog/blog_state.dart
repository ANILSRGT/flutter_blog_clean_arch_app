part of 'blog_cubit.dart';

final class BlogState with EquatableMixin {
  const BlogState({
    this.blog,
    this.allBlogs = const [],
  });

  final BlogEntity? blog;
  final List<BlogEntity> allBlogs;

  @override
  List<Object?> get props => [];

  BlogState copyWith({
    BlogEntity? blog,
    List<BlogEntity>? allBlogs,
  }) {
    return BlogState(
      blog: blog ?? this.blog,
      allBlogs: allBlogs ?? this.allBlogs,
    );
  }
}

final class BlogStateInitial extends BlogState {
  const BlogStateInitial();
}
