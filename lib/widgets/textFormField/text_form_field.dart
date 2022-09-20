import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:waggly/controller/major/major_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/controller/signUp/sign_up_controller.dart';
import 'package:waggly/model/major/major.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

class RenderTextFormField extends StatelessWidget {
  RenderTextFormField({
    Key? key,
    this.mode,
    this.placeholder,
    this.buttonText,
    this.label,
    this.controller,
    this.onclick,
    this.inputDecoration,
    this.searchList,
    this.universityName,
    this.password,
  }) : super(key: key);
  final mode;
  final placeholder;
  final buttonText;
  final label;
  final controller;
  final onclick;
  final inputDecoration;
  final List<dynamic>? searchList;
  final universityName;
  late String? password;

  String parseTime(int time) {
    if (time % 60 < 10) {
      return "0${time % 60}";
    }
    return "${time % 60}";
  }

  @override
  Widget build(BuildContext context) {
    SignUpController _signUpController = Get.put(SignUpController());
    SignInController _signInController = Get.put(SignInController());
    if (mode == 'withButtonAndLabel') {
      if (label == '학교 이메일') {
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
                child: Row(
                  children: [
                    Flexible(
                      child: Obx(
                        () => TextFormField(
                          readOnly: false,
                          autofocus: true,
                          controller: controller,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _signUpController.emailValidateSuccess.value == true
                                        ? Color.fromRGBO(218, 175, 254, 1)
                                        : Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _signUpController.emailValidateSuccess.value == true
                                          ? Color.fromRGBO(218, 175, 254, 0.5)
                                          : Colors.red),
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: placeholder,
                              hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
                          onChanged: (val) {
                            if (controller.text.isEmpty == true) {
                              _signUpController.emailInputEmpty.value = true;
                            } else if (controller.text.isEmpty == false) {
                              _signUpController.emailInputEmpty.value = false;
                            }
                          },
                          onSaved: (val) {},
                        ),
                      ),
                    ),
                    Obx(
                      () => Container(
                        width: 70.w,
                        margin: EdgeInsets.fromLTRB(8.w, 0.h, 0.w, 0.h),
                        padding: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: _signUpController.emailInputEmpty.value == false
                                  ? Palette.main
                                  : Color.fromRGBO(182, 182, 182, 1)),
                        ),
                        child: Obx(
                          () => TextButton(
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: _signUpController.emailInputEmpty.value == false
                                      ? Palette.main
                                      : Color.fromRGBO(182, 182, 182, 1)),
                            ),
                            onPressed: () {
                              onclick();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        );
      } else if (label == '학과') {
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
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        readOnly: true,
                        autofocus: false,
                        controller: controller,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(218, 175, 254, 1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(218, 175, 254, 0.5),
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            hintText: placeholder,
                            hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
                        onChanged: (val) {},
                        onSaved: (val) {},
                      ),
                    ),
                    Container(
                      width: 70.w,
                      margin: EdgeInsets.fromLTRB(8.w, 0.h, 0.w, 0.h),
                      padding: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Palette.main,
                        ),
                      ),
                      child: TextButton(
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Palette.main,
                          ),
                        ),
                        onPressed: () {
                          onclick();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        );
      } else if (label == '닉네임') {
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
                child: Row(
                  children: [
                    Flexible(
                      child: Obx(
                        () => TextFormField(
                          autofocus: false,
                          controller: controller,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _signUpController.nicknameValidateSuccess.value == true &&
                                            _signUpController.nicknameDuplicateCheckSuccess.value == true
                                        ? Color.fromRGBO(218, 175, 254, 1)
                                        : Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _signUpController.nicknameValidateSuccess.value == true &&
                                              _signUpController.nicknameDuplicateCheckSuccess.value == true
                                          ? Color.fromRGBO(218, 175, 254, 0.5)
                                          : Colors.red.shade200),
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: placeholder,
                              hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
                          onChanged: (val) {
                            if (controller.text.isEmpty == true) {
                              _signUpController.nicknameInputEmpty.value = true;
                            } else if (controller.text.isEmpty == false) {
                              _signUpController.nicknameInputEmpty.value = false;
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 70.w,
                      margin: EdgeInsets.fromLTRB(8.w, 0.h, 0.w, 0.h),
                      padding: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Palette.main,
                        ),
                      ),
                      child: TextButton(
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Palette.main,
                          ),
                        ),
                        onPressed: () {
                          onclick();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        );
      }
    }

    if (mode == 'withButton') {
      return Container(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
        child: Column(
          children: [
            SizedBox(
              height: 34.h,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      readOnly: false,
                      autofocus: true,
                      controller: controller,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _signUpController.emailValidateSuccess.value == true
                                    ? Color.fromRGBO(218, 175, 254, 1)
                                    : Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _signUpController.emailValidateSuccess.value == true
                                      ? Color.fromRGBO(218, 175, 254, 0.5)
                                      : Colors.red),
                              borderRadius: BorderRadius.circular(4)),
                          hintText: placeholder,
                          hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
                      onChanged: (val) {
                        if (controller.text.isEmpty == true) {
                          _signUpController.emailInputEmpty.value = true;
                        } else if (controller.text.isEmpty == false) {
                          _signUpController.emailInputEmpty.value = false;
                        }
                      },
                      onSaved: (val) {},
                    ),
                  ),
                  Container(
                    width: 70.w,
                    margin: EdgeInsets.fromLTRB(8.w, 0.h, 0.w, 0.h),
                    padding: EdgeInsets.fromLTRB(0.w, 3.h, 0.w, 3.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: _signUpController.emailInputEmpty.value == false
                              ? Palette.main
                              : Color.fromRGBO(182, 182, 182, 1)),
                    ),
                    child: TextButton(
                      child: Text(
                        buttonText,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: _signUpController.emailInputEmpty.value == false
                                ? Palette.main
                                : Color.fromRGBO(182, 182, 182, 1)),
                      ),
                      onPressed: () {
                        onclick();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      );
    }

    if (mode == 'withLabel') {
      if (label == '비밀번호' || label == '새로운 비밀번호') {
        _signUpController.focus = FocusNode();
        _signUpController.focus.requestFocus();
      }
      return Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
        child: Column(children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
              ),
              SizedBox(
                width: 8.w,
              ),
              Obx(
                () => _signUpController.count.value != 60 && _signUpController.count.value > 0 && label == '인증번호'
                    ? Text(
                        "${(_signUpController.count.value / 60).floor()}:${parseTime(_signUpController.count.value)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp, color: Color.fromRGBO(149, 149, 149, 1)))
                    : SizedBox(width: 0),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 34.h,
            child: Obx(
              () => TextFormField(
                focusNode: label == '비밀번호' || label == '새로운 비밀번호' ? _signUpController.focus : null,
                autofocus: label == '비밀번호' || label == '학번' || label == '새로운 비밀번호' ? true : false,
                readOnly: label == '학교' ? true : false,
                controller: controller,
                obscureText: placeholder == '비밀번호' || label == '비밀번호' || label == '새로운 비밀번호' || label == '비밀번호 확인'
                    ? true
                    : false,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: label == '인증번호'
                              ? _signUpController.certiNumValidateSuccess.value == true
                                  ? Color.fromRGBO(218, 175, 254, 1)
                                  : Colors.red
                              : label == '학번'
                                  ? _signUpController.classNumberValidateSuccess.value == true
                                      ? Color.fromRGBO(218, 175, 254, 1)
                                      : Colors.red
                                  : label == '비밀번호'
                                      ? _signUpController.passwordValidateSuccess.value == true
                                          ? Color.fromRGBO(218, 175, 254, 1)
                                          : Colors.red
                                      : label == '새로운 비밀번호'
                                          ? _signUpController.passwordValidateSuccess.value == true
                                              ? Color.fromRGBO(218, 175, 254, 1)
                                              : Colors.red
                                          : label == '비밀번호 확인'
                                              ? _signUpController.passwordConfirmValidateSuccess.value == true
                                                  ? Color.fromRGBO(218, 175, 254, 1)
                                                  : Colors.red
                                              : label == '학교'
                                                  ? _signUpController.universityInputEmpty.value == false
                                                      ? Color.fromRGBO(218, 175, 254, 1)
                                                      : Colors.red
                                                  : Color.fromRGBO(218, 175, 254, 1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: label == '인증번호'
                              ? _signUpController.certiNumValidateSuccess.value == true
                                  ? Color.fromRGBO(218, 175, 254, 1)
                                  : Colors.red.shade200
                              : label == '학번'
                                  ? _signUpController.classNumberValidateSuccess.value == true
                                      ? Color.fromRGBO(218, 175, 254, 1)
                                      : Colors.red.shade200
                                  : label == '비밀번호'
                                      ? _signUpController.passwordValidateSuccess.value == true
                                          ? Color.fromRGBO(218, 175, 254, 1)
                                          : Colors.red.shade200
                                      : label == '새로운 비밀번호'
                                          ? _signUpController.passwordValidateSuccess.value == true
                                              ? Color.fromRGBO(218, 175, 254, 1)
                                              : Colors.red.shade200
                                          : label == '비밀번호 확인'
                                              ? _signUpController.passwordConfirmValidateSuccess.value == true
                                                  ? Color.fromRGBO(218, 175, 254, 1)
                                                  : Colors.red.shade200
                                              : label == '학교'
                                                  ? Color.fromRGBO(218, 175, 254, 1)
                                                  : Colors.red.shade200,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                    hintText: label == '학교' ? null : placeholder,
                    hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
                onTap: () {
                  if (label == '비밀번호 확인') {
                    if (_signUpController.passwordConfirmInputValue.value !=
                        _signUpController.passwordInputValue.value) {
                      _signUpController.passwordConfirmValidateSuccess.value = false;
                    } else {
                      _signUpController.passwordConfirmValidateSuccess.value = true;
                    }
                  }
                },
                onChanged: (val) {
                  if (label == '인증번호') {
                    if (controller.text.isEmpty == true) {
                      _signUpController.certiNumberInputEmpty.value = true;
                    } else {
                      _signUpController.certiNumberInputEmpty.value = false;
                    }
                  } else if (label == '비밀번호' || label == '새로운 비밀번호') {
                    if (val.isEmpty == true) {
                      _signUpController.passwordInputEmpty.value = true;
                    } else {
                      _signUpController.passwordInputEmpty.value = false;
                      _signUpController.passwordInputValue.value = val;
                    }
                  } else if (label == '비밀번호 확인') {
                    if (val.isEmpty == true) {
                      _signUpController.passwordConfirmInputEmpty.value = true;
                    } else {
                      _signUpController.passwordConfirmInputEmpty.value = false;
                      _signUpController.passwordConfirmInputValue.value = val;
                      if (val != _signUpController.passwordInputValue.value) {
                        _signUpController.passwordConfirmValidateSuccess.value = false;
                      } else if (val == _signUpController.passwordInputValue.value) {
                        _signUpController.passwordConfirmValidateSuccess.value = true;
                      }
                    }
                  } else if (label == '학번') {
                    if (controller.text.isEmpty == true) {
                      _signUpController.classNumberInputEmpty.value = true;
                    } else {
                      _signUpController.classNumberInputEmpty.value = false;
                    }
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
        ]),
      );
    }

    if (mode == 'searchBar') {
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: 200.h,
            padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
            child: Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: 45,
                    child: TypeAheadField(
                      noItemsFoundBuilder: (context) => Center(
                          child: Text(
                        "학과 검색 결과가 존재하지 않습니다.",
                        style: CommonText.BodyS,
                      )),
                      suggestionsBoxVerticalOffset: 3.0,
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        constraints: BoxConstraints(maxHeight: 200.h),
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        shadowColor: Color(0XFFDAAFFE),
                      ),
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller,
                        onChanged: (value) {
                          if (value.isEmpty == true) {
                            _signUpController.majorInputEmpty.value = true;
                          }
                        },
                        style: CommonText.BodyS,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(218, 175, 254, 1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(218, 175, 254, 0.5),
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            hintText: placeholder,
                            hintStyle: TextStyle(color: Color.fromRGBO(182, 182, 182, 1), fontSize: 12.sp)),
                      ),
                      suggestionsCallback: (String keyword) async {
                        MajorController _majorController = Get.put(MajorController());
                        return await _majorController.getMajorSearchResultList(universityName, keyword);
                      },
                      onSuggestionSelected: (Major suggestion) {
                        controller.text = suggestion.majorName!;
                        _signUpController.selectedMajor = suggestion;
                        _signUpController.majorInputEmpty.value = false;
                      },
                      itemBuilder: (BuildContext context, Major suggestion) {
                        return ListTile(
                          focusColor: Palette.main,
                          title: Text(
                            suggestion.majorName!,
                            style: CommonText.BodyS,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100.0.h,
          ),
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
          child: TextFormField(
            obscureText: placeholder == '비밀번호' ? true : false,
            autofocus: label == '학교' || label == '비밀번호' ? true : false,
            controller: controller,
            onChanged: (value) {
              if (placeholder == '학교 이메일') {
                if (controller.text.isEmpty == true) {
                  _signInController.emailInputEmpty.value = true;
                  print(_signInController.emailInputEmpty.value);
                } else if (controller.text.isEmpty == false) {
                  _signInController.emailInputEmpty.value = false;
                  print(_signInController.emailInputEmpty.value);
                }
              } else if (placeholder == '비밀번호') {
                if (controller.text.isEmpty == true) {
                  _signInController.passwordInputEmpty.value = true;
                  print(_signInController.passwordInputEmpty.value);
                } else if (controller.text.isEmpty == false) {
                  _signInController.passwordInputEmpty.value = false;
                  print(_signInController.passwordInputEmpty.value);
                }
              }
            },
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
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }
}
