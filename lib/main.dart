import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/screens/chat.dart';
import 'package:waggly/screens/chat_edit.dart';
import 'package:waggly/screens/group_chat_create.dart';
import 'package:waggly/screens/index.dart';
import 'package:waggly/screens/my_page.dart';
import 'package:waggly/screens/post.dart';
import 'package:waggly/screens/sign_in.dart';
import 'package:waggly/screens/write.dart';

void main() async {
  runApp(const HeroApp());
}

class HeroApp extends StatelessWidget {
  const HeroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'waggly',
      home: MyApp(),
      initialRoute: "/",
      getPages: [
        GetPage(
            name: "/",
            page: () => Screen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/post",
            page: () => PostScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/chat",
            page: () => ChatScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/myPage",
            page: () => MyPageScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/chatEdit",
            page: () => ChatEditScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/signInPage",
            page: () => SignInScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: "/writePage",
            // page: () => WritePage(),
            // 그룹채팅방 만들기 페이지가 갈 곳이 없어서 임시로 여기에 라우팅 해둠
            page: () => GroupChatCreatePage(),
            transition: Transition.rightToLeft)
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(),
    );
  }
}

// stless
