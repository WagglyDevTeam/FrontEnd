import 'package:flutter/material.dart';
import 'package:wagly/utils/colors.dart';
import 'package:wagly/utils/textFrame.dart';
import 'package:wagly/widgets/index.dart';
import 'package:wagly/screens/signIn/signIn.screen.dart';

PageRouteWithAnimation sign = PageRouteWithAnimation(const SignInScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: 110,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(20, 30, 20, 5),
            child: Row(
              children: [
                Text(
                  "예술체육계열 인기글",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(width: 4),
                Icon(Icons.auto_awesome, color: Palette.main, size: 22),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
            padding: EdgeInsets.all(20),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                width: 1,
                color: Colors.purple,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      // color: Colors.green,
                      width: MediaQuery.of(context).size.width * 0.54,
                      child: Text(
                        "누가 교수님 좀 기절시켜줘줘줘줘줘줘줘줘줘줘줘줘줘",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      // color: Colors.green.shade300,
                      width: MediaQuery.of(context).size.width * 0.249,
                      child: Text(
                        "02/18 19:50",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  // color: Colors.green.shade300,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어. 교수님이 3일만 기절했다 일어나시면 좋겠어.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.319,
                      child: Text(
                        "시각디자인학과",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                    Container(
                      // color: Colors.green.shade300,
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.landscape,
                                  size: 16,
                                  color: Colors.purple,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.face,
                                  size: 16,
                                  color: Colors.purple,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "6000",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline_outlined,
                                  size: 16,
                                  color: Colors.purple,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "6000",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
      backgroundColor: Colors.white,
      title: const Text('와글리',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
      actions: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            width: 85,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(sign.slideRitghtToLeft());
                    },
                    child: Text(
                      "로그인",
                      style: CommonText.BodyMediumWhite,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Palette.purple),
                    )),
              ],
            ))
      ],
    );
  }
}
