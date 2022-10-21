import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/header/page_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  SignInController signInController = Get.put(SignInController());
  Status _page = Status.home;
  String _pageTitle = '채팅';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppbar(page: _page, pageTitle: _pageTitle),
      body: Container(
        child: Center(
          child: Text(
            'Hello ChatScreen',
            style: CommonText.BodyBoldMain,
          ),
        ),
      ),
    );
  }
}
