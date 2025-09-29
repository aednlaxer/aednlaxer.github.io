import 'package:intl/intl.dart';

final DateFormat _pathFormat = DateFormat('yyyy/MM/dd');

DateTime? parseDateFromPostUrl(String? url) {
  if (url == null) return null;

  final path = url.replaceFirst('/posts/', '');
  final datePart = path.substring(0, 10); // YYYY-MM-DD
  return DateTime.tryParse(datePart);
}

String formatDate(DateTime date) {
  return DateFormat('MMMM d, yyyy').format(date);
}

String formatDateForPath(DateTime date) {
  return _pathFormat.format(date);
}
