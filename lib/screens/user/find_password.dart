import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:waggly/controller/signUp/sign_up_controller.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signUp/dtos/verify_email_request_dto.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/input_validator.dart';
import '../../widgets/textFormField/text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextEditingController _emailInput = TextEditingController();
TextEditingController _certiNumberInput = TextEditingController();
TextEditingController _universityInput = TextEditingController();
TextEditingController _classNumberInput = TextEditingController();
TextEditingController _majorInput = TextEditingController();
TextEditingController _passwordInput = TextEditingController();
TextEditingController _passwordConfirmInput = TextEditingController();
TextEditingController _nicknameInput = TextEditingController();

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({Key? key}) : super(key: key);

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  var steps = 0;

  handleClick(x) {
    setState(() {
      steps = x;
    });
  }

  @override
  initState() {
    Get.put(SignUpController());
    _emailInput.text = '';
    _certiNumberInput.text = '';
    _universityInput.text = '';
    _classNumberInput.text = '';
    _majorInput.text = '';
    _passwordInput.text = '';
    _passwordConfirmInput.text = '';
    _nicknameInput.text = '';
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SignUpController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              SignUpInput(
                steps: steps,
                setSteps: handleClick,
              ),
            ],
          ),
        ),
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
      Column(
        children: [
          SizedBox(
            height: 58.h,
          ),
          Input(steps: widget.steps),
          SizedBox(
            height: 48.w,
          ),
          Buttons(steps: widget.steps, setSteps: widget.setSteps),
        ],
      )
    ]);
  }
}

// Title
class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 23.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(18.w, 0.h, 0.w, 0.h),
        child: Text(
          '비밀번호 찾기',
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
                    '아이디 입력',
                    style: TextStyle(
                      fontSize: widget.steps == 0 ? 16.sp : 10.sp,
                      fontWeight: widget.steps == 0 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 0 ? Color(0xff2B173B) : Color(0xff959595),
                    ),
                  ),
                ),
              ],
            ),
            flex: widget.steps == 0 ? 6 : 4,
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
                    '새로운 비밀번호 입력',
                    style: TextStyle(
                      fontSize: widget.steps == 1 ? 16.sp : 10.sp,
                      fontWeight: widget.steps == 1 ? FontWeight.w700 : FontWeight.w400,
                      color: widget.steps == 1 ? Color(0xff2B173B) : Color(0xff959595),
                    ),
                  ),
                ),
              ],
            ),
            flex: widget.steps == 1 ? 6 : 4,
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
  // final _formKey = GlobalKey<FormState>();
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
                  final String validResult = validateEmail(_emailInput.text);
                  if (validResult.isNotEmpty) {
                    _signUpController.emailValidateSuccess.value = false;
                    CustomSnackBar.messageSnackbar(
                      context,
                      validResult,
                      EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                    );
                  } else {
                    final WagglyResponseDto result = await _signUpController.checkDuplicateEmail(_emailInput.text);
                    if (result.status == '200') {
                      _signUpController.emailValidateSuccess.value = true;
                      CustomSnackBar.messageSnackbar(
                        context,
                        "이메일로 인증번호가 발송되었습니다.",
                        EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                      );
                      await _signUpController.sendEmailForVerify(_emailInput.text);
                      _signUpController.startTimer();
                    } else {
                      _signUpController.emailValidateSuccess.value = false;
                      CustomSnackBar.messageSnackbar(
                        context,
                        "가입된 이메일을 찾을 수 없습니다.",
                        EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                      );
                    }
                  }
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
                    label: '새로운 비밀번호',
                    placeholder: '영문, 숫자 포함 8자 이상',
                    controller: _passwordInput,
                  ),
                  RenderTextFormField(
                    mode: 'withLabel',
                    label: '비밀번호 확인',
                    placeholder: '영문, 숫자 포함 8자 이상',
                    password: _passwordInput.text,
                    controller: _passwordConfirmInput,
                  ),
                ],
              )
            : SizedBox();
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
            Obx(
              () => Container(
                width: double.infinity,
                height: 36.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: _signUpController.emailInputEmpty.value == false &&
                            _signUpController.certiNumberInputEmpty.value == false
                        ? Color(0xffB863FB)
                        : Color(0xffE8E8E8)),
                child: TextButton(
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color: _signUpController.emailInputEmpty.value == false &&
                              _signUpController.certiNumberInputEmpty.value == false
                          ? Color(0xffFFFFFF)
                          : Palette.mdGray,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () async {
                    if (_signUpController.emailVerified == true &&
                        _signUpController.emailValidateSuccess.value == true) {
                      _signUpController.universityInputEmpty.value = false;
                      _universityInput.text = _signUpController.confirmedUniversityName;
                      widget.setSteps(1);
                    } else {
                      final String validResult = validateEmail(_emailInput.text);
                      if (validResult.isNotEmpty) {
                        _signUpController.emailValidateSuccess.value = false;
                        CustomSnackBar.messageSnackbar(
                          context,
                          validResult,
                          EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                        );
                        return;
                      }
                      final WagglyResponseDto verifyResult = await _signUpController.verifyEmail(
                        VerifyEmailReqeustDto(_emailInput.text, _certiNumberInput.text),
                      );
                      if (_signUpController.emailVerified == true) {
                        _signUpController.tempToken = verifyResult.datas['token'];
                        _signUpController.certiNumValidateSuccess.value = true;
                        _universityInput.text = _signUpController.confirmedUniversityName;
                        _signUpController.universityInputEmpty.value = false;
                        widget.setSteps(1);
                      } else {
                        _signUpController.certiNumValidateSuccess.value = false;
                        CustomSnackBar.messageSnackbar(
                          context,
                          verifyResult.message,
                          EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          if (widget.steps == 1)
            SizedBox(
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
                        widget.setSteps(0);
                      },
                    ),
                  ),
                  Obx(
                    () => Container(
                      width: 155.w,
                      height: 36.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: _signUpController.passwordInputEmpty.value == false &&
                                  _signUpController.passwordConfirmInputEmpty.value == false
                              ? Color(0xffB863FB)
                              : Color(0xffE8E8E8)),
                      child: TextButton(
                        child: Text(
                          '변경하기',
                          style: TextStyle(
                            color: _signUpController.passwordInputEmpty.value == false &&
                                    _signUpController.passwordConfirmInputEmpty.value == false &&
                                    _signUpController.emailVerified == true
                                ? Color(0xffFFFFFF)
                                : Palette.mdGray,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          if (_signUpController.passwordInputEmpty.value == false &&
                              _signUpController.passwordConfirmInputEmpty.value == false) {
                            final passwordRegExp = RegExp(r"((?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,16})");
                            if (_passwordInput.text.isEmpty == true) {
                              CustomSnackBar.messageSnackbar(
                                context,
                                "비밀번호를 입력해주세요.",
                                EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                              );
                            } else {
                              final passwordValidateCheck = passwordRegExp.hasMatch(_passwordInput.text);
                              if (passwordValidateCheck == false) {
                                _signUpController.passwordValidateSuccess.value = false;
                                CustomSnackBar.messageSnackbar(
                                  context,
                                  "비밀번호 형식을 확인해주세요.",
                                  EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                                );
                              } else {
                                _signUpController.passwordValidateSuccess.value = true;
                                if (_passwordConfirmInput.text != _passwordInput.text) {
                                  _signUpController.passwordConfirmValidateSuccess.value = false;
                                  CustomSnackBar.messageSnackbar(
                                    context,
                                    "비밀번호가 일치하지 않습니다.",
                                    EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                                  );
                                } else {
                                  _signUpController.passwordConfirmValidateSuccess.value = true;
                                  final result = await _signUpController.resetPassword(
                                      _signUpController.tempToken, _passwordConfirmInput.text);
                                  if (result.code == 200) {
                                    // 성공 시
                                    _signUpController.passwordInputValue.value = '';
                                    _signUpController.passwordConfirmInputValue.value = '';
                                    CustomSnackBar.messageSnackbar(
                                      context,
                                      "비밀번호가 변경되었습니다.",
                                      EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                                    );
                                    await Future.delayed(const Duration(seconds: 2), () {
                                      Get.offAllNamed('/signInPage');
                                    });
                                  } else {
                                    _signUpController.signUpSuccess.value = true;
                                    CustomSnackBar.messageSnackbar(
                                      context,
                                      result.message,
                                      EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                                    );
                                  }
                                }
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Future<bool> nicknameValidateCheck(BuildContext context, bool isComplete) async {
  SignUpController _signUpController = Get.find();

  final nicknameRegExp = RegExp(r"^[A-Za-z0-9가-힣]{2,6}$");
  if (_nicknameInput.text.isEmpty == true) {
    _signUpController.nicknameValidateSuccess.value = false;
    CustomSnackBar.messageSnackbar(
      context,
      "닉네임을 입력해주세요.",
      EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
    );
    return false;
  } else if (nicknameRegExp.hasMatch(_nicknameInput.text) == false) {
    _signUpController.nicknameValidateSuccess.value = false;
    CustomSnackBar.messageSnackbar(
      context,
      "한글, 숫자, 영문 6자 이하로 입력해주세요.",
      EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
    );
    return false;
  } else {
    final result = await _signUpController.checkDuplicateNickname(_nicknameInput.text);
    if (result.code == 200) {
      _signUpController.nicknameValidateSuccess.value = true;
      _signUpController.nicknameDuplicateCheckSuccess.value = true;
      if (isComplete == false) {
        CustomSnackBar.messageSnackbar(
          context,
          "사용 가능한 닉네임입니다.",
          EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
        );
        return true;
      } else {
        return true;
      }
    } else {
      if (result.message == '닉네임이 중복되었습니다.') {
        _signUpController.nicknameValidateSuccess.value = true;
        _signUpController.nicknameDuplicateCheckSuccess.value = false;
        CustomSnackBar.messageSnackbar(
          context,
          "중복된 닉네임이 존재합니다.",
          EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
        );
        return false;
      } else {
        _signUpController.nicknameValidateSuccess.value = true;
        _signUpController.nicknameDuplicateCheckSuccess.value = false;
        CustomSnackBar.messageSnackbar(
          context,
          result.message,
          EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
        );
        return false;
      }
    }
  }
}
