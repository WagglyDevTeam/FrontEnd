import 'package:flutter/material.dart';
import 'package:waggly/screens/signUp.screen.dart';
import 'package:waggly/screens/password.screen.dart';
import 'package:waggly/widgets/index.dart';


PageRouteWithAnimation home = PageRouteWithAnimation(const SignUp());
PageRouteWithAnimation password = PageRouteWithAnimation(const Password());

class BottomTextButton extends StatefulWidget {
  const BottomTextButton({Key? key}) : super(key: key);

  @override
  State<BottomTextButton> createState() => _BottomTextButtonState();
}

class _BottomTextButtonState extends State<BottomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).push(home.slideRitghtToLeft());
            },
            child: Text(
              '회원가입 하기',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Text(
            '|',
            style: TextStyle(color: Color.fromRGBO(182, 182, 182, 1)),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(password.slideRitghtToLeft());
            },
            child: Text(
              '비밀번호 찾기',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            )),
      ],
    );
  }
}
