import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String? labelText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool? enabled;
  final TextEditingController? controller;

  // Nuevos parámetros
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const TextFormFieldCustom({
    super.key,
    this.labelText,
    this.icon,
    this.keyboardType,
    this.enabled,
    this.controller,
    this.focusNode, // FocusNode opcional
    this.onFieldSubmitted, // Función opcional al enviar
    this.textInputAction, // Acción de teclado opcional
  });

  @override
  Widget build(BuildContext context) {
    // Si no se pasa un FocusNode, creamos uno local

    final outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFA2A8A9),
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(15),
      gapPadding: 4,
    );

    final decoration = InputDecoration(
      border: outlineInputBorder,
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      suffixIcon:
          icon != null ? Icon(icon, size: 20, color: Colors.grey) : null,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        keyboardType: keyboardType,
        enabled: enabled ?? true,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        focusNode: focusNode, // Aplicamos el FocusNode
        controller: controller,
        onFieldSubmitted: (value) {
          // Si se pasa la función onFieldSubmitted, la llamamos
          if (onFieldSubmitted != null) {
            onFieldSubmitted!(value);
          }
          // Después de enviar, movemos el foco al siguiente campo
          FocusScope.of(context);
        },
        decoration: decoration,
        style: const TextStyle(fontSize: 16.0),
        textInputAction:
            textInputAction ?? TextInputAction.next, // Acción por defecto
      ),
    );
  }
}
