import 'package:flutter/material.dart';

Color darken(Color color, [double amount = 0.1]) {
  assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');
  final hsl = HSLColor.fromColor(color);
  final darkened = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return darkened.toColor();
}

Color lighten(Color color, [double amount = 0.1]) {
  assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');
  final hsl = HSLColor.fromColor(color);
  final lightened = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  return lightened.toColor();
}

Color? getCategoryItemColor(int index) {
  switch (index) {
    case 0:
      return Colors.red;
    case 1:
      return Colors.green;
    case 2:
      return Colors.orange;
    case 3:
      return Colors.deepOrange;
    case 4:
      return Colors.purple;
    case 5:
      return Colors.blue;
    case 6:
      return Colors.deepOrange;
    default:
      return null;
  }
}
