import 'package:flutter/material.dart';
import 'package:wagly/utils/textFrame.dart';
import 'package:wagly/widgets/index.dart';
import 'package:wagly/widgets/signIn.dart';

PageRouteWithAnimation sign = PageRouteWithAnimation(const SignUpRoute());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(),
      body: Container(
        child: Center(
          child: Text(
            'Hello world',
            style: CommonText.BodyBoldMain,
          ),
        ),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);
  const HomeAppbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor:Colors.white,
      title: const Text('와글리',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
      actions: <Widget>[
        Container(
          width: 150,
          padding: const EdgeInsets.all(7.0),
          child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(40.0) // POINT
                        ),
                border: Border.all(width: 2.0, color: const Color(0xFFE8E8E8)),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, top: 5, right: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 주 축 기준 중앙
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(sign.slideRitghtToLeft());
                      },
                      child: const Text("로그인"),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        primary: Colors.black,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center,
                        fixedSize: const Size.fromHeight(0),
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
