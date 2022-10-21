import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:waggly/controller/chat/group_chat_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'dart:ui';

import 'package:waggly/utils/text_frame.dart';

class InputHashtagField extends StatelessWidget {
  final SocialTextEditingController controller;
  final String hintText;
  final onChanged;

  InputHashtagField({required this.controller, required this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // TODO: 입력 방식이 불편하지는 않은지? 해시태그마다 # 을 쳐줘야하는데
      child: HashTagTextField(
        basicStyle: CommonText.BodyM,
        onChanged: (text) {
          if (text.length > 1 && text[text.length - 2] == ',') {
            controller.text = controller.text.replaceFirst(",", " ");
            controller.selection = TextSelection.collapsed(offset: controller.text.lastIndexOf(" "));
          }

          if (extractHashTags(controller.text).isNotEmpty) {
            onChanged();
          } else {
            GroupChatController().isButtonActivate.value = false;
            onChanged();
          }
        },
        keyboardAppearance: Brightness.light,
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
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
