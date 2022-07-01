import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wagly/utils/textFrame.dart';
import 'package:wagly/widgets/Button/Button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SignInHeader(),
        Button(
          text: '시작하기',
          onPress: () {},
          disabled: true,
        ),
        Button(
          text: '둘러보기',
          onPress: () {},
          theme: 'abled',
        )
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
                padding: const EdgeInsets.fromLTRB(18, 80, 0, 0),
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
