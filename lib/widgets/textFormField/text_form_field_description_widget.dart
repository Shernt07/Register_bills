import 'package:flutter/material.dart';

class TextFormFieldDescriptionCustom extends StatelessWidget {
  final String? labelText;
  final IconData? icon;
  final TextEditingController controller;

  const TextFormFieldDescriptionCustom(
      {super.key, this.labelText, this.icon, required this.controller});

  @override
  Widget build(BuildContext context) {
    //final textController = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFA2A8A9),
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.circular(15),
        gapPadding: 4);

    final decoration = InputDecoration(
      border: outlineInputBorder,
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      //contentPadding: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        child: TextFormField(
          textAlign: TextAlign.start,
          maxLines: null,
          onTapOutside: (event) {
            focusNode.unfocus();
          },
          focusNode: focusNode,
          //controller: textController,
          controller: controller,
          decoration: decoration,
          style: const TextStyle(),
        ),
      ),
    );
  }
}
