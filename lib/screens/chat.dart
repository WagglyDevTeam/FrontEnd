import 'package:flutter/material.dart';
import 'package:waggly/utils/textFrame.dart';

import 'home.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: const HomeAppbar(),
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