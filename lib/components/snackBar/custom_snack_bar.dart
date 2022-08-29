import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static messageSnackbar(BuildContext context, String? message, dynamic margin) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "$message",
        textAlign: TextAlign.center,
      ),
      duration: Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      margin: margin ?? EdgeInsets.only(bottom: 20, left: 40.w, right: 40.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ));
  }
}
