import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/group_chat_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

class BottomLongButton extends StatelessWidget {
  final double height;
  final Function() onPressed;
  final String text;
  final controller;

  const BottomLongButton({
    Key? key,
    required this.height,
    required this.onPressed,
    required this.text,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: controller!.isButtonActivate.value == true ? Palette.main : Palette.data,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          text,
          style: CommonText.BodyBoldWhite,
        ),
      ),
    );
  }
}
