import 'package:flutter/material.dart';
import 'package:waggly/utils/text_frame.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final int? maxLines;
  final validator;
  final String? initialValue;
  final controller;
  final onChanged;

  CustomTextFormField({
    required this.hint,
    this.validator,
    this.initialValue,
    this.controller,
    this.maxLines,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      initialValue: initialValue,
      validator: validator,
      onEditingComplete: () {
        onChanged();
      },
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: CommonText.BodyMediumGray,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      ),
    );
  }
}
