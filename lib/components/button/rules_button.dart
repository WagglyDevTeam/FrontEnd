import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

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
        height: 24.0.h,
        width: 120.0.w,
        child: Container(
          padding: EdgeInsets.fromLTRB(14.0.w, 7.0.h, 14.0.w, 7.0.h),
          decoration: BoxDecoration(
            color: Palette.paper,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: CommonText.Chip.copyWith(
              fontWeight: FontWeight.bold,
              color: Palette.mdGray
            )
            // TextStyle(
            //   foreground: Paint()..color = Color(0xFF959595),
            //   fontWeight: FontWeight.w500,
            //   fontSize: 10,
            // ),
          ),
        ),
      ),
    );
  }
}