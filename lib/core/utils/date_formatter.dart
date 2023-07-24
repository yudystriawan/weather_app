import 'package:intl/intl.dart';

extension StringX on String {
  String toDateFormatted([String? format]) {
    final date = DateTime.parse(this);
    final formatted = DateFormat(format ?? 'dd MMM yyyy');
    return formatted.format(date);
  }
}

extension DateTimeX on DateTime {
  String toDateFormatted([String? format]) {
    final date = this;
    final formatted = DateFormat(format ?? 'dd MMM yyyy');
    return formatted.format(date);
  }

  String toDayFormatted() {
    final currentDateTime = DateTime.now();
    final tommorowDateTime = currentDateTime.add(const Duration(days: 1));

    final date = this;
    final formatted = DateFormat('EEEE');

    if (date.day == currentDateTime.day) return 'Today';
    if (date.day == tommorowDateTime.day) return 'Tommorow';

    return formatted.format(date);
  }
}
