import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF08A5C0);

const List<Color> _colorThemes = [
  _customColor,
  Colors.yellow,
  Colors.pink,
  Colors.purple,
  Colors.teal,
  Colors.green,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0
      })
      : assert(selectedColor >= 0 && selectedColor <= _colorThemes.length -1,
            'Colors must be between 0 and ${_colorThemes.length-1}');

  ThemeData theme() {
    return ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: _colorThemes[selectedColor],
        fontFamily: 'BasierCircle',
        );

  }
}
