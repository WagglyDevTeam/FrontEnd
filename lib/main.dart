import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wagly/screens/chat.dart';
import 'package:wagly/screens/chatEdit.dart';
import 'package:wagly/screens/index.dart';
import 'package:wagly/screens/myPage.dart';
import 'package:wagly/screens/post.dart';

void main() {
  runApp(const HeroApp());
}

class HeroApp extends StatelessWidget {
  const HeroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wagly',
      home: MyApp(),
      initialRoute: "/",
      getPages: [
        GetPage(
            name: "/",
            page: () => Screen(),
            transition: Transition.leftToRight),
        GetPage(
            name: "/post",
            page: () => PostScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: "/chat",
            page: () => ChatScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: "/myPage",
            page: () => MyPageScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: "/chatEdit",
            page: () => ChatEditScreen(),
            transition: Transition.leftToRight),
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
