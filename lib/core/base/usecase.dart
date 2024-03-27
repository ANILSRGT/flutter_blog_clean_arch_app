import 'package:flutter_blog_clean_arch_app/core/base/models/response_model.dart';

abstract interface class UseCase<T> {
  Future<ResponseModel<T>> execute();
}

abstract interface class UseCaseWithParams<T, Params> {
  Future<ResponseModel<T>> execute(Params params);
}

abstract interface class UseCaseNoFuture<T> {
  ResponseModel<T> execute();
}

abstract interface class UseCaseNoFutureWithParams<T, Params> {
  ResponseModel<T> execute(Params params);
}
