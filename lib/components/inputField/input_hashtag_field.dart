import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:get/get.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:waggly/controller/group_chat_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'dart:ui';

import 'package:waggly/utils/text_frame.dart';

class InputHashtagField extends StatelessWidget {
  final SocialTextEditingController controller;
  final String hintText;
  final onEditingComplete;

  InputHashtagField({required this.controller, required this.hintText, this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // height: height,
      child: HashTagTextField(
        onChanged: (text) {
          //TODO: 쉼표가 붙어있을 경우, 휴대폰의 키보드를 이용해서 해시태그 삭제가 안됨. 키보드 이벤트가 안먹힘.
          if (text.length > 1 && text[text.length - 2] == ',') {
            controller.text = text + " ";
            controller.selection = TextSelection.collapsed(
                offset: controller.text.lastIndexOf(" "));
          }

          if (extractHashTags(controller.text).isNotEmpty) {
            onEditingComplete();
          } else {
            GroupChatController().isButtonActivate.value = false;
          }

          print(controller.text);
          print(extractHashTags(controller.text));
        },
        keyboardAppearance: Brightness.light,
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: CommonText.BodyMediumMain.copyWith(color: Palette.lavender),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        decoratedStyle: TextStyle(fontSize: 14.0, color: Colors.purple),
      ),
    );
  }
}
