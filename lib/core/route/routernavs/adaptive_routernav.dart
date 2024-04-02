part of '../my_router.dart';

final class _DefaultRouterNav implements IRouterNav {
  const _DefaultRouterNav({required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  void pop<T extends Object?>({T? result}) {
    navigatorKey.currentState?.pop(result);
  }

  @override
  void popToFirst() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  @override
  Future<T?> push<T extends Object?>(RouteKeys routeKey, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(
      routeKey.path,
      arguments: arguments,
    );
  }

  @override
  Future<T?> pushAndRemoveAll<T extends Object?>(
    RouteKeys routeKey, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeKey.path,
      (route) => route.isFirst,
      arguments: arguments,
    );
  }

  @override
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    RouteKeys routeKey, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeKey.path,
      result: result,
      arguments: arguments,
    );
  }
}
