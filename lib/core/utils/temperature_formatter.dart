import 'package:weather_app/core/utils/number_formatter.dart';

enum Temperature {
  celcius,
  fahreinheit,
}

extension NumX on num {
  String toDegreeFormatted({Temperature? degree}) {
    final stringValue = toNumberFormatted();
    String result = "$stringValue\u00B0";
    if (degree == Temperature.celcius) {
      return result += 'C';
    }

    if (degree == Temperature.fahreinheit) {
      return result += 'F';
    }

    return result;
  }
}
