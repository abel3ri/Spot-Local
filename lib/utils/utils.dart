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

Color getCategoryItemColor(int index) {
  const List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.deepOrange,
    Colors.purple,
    Colors.blue,
    Colors.cyan,
  ];

  return colors[index % colors.length];
}
