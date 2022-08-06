import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/Button/button.dart';
import 'package:waggly/components/SignIn/Checkbox/checkbox.dart';
import 'package:waggly/components/SignIn/BottomTextButton/bottom_text_button.dart';
import 'package:waggly/screens/home.dart';
import 'package:waggly/widgets/index.dart';

import '../widgets/textFormField/text_form_field.dart';

PageRouteWithAnimation home = PageRouteWithAnimation(HomeScreen());

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  bool isChecked = false;

  setChecked() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SignInHeader(),
          RenderTextFormField(
            placeholder: '학교 이메일',
          ),
          RenderTextFormField(
            placeholder: '비밀번호',
          ),
          CustomCheckbox(),
          Button(
            text: '시작하기',
            onPress: () {
              Navigator.of(context).push(home.slideRitghtToLeft());
            },
            disabled: true,
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
    );
  }
}

class SignInHeader extends StatelessWidget {
  const SignInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Flexible(
          fit: FlexFit.loose,
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
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  'assets/icons/wagleLoginBg.svg',
                  width: MediaQuery.of(context).size.width < 850 ? 270 : 500,
                ),
              )
            ],
          ),
        ));
  }
}
