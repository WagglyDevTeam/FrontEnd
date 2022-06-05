import 'package:flutter/material.dart';
import 'package:wagly/utils/textFrame.dart';
import 'home.dart';

class ChatEditScreen extends StatelessWidget {
  const ChatEditScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(),
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