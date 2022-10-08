import 'package:flutter/material.dart';
import 'package:waggly/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({required this.text, required this.controller});

  final String text;
  final controller;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Palette.main,
              ),
              child: SizedBox(
                width: 26.0.w,
                height: 26.0.h,
                child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0.w),
                    ),
                    activeColor: Palette.main,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                        widget.controller.checkBox.value = value;
                      });
                    }),
              ),
            ),
            Text(widget.text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ))
          ],
        ),
      ],
    );
  }
}
