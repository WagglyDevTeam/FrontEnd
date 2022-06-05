import 'package:flutter/material.dart';
import 'package:wagly/utils/textFrame.dart';

import 'home.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: const HomeAppbar(),
      body: Container(
        child: Center(
          child: Text(
            'Hello MyPageScreen',
            style: CommonText.BodyBoldMain,
          ),
        ),
      ),
    );
  }
}