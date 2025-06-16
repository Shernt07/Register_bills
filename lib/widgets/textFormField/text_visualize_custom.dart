import 'package:flutter/material.dart';

class TextVisualizeCustom extends StatelessWidget {
  final String labelText;
  final String value;
  final IconData? icon;

  const TextVisualizeCustom({
    super.key,
    required this.labelText,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFA2A8A9),
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(15),
      gapPadding: 4,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: outlineInputBorder,
          suffixIcon:
              icon != null ? Icon(icon, size: 20, color: Colors.grey) : null,
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 16.0),
          softWrap: true,
        ),
      ),
    );
  }
}
