import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldDecimalCustom extends StatefulWidget {
  final String? labelText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final bool isDecimal;

  const TextFormFieldDecimalCustom({
    super.key,
    this.labelText,
    this.icon,
    this.keyboardType,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.isDecimal = false,
  });

  @override
  State<TextFormFieldDecimalCustom> createState() =>
      _TextFormFieldDecimalCustomState();
}

class _TextFormFieldDecimalCustomState
    extends State<TextFormFieldDecimalCustom> {
  late final FocusNode _internalFocusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
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

    final decoration = InputDecoration(
      border: outlineInputBorder,
      labelText: widget.labelText,
      filled: true,
      fillColor: Colors.white,
      prefixIcon:
          widget.icon != null
              ? Icon(widget.icon, size: 20, color: Colors.grey)
              : null, // ← Icono al inicio
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _effectiveFocusNode,
        enabled: widget.enabled,
        keyboardType:
            widget.isDecimal
                ? const TextInputType.numberWithOptions(decimal: true)
                : widget.keyboardType,
        inputFormatters:
            widget.isDecimal
                ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))]
                : null,
        onTapOutside: (_) => _effectiveFocusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        decoration: decoration,
        style: const TextStyle(fontSize: 16.0),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
