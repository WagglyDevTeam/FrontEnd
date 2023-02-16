import 'package:flutter/material.dart';
import 'package:waggly/utils/text_frame.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final int? maxLines;
  final validator;
  final String? initialValue;
  final controller;
  final onEditingComplete;
  final onChanged;
  final focus;

  CustomTextFormField({
    required this.hint,
    this.validator,
    this.initialValue,
    this.controller,
    this.maxLines,
    this.onEditingComplete,
    this.onChanged,
    this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: CommonText.BodyM,
      controller: controller,
      maxLines: maxLines ?? 1,
      initialValue: initialValue,
      validator: validator,
      onChanged: (value) {
        onChanged;
      },
      onEditingComplete: () {
        onEditingComplete;
      },
      autofocus: focus,
      autocorrect: false,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: CommonText.BodyMediumGray,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      ),
    );
  }
}
