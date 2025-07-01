import 'package:intl/intl.dart';

DateTime? parseBirthday(String? birthdayString) {
  if (birthdayString == null || birthdayString.trim().isEmpty) return null;

  try {
    return DateFormat("dd MM yyyy").parse(birthdayString);
  } catch (_) {
    return null;
  }
}

String formatDatetoString(
  DateTime? datetime, {
  String format = 'dd / MM / yyyy',
}) {
  if (datetime == null) return '-';
  try {
    return DateFormat(format).format(datetime);
  } catch (_) {
    return '-';
  }
}
