import 'package:flutter/material.dart';

class TextFormFieldPasswordCustom extends StatefulWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final bool? enabled;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;

  const TextFormFieldPasswordCustom({
    super.key,
    this.labelText,
    this.keyboardType,
    this.enabled,
    this.controller,
    this.onFieldSubmitted,
  });

  @override
  TextFormFieldPasswordCustomState createState() =>
      TextFormFieldPasswordCustomState();
}

class TextFormFieldPasswordCustomState
    extends State<TextFormFieldPasswordCustom> {
  bool passwordEncrypted = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); // Cierra el teclado
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          obscureText: passwordEncrypted,
          keyboardType: widget.keyboardType,
          enabled: widget.enabled,
          controller: widget.controller,
          focusNode: _focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            border: outlineInputBorder,
            labelText: widget.labelText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  passwordEncrypted = !passwordEncrypted;
                });
              },
              child: Icon(
                passwordEncrypted ? Icons.visibility_off : Icons.remove_red_eye,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
