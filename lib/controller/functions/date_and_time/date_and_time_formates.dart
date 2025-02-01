class AppDateFormates {
  // 31/01/2025 Format
  static String slashFormattedDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
