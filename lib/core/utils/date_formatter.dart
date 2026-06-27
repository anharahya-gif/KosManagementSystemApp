import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _yMd = DateFormat('yyyy-MM-dd');
  static final DateFormat _dMMMMy = DateFormat('dd MMMM yyyy', 'id_ID');
  static final DateFormat _dMMMy = DateFormat('dd MMM yyyy', 'id_ID');

  /// Memformat objek DateTime ke string ISO 8601 tanggal saja (YYYY-MM-DD)
  static String toIsoDateString(DateTime date) {
    return _yMd.format(date);
  }

  /// Memparse string ISO 8601 (YYYY-MM-DD) ke objek DateTime
  static DateTime parseIsoDateString(String dateStr) {
    return _yMd.parse(dateStr);
  }

  /// Menformat string ISO 8601 tanggal ke format panjang Indonesia
  /// Contoh: "2026-06-28" -> "28 Juni 2026"
  static String formatReadable(String dateStr) {
    try {
      final date = _yMd.parse(dateStr);
      return _dMMMMy.format(date);
    } catch (_) {
      return dateStr;
    }
  }

  /// Menformat string ISO 8601 tanggal ke format pendek Indonesia
  /// Contoh: "2026-06-28" -> "28 Jun 2026"
  static String formatShort(String dateStr) {
    try {
      final date = _yMd.parse(dateStr);
      return _dMMMy.format(date);
    } catch (_) {
      return dateStr;
    }
  }

  /// Menformat objek DateTime ke format panjang Indonesia
  static String formatDateTimeReadable(DateTime date) {
    return _dMMMMy.format(date);
  }
}
