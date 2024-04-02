import 'package:flutter_blog_clean_arch_app/core/constants/route/route_keys.dart';

abstract interface class IRouterNav {
  Future<T?> push<T extends Object?>(RouteKeys routeKey, {Object? arguments});
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    RouteKeys routeKey, {
    TO? result,
    Object? arguments,
  });
  Future<T?> pushAndRemoveAll<T extends Object?>(
    RouteKeys routeKey, {
    Object? arguments,
  });
  void pop<T extends Object?>({T? result});
  void popToFirst();
}
