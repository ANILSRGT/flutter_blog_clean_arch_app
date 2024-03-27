import 'package:flutter_blog_clean_arch_app/features/auth/auth_inject.dart';
import 'package:get_it/get_it.dart';

final class Injection {
  static Injection instance = Injection._();
  Injection._();

  final GetIt _sl = GetIt.instance;

  Future<void> init() async {
    await _initFeatures();
  }

  Future<void> _initFeatures() async {
    await AuthInject.instance.init(_sl);
  }

  T read<T extends Object>() {
    return _sl.get<T>();
  }
}
