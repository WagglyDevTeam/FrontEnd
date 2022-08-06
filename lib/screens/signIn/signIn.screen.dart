import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wagly/utils/textFrame.dart';
import 'package:wagly/widgets/Button/Button.dart';
import 'package:wagly/widgets/TextFormFiled/TextFormFiled.dart';
import 'package:wagly/components/SignIn/Checkbox/Checkbox.dart';
import 'package:wagly/components/SignIn/BottomTextButton/BottomTextButton.dart';
import 'package:wagly/screens/home.dart';
import 'package:wagly/widgets/index.dart';

PageRouteWithAnimation home = PageRouteWithAnimation(const HomeScreen());

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
        RenderTextFormField(placeholder: '학교 이메일',),
        RenderTextFormField(placeholder: '비밀번호',),

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
    ));
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
