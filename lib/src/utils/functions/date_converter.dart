import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final DateTime date = DateTime.parse(dateString);
  final String formattedDate = DateFormat('MMMM d, yyyy', 'es').format(date);
  return formattedDate;
}
