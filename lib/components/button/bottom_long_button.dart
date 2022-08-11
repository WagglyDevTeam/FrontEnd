import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomLongButton extends StatelessWidget {
  final double height;
  final Function() onPressed;
  final String text;

  const BottomLongButton({
    Key? key, required this.height, required this.onPressed, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            letterSpacing: 2.0,
            foreground: Paint()..color = Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          backgroundColor: Colors.purple,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }
}