import 'package:intl/intl.dart';

class AppDateFormates {
  // 31/01/2025 Format
  static String slashFormattedDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  // 31-01-2025 Format
  static String barFormattedDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }

  // 2025
  static String yearFormattedDate(DateTime date) {
    return "${date.year}";
  }

// February format
  static String monthFormattedDate(DateTime date) {
    return DateFormat.MMMM().format(date);
  }

// "12:23 AM"
  static String normalFormatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}
