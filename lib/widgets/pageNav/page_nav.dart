import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors.dart';
import '../../utils/text_frame.dart';

class PageNav extends StatefulWidget {
  const PageNav({
    Key? key,
    this.pageTitle,
    this.noBorder,
  }) : super(key: key);
  final pageTitle;
  final noBorder;

  @override
  State<PageNav> createState() => _PageNavState();
}

class _PageNavState extends State<PageNav> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70.h,
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                margin: EdgeInsets.only(top: 20.h, right: 10.w, left: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Palette.lightGray),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Palette.gray,
                  iconSize: 20.0.r,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                width: 200.w,
                margin: EdgeInsets.only(top: 15.h),
                child: Text(
                  widget.pageTitle,
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Divider(
            thickness: 1,
            height: 1,
            color: widget.noBorder ? Colors.transparent : Palette.paper),
      ],
    );
  }
}
