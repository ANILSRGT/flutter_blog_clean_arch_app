import 'package:uuid/uuid.dart';

final class IdGenerate {
  /// UUID v4
  static String generateUUIDV4() {
    return const Uuid().v4();
  }
}
