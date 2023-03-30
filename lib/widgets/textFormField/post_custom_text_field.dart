import 'package:flutter/material.dart';
import 'package:waggly/utils/text_frame.dart';

class PostCustomTextField extends StatelessWidget {
  final String hint;
  final int? maxLines;
  final validator;
  final String? initialValue;
  final mainController;
  final subController;
  final onEditingComplete;
  final onChanged;
  final focus;
  final isActive;

  PostCustomTextField({Key? key,
    required this.hint,
    this.validator,
    this.initialValue,
    this.mainController,
    this.subController,
    this.maxLines,
    this.onEditingComplete,
    this.onChanged,
    this.focus,
    this.isActive
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: CommonText.BodyM,
      controller: mainController,
      maxLines: maxLines ?? 1,
      initialValue: initialValue,
      validator: validator,
      onChanged: (value) {
        onChanged(mainController, subController);
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
