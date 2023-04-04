import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waggly/widgets/button/bottom_text_button.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/input_validator.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/Button/button.dart';
import 'package:waggly/screens/home.dart';
import 'package:waggly/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/textFormField/text_form_field.dart';

PageRouteWithAnimation home = PageRouteWithAnimation(HomeScreen());

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  bool isChecked = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  setChecked() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _signInController = Get.put(SignInController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SignInHeader(),
                RenderTextFormField(label: '학교 이메일', placeholder: 'abc@example.com', controller: _emailController),
                RenderTextFormField(label: '비밀번호', placeholder: '비밀번호', controller: _passwordController),
                // CustomCheckbox(text: '자동로그인'),
                Padding(
                  padding: EdgeInsets.fromLTRB(18, 8, 18, 0),
                  child: Obx(
                    () => Container(
                      width: double.infinity,
                      height: 36.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: _signInController.emailInputEmpty.value == false && _signInController.passwordInputEmpty.value == false ? Color(0xffB863FB) : Color(0xffE8E8E8)),
                      child: TextButton(
                        child: Text(
                          '시작하기',
                          style: TextStyle(
                            color: _signInController.emailInputEmpty.value == false && _signInController.passwordInputEmpty.value == false ? Color(0xffFFFFFF) : Palette.mdGray,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () async {
                          final String validResult = validateEmail(_emailController.text);
                          if (validResult.isNotEmpty) {
                            _signInController.emailValidateSuccess.value = false;
                            CustomSnackBar.messageSnackbar(
                              context,
                              validResult,
                              EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                            );
                          } else {
                            final result = await _signInController.signIn(SignInRequestDto(_emailController.text, _passwordController.text));
                            if (result.code == 200) {
                              Get.offAllNamed("/");
                            } else {
                              CustomSnackBar.messageSnackbar(
                                context,
                                result.message,
                                EdgeInsets.only(bottom: 20, left: 20.w, right: 20.w),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Button(
                  text: '둘러보기',
                  onPress: () {
                    Navigator.of(context).push(home.slideRitghtToLeft());
                  },
                  theme: 'abled',
                ),
                SizedBox(
                  height: 18,
                ),
                BottomTextButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInHeader extends StatelessWidget {
  const SignInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 55, 0, 0),
            child: Text(
              '로그인',
              style: CommonText.TitleM,
            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top:50.h),
            height: 250.h,
            child: Image.asset(
              'assets/images/logo.png',
             width: 211.w,
             //width: MediaQuery.of(context).size.width < 850 ? 270 : 300,
            ),
          )
        ],
      ),
    );
  }
}
