// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wagly/utils/textFrame.dart';


class SignUpRoute extends StatelessWidget {
  const SignUpRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: const SignAppBar(),
      body: Container(
        child: Center(
          child: Text('Hello SignIn' , style: CommonText.BodyB,),
        ),
      )
    );
  }
}

class SignAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
    Size get preferredSize => const Size.fromHeight(50);
    const SignAppBar({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading:null,
        actions: [
          RaisedButton(
            color:Colors.white,
            focusColor: Colors.white,
            hoverColor:Colors.white,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close),
          ),
        ] 
    );
  }
}