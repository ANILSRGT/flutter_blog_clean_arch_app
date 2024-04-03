import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(const BlogState());
}
