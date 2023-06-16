import 'package:flutter/material.dart';

class TextFromFieldWidget extends StatelessWidget {
  TextFromFieldWidget(
      {super.key,
      required this.hint,
      required this.prefixIcon,
      required this.controller});
  String hint;
  IconData prefixIcon;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))));
  }
}
