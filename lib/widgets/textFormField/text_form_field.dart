import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:waggly/controller/signUp/sign_up_controller.dart';
import 'package:waggly/utils/colors.dart';

class RenderTextFormField extends StatelessWidget {
  const RenderTextFormField({
    Key? key,
    this.mode,
    this.placeholder,
    this.buttonText,
    this.label,
    this.controller,
    this.onclick,
    this.inputDecoration,
  }) : super(key: key);
  final mode;
  final placeholder;
  final buttonText;
  final label;
  final controller;
  final onclick;
  final inputDecoration;

  String parseTime(int time) {
    if (time % 60 < 10) {
      return "0${time % 60}";
    }
    return "${time % 60}";
  }

  @override
  Widget build(BuildContext context) {
    SignUpController _signUpController = Get.put(SignUpController());
    if (mode == 'withButtonAndLabel') {
      return Container(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp)),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              height: 34.h,
              child: Row(children: [
                Flexible(
                  child: TextFormField(
                    controller: controller,
                    obscureText: label == '비밀번호' || label == '비밀번호 확인' ? true : false,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(218, 175, 254, 0.5),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        hintText: placeholder,
                        hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
                    onChanged: (val) {
                      if (label == '학교 이메일' && controller.text.isEmpty == true) {
                        _signUpController.emailInputEmpty.value = true;
                      } else if (label == '학교 이메일' && controller.text.isEmpty == false) {
                        _signUpController.emailInputEmpty.value = false;
                      }
                    },
                    onSaved: (val) {},
                  ),
                ),
                Obx(() => _signUpController.emailInputEmpty.value == true
                    ? Container(
                        width: 70.w,
                        margin: EdgeInsets.fromLTRB(8.w, 0.h, 0.w, 0.h),
                        padding: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 3.h),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Color.fromRGBO(182, 182, 182, 1))),
                        child: TextButton(
                          child: Text(
                            buttonText,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color.fromRGBO(182, 182, 182, 1)),
                          ),
                          onPressed: () {
                            onclick();
                          },
                        ),
                      )
                    : Container(
                        width: 70.w,
                        margin: EdgeInsets.fromLTRB(8.w, 0.h, 0.w, 0.h),
                        padding: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 3.h),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Palette.main)),
                        child: TextButton(
                          child: Text(
                            buttonText,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Palette.main),
                          ),
                          onPressed: () {
                            onclick();
                          },
                        ),
                      ))
              ]),
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      );
    }

    if (mode == 'withButton') {
      Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 1.8.w, 0.h),
        child: Column(children: [
          SizedBox(
            height: 4.h,
          ),
          TextFormField(
            controller: controller,
            obscureText: label == '비밀번호' ? true : false,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(218, 175, 254, 0.5),
                    ),
                    borderRadius: BorderRadius.circular(4)),
                hintText: placeholder,
                hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
            onChanged: (val) {
              print(val);
            },
            onSaved: (val) {},
          ),
          SizedBox(
            height: 12.h,
          ),
        ]),
      );
    }

    if (mode == 'withLabel') {
      return Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
        child: Column(children: [
          Row(
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp)),
              SizedBox(
                width: 8.w,
              ),
              Obx(
                () => _signUpController.count.value != 60 && _signUpController.count.value > 0
                    ? Text("${(_signUpController.count.value / 60).floor()}:${parseTime(_signUpController.count.value)}",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: Color.fromRGBO(149, 149, 149, 1)))
                    : SizedBox(width: 0),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 34.h,
            child: TextFormField(
              controller: controller,
              obscureText: label == '비밀번호' ? true : false,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(218, 175, 254, 0.5),
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  hintText: placeholder,
                  hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
              onChanged: (val) {
                print(val);
              },
              onSaved: (val) {},
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
        ]),
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
          child: TextFormField(
            controller: controller,
            obscureText: label == '비밀번호' ? true : false,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(218, 175, 254, 1))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(218, 175, 254, 0.5),
                    ),
                    borderRadius: BorderRadius.circular(4)),
                hintText: placeholder,
                hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.h)),
            onChanged: (val) {
              print(val);
            },
            onSaved: (val) {},
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }
}

// class RenderTextFormField extends StatefulWidget {
//   const RenderTextFormField(
//       {Key? key, this.mode, this.placeholder, this.buttonText, this.label, this.controller})
//       : super(key: key);
//   final mode;
//   final placeholder;
//   final buttonText;
//   final label;
//   final controller;
//
//   @override
//   State<RenderTextFormField> createState() => _RenderTextFormFieldState();
// }
//
// class _RenderTextFormFieldState extends State<RenderTextFormField> {
//   final formKey = GlobalKey<FormState>();
//   final _counter = 10*1;
//   late Timer _timer;
//
//
// }
