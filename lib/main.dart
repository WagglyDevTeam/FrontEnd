import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/screens/chat.dart';
import 'package:waggly/screens/chat_edit.dart';
import 'package:waggly/screens/index.dart';
import 'package:waggly/screens/my_page.dart';
import 'package:waggly/screens/post.dart';
import 'package:waggly/screens/sign_in.dart';

void main(){
  runApp(HeroApp());
}

class HeroApp extends StatelessWidget {
  const HeroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360,760),
        builder: (context, child){
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
        ],
      );
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Screen(),
    );
  }
}

// stless
