import 'package:flutter/material.dart';
import 'package:wagly/utils/textFrame.dart';

import 'home.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(),
      body: Container(
        child: Center(
          child: Text(
            'Hello PostScreen',
            style: CommonText.BodyBoldMain,
          ),
        ),
      ),
    );
  }
}