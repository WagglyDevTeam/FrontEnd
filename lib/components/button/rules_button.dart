import 'package:flutter/material.dart';

class RulesButton extends StatelessWidget {
  const RulesButton({
    required this.text,
  });

  final String text;
  // final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.white),
      onTap: () {},
      child: Container(
        alignment: Alignment.centerRight,
        width: 160,
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 7, 14, 7),
          decoration: BoxDecoration(
            color: Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: TextStyle(
              foreground: Paint()..color = Color(0xFF959595),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}