import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/signUp/sign_up_controller.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signUp/dtos/sign_up_request_dto.dart';
import 'package:waggly/model/signUp/dtos/verify_email_request_dto.dart';
import '../widgets/textFormField/text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _emailInput = TextEditingController();
final _certiNumberInput = TextEditingController();
final _universityInput = TextEditingController();
final _classNumberInput = TextEditingController();
final _majorInput = TextEditingController();
final _passwordInput = TextEditingController();
final _passwordConfirmInput = TextEditingController();
final _nicknameInput = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var steps = 0;

  handleClick(x) {
    setState(() {
      steps = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopBar(),
          SignUpInput(
            steps: steps,
            setSteps: handleClick,
          ),
        ],
      ),
    );
  }
}

// TopBar
class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: 80.h,
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 40.h, right: 8.w),
        child: (IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Color(0xffB6B6B6),
          ),
          iconSize: 20.r,
        )),
      ),
    );
  }
}

// 회원가입 부분
class SignUpInput extends StatefulWidget {
  const SignUpInput({Key? key, this.steps, this.setSteps}) : super(key: key);
  final steps;
  final setSteps;

  @override
  State<SignUpInput> createState() => _SignUpInputState();
}

class _SignUpInputState extends State<SignUpInput> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Title(),
      Step(steps: widget.steps),
      SizedBox(
        height: 58.h,
      ),
      Input(steps: widget.steps),
      SizedBox(
        height: 48.w,
      ),
      Buttons(steps: widget.steps, setSteps: widget.setSteps)
    ]);
  }
}

// Title
class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 0.w, 0.h),
        child: Text(
          '회원가입',
          style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w700, fontSize: 20.sp),
        ));
  }
}

// Step
class Step extends StatefulWidget {
  const Step({Key? key, this.steps}) : super(key: key);
  final steps;

  @override
  State<Step> createState() => _StepState();
}

class _StepState extends State<Step> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.w, 20.h, 0.w, 20.h),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(18.w, 0.h, 2.w, 0.h),
                    padding: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 8.h),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: widget.steps == 0 ? Color(0xffB863FB) : Color(0xffE8E8E8),
                      width: 2,
                    ))),
                    child: Container(
                        alignment: Alignment.center,
                        width: 16.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.steps == 0 ? Color(0xffB863FB) : Color(0xffE8E8E8),
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(color: widget.steps == 0 ? Color(0xffFFFFFF) : Color(0xff959595)),
                        ))),
                Container(
                  height: 22.h,
                  margin: EdgeInsets.fromLTRB(18.w, 8.h, 0.w, 0.h),
                  child: Text(
                    '학교 인증',
                    style: TextStyle(
                      fontSize: widget.steps == 0 ? 16.sp : 10.sp,
                      fontWeight: widget.steps == 0 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 0 ? Color(0xff2B173B) : Color(0xff959595),
                    ),
                  ),
                ),
              ],
            ),
            flex: widget.steps == 0 ? 6 : 2,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(2.w, 0.h, 2.w, 0.h),
                    padding: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 8.h),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: widget.steps == 1 ? Color(0xffB863FB) : Color(0xffE8E8E8),
                      width: 2.w,
                    ))),
                    child: Container(
                        alignment: Alignment.center,
                        width: 16.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.steps == 1 ? Color(0xffB863FB) : Color(0xffE8E8E8),
                        ),
                        child: Text(
                          '2',
                          style: TextStyle(color: widget.steps == 1 ? Color(0xffFFFFFF) : Color(0xff959595)),
                        ))),
                Container(
                  height: 22.h,
                  margin: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 0.h),
                  child: Text(
                    '학교 정보',
                    style: TextStyle(
                      fontSize: widget.steps == 1 ? 16.sp : 10.sp,
                      fontWeight: widget.steps == 1 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 1 ? Color(0xff2B173B) : Color(0xff959595),
                    ),
                  ),
                ),
              ],
            ),
            flex: widget.steps == 1 ? 6 : 2,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(2.w, 0.h, 18.w, 0.h),
                    padding: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 8.h),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: widget.steps == 2 ? Color(0xffB863FB) : Color(0xffE8E8E8),
                      width: 2.w,
                    ))),
                    child: Container(
                        alignment: Alignment.center,
                        width: 16.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.steps == 2 ? Color(0xffB863FB) : Color(0xffE8E8E8),
                        ),
                        child: Text(
                          '3',
                          style: TextStyle(color: widget.steps == 2 ? Color(0xffFFFFFF) : Color(0xff959595)),
                        ))),
                Container(
                  height: 22.h,
                  margin: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 0.h),
                  child: Text(
                    '아이디 생성',
                    style: TextStyle(
                      fontSize: widget.steps == 2 ? 16.sp : 10.sp,
                      fontWeight: widget.steps == 2 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 2 ? Color(0xff2B173B) : Color(0xff959595),
                    ),
                  ),
                ),
              ],
            ),
            flex: widget.steps == 2 ? 6 : 2,
          ),
        ],
      ),
    );
  }
}

// Input
class Input extends StatefulWidget {
  const Input({Key? key, this.steps}) : super(key: key);
  final steps;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final formKey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.find();

  @override
  Widget build(BuildContext context) {
    return widget.steps == 0
        ? Column(
            children: [
              RenderTextFormField(
                mode: 'withButtonAndLabel',
                label: '학교 이메일',
                placeholder: 'abc@email.com',
                buttonText: '인증하기',
                controller: _emailInput,
                onclick: () async {
                  await _signUpController.sendEmailForVerify(_emailInput.text);
                  _signUpController.startTimer();
                },
              ),
              RenderTextFormField(
                mode: 'withLabel',
                label: '인증번호',
                placeholder: '인증번호 입력',
                buttonText: 'test',
                controller: _certiNumberInput,
              ),
            ],
          )
        : widget.steps == 1
            ? Column(
                children: [
                  RenderTextFormField(
                    mode: 'withLabel',
                    label: '학교',
                    placeholder: '학교 입력',
                    controller: _universityInput,
                  ),
                  RenderTextFormField(
                    mode: 'withLabel',
                    label: '학번',
                    placeholder: '학번 입력',
                    controller: _classNumberInput,
                  ),
                  RenderTextFormField(
                    mode: 'withButtonAndLabel',
                    label: '학과',
                    placeholder: '학과 검색',
                    buttonText: '검색하기',
                    controller: _majorInput,
                  ),
                ],
              )
            : Column(
                children: [
                  RenderTextFormField(
                    mode: 'withLabel',
                    label: '비밀번호',
                    placeholder: '영문, 숫자 포함 8자 이상',
                    controller: _passwordInput,
                  ),
                  RenderTextFormField(
                    mode: 'withLabel',
                    label: '비밀번호 확인',
                    placeholder: '영문, 숫자 포함 8자 이상',
                    controller: _passwordConfirmInput,
                  ),
                  RenderTextFormField(
                    mode: 'withButtonAndLabel',
                    label: '닉네임',
                    placeholder: '한글 또는 영문 6자 이하',
                    buttonText: '중복확인',
                    controller: _nicknameInput,
                  ),
                ],
              );
  }
}

// button
class Buttons extends StatefulWidget {
  const Buttons({Key? key, this.steps, this.setSteps}) : super(key: key);
  final steps;
  final setSteps;

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  final SignUpController _signUpController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
        width: double.infinity,
        height: 36.h,
        child: Stack(
          children: [
            if (widget.steps == 0)
              Container(
                width: double.infinity,
                height: 36.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: widget.steps == 0 ? Color(0xffB863FB) : Color(0xffE8E8E8)),
                child: TextButton(
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color: widget.steps == 0 ? Color(0xffFFFFFF) : Color(0xff959595),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () async {
                    final WagglyResponseDto verifyResult = await _signUpController.verifyEmail(
                      VerifyEmailReqeustDto(_emailInput.text, _certiNumberInput.text),
                    );
                    if (_signUpController.emailVerified.value == true) {
                      widget.setSteps(1);
                    } else {
                      print("인증 실패: ${verifyResult.message}");
                    }
                  },
                ),
              ),
            if (widget.steps == 1)
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 155.h,
                      height: 36.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26), color: Color.fromRGBO(218, 175, 254, 0.2)),
                      child: TextButton(
                        child: Text(
                          '이전',
                          style: TextStyle(
                            color: Color(0xffA558E0),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          widget.setSteps(0);
                        },
                      ),
                    ),
                    Container(
                      width: 155.w,
                      height: 36.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Color(0xffE8E8E8),
                      ),
                      child: TextButton(
                        child: Text(
                          '다음',
                          style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          widget.setSteps(2);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.steps == 2)
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 155.w,
                      height: 36.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26), color: Color.fromRGBO(218, 175, 254, 0.2)),
                      child: TextButton(
                        child: Text(
                          '이전',
                          style: TextStyle(
                            color: Color(0xffA558E0),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          widget.setSteps(1);
                        },
                      ),
                    ),
                    Container(
                      width: 155.w,
                      height: 36.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Color(0xffE8E8E8),
                      ),
                      child: TextButton(
                        child: Text(
                          '다음',
                          style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          await _signUpController.signUp(SignUpRequestDto(
                            _emailInput.text,
                            _passwordInput.text,
                            _nicknameInput.text,
                            _universityInput.text,
                            _classNumberInput.text,
                            "17623",
                            // _majorInput.text 임시,
                            'male',
                            // TODO: 성별 받는거 확인
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
