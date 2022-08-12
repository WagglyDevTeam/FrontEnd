import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:hashtagable/hashtagable.dart';

class InputHashtagField extends StatelessWidget {
  final SocialTextEditingController controller;
  final String hintText;
  // final double height;

  InputHashtagField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // height: height,
      child: HashTagTextField(
        onChanged: (text) {
          if (text[text.length - 2] == ',') {
            controller.text = text + " ";
            controller.selection = TextSelection.collapsed(
                offset: controller.text.lastIndexOf(" "));
          }
        },
        keyboardAppearance: Brightness.light,
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.purple.shade200),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        decoratedStyle: TextStyle(fontSize: 14.0, color: Colors.purple),
      ),
    );
  }
}
