import 'package:flutter/material.dart';
import 'package:waggly/utils/text_frame.dart';
import 'home.dart';

class ChatEditScreen extends StatelessWidget {
  const ChatEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      body: Container(
        child: Center(
          child: Text(
            'Hello ChatEditScreen',
            style: CommonText.BodyBoldMain,
          ),
        ),
      ),
    );
  }
}
