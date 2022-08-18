import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/utils/text_frame.dart';

import 'home.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
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
