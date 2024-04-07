import 'package:flutter_blog_clean_arch_app/core/base/iinject.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/blog_remote_date_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_local_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/data_sources/iblog_remote_data_source.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/data/repositories/blog_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/repositories/iblog_repository.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_get_all.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_update_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/domain/usecases/blog_upload_usecase.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/presentation/blocs/blog/blog_cubit.dart';
import 'package:get_it/get_it.dart';

final class BlogInject implements IInject {
  BlogInject._();
  static BlogInject instance = BlogInject._();

  @override
  Future<void> init(GetIt sl) async {
    // Data Sources
    sl
      ..registerFactory<IBlogRemoteDataSource>(
        () => BlogRemoteDataSource(supabaseClient: sl()),
      )
      ..registerFactory<IBlogLocalDataSource>(
        () => BlogLocalDataSource(box: sl()),
      )
      // Repositories
      ..registerFactory<IBlogRepository>(
        () => BlogRepository(
          remoteDataSource: sl(),
          localDataSource: sl(),
          connectionChecker: sl(),
        ),
      )
      // Use Cases
      ..registerFactory(() => BlogUploadUseCase(blogRepository: sl()))
      ..registerFactory(() => BlogUpdateUseCase(blogRepository: sl()))
      ..registerFactory(() => BlogGetAllUseCase(blogRepository: sl()))
      // Blocs
      ..registerLazySingleton(BlogCubit.new);
  }
}
