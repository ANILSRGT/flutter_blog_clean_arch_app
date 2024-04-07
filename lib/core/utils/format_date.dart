import 'package:intl/intl.dart';

final class FormatDate {
  static String formatDateBydMMMyyyy(DateTime date, String localeCode) {
    return DateFormat('d MMM, yyyy', localeCode).format(date);
  }
}
