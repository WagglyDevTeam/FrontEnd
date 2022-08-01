import 'dart:io';

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
      body: ListView(
        children: <Widget>[
          AdvertisementArea(), // 광고영역
          SizedBox(height: 30),
          PostTitleArea(),
          PostBoxArea(),
          SizedBox(height: 30),
          GroupChatRecommendTitleArea(),
          GroupChatRecommendBoxArea(),
          SizedBox(height: 30), // 여기 그룹채팅 영역
          PostTitleArea(),
          PostBoxArea(),
        ],
      ),
    );
  }
}

class PostBoxArea extends StatelessWidget {
  const PostBoxArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 0.7,
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
              "얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어. 교수님이 3일만 기절했다 일어나시면 좋겠어. 가나다라마바사 아자차카타파하 동해물과백두산이마르고닳도록",
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
                            "15",
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
    );
  }
}

class PostTitleArea extends StatelessWidget {
  const PostTitleArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: [
          Text(
            "예술체육계열 인기글",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          SizedBox(width: 4),
          Icon(Icons.auto_awesome, color: Palette.main, size: 22),
        ],
      ),
    );
  }
}

class GroupChatRecommendBoxArea extends StatelessWidget {
  final File? image;

  GroupChatRecommendBoxArea({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        Container(
          height: 85,
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 0.7,
              color: Colors.purple,
            ),
          ),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    foregroundImage: image != null
                        ? image as ImageProvider
                        : AssetImage("assets/images/red_face_big.png"),
                  ),
                  Positioned(
                    top: 27,
                    child: Center(
                      child: Text(
                        "99/99",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ), // 참여자 수 얼굴
              SizedBox(width: 15),
              Container(
                width: 170,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 55,
                          height: 25,
                          alignment: Alignment.center,
                          // color: Colors.purple,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "대외활동",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: Text(
                            "와글와글 채팅방 이름?이름이름이름",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          "#취업",
                          style: TextStyle(fontSize: 16, color: Colors.purple),
                        ),
                        Text(
                          "#취업",
                          style: TextStyle(fontSize: 16, color: Colors.purple),
                        ),
                        Text(
                          "#취업",
                          style: TextStyle(fontSize: 16, color: Colors.purple),
                        ),
                      ],
                    )
                    // Text("여긴데?222"),
                  ],
                ),
              ), // 카테고리, 채팅방이름
            ],
          ),
        ),
      ],
    );
  }
}

class GroupChatRecommendTitleArea extends StatelessWidget {
  const GroupChatRecommendTitleArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: [
          Text(
            "그룹채팅 추천",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class AdvertisementArea extends StatelessWidget {
  const AdvertisementArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 110,
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
