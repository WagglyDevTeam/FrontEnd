import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextStyle? hintStyle;
  final int? maxLines;
  final validator;
  final String? initialValue;
  final controller;

  CustomTextFormField(
      {required this.hint,
      this.hintStyle,
      this.validator,
      this.initialValue,
      this.controller,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      initialValue: initialValue,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      ),
    );
  }
}
