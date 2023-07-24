extension NumX on num {
  String toNumberFormatted([int fractionDigits = 2]) {
    // remove trailing zero
    if (this == toInt()) {
      return toInt().toString();
    }

    return toStringAsFixed(fractionDigits);
  }
}
