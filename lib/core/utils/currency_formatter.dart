import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  /// Menformat nilai Sen (Integer dari database) menjadi format Rupiah.
  /// Contoh: 150000000 (sen) -> Rp 1.500.000
  static String formatFromCents(int cents) {
    final rupiah = cents / 100;
    return _rupiahFormat.format(rupiah);
  }

  /// Menformat nilai Rupiah riil (Double) menjadi format Rupiah string.
  /// Contoh: 1500000.0 -> Rp 1.500.000
  static String format(double amount) {
    return _rupiahFormat.format(amount);
  }

  /// Mengubah Rupiah riil menjadi Sen untuk disimpan ke database.
  /// Contoh: 1500000.0 -> 150000000
  static int toCents(double amount) {
    return (amount * 100).round();
  }

  /// Mengubah Sen dari database menjadi Rupiah riil.
  /// Contoh: 150000000 -> 1500000.0
  static double toRupiahDouble(int cents) {
    return cents / 100.0;
  }
}
