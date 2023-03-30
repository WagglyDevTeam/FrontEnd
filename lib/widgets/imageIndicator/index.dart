import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/colors.dart';

class ImageIndicator extends StatefulWidget {
  ImageIndicator({Key? key}) : super(key: key);

  @override
  _ImageIndicatorState createState() => _ImageIndicatorState();
}

class _ImageIndicatorState extends State<ImageIndicator>
  with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
  controller = AnimationController(
  /// [AnimationController]s can be created with `vsync: this` because of
  /// [TickerProviderStateMixin].
  vsync: this,
  duration: const Duration(seconds: 5),
  )..addListener(() {
  setState(() {});
  });
  controller.repeat(reverse: true);
  super.initState();
  }

  @override
  void dispose() {
  controller.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/loading.png',  width: 80,),
          SizedBox(height: 20.h),
      Container(
        width: MediaQuery.of(context).size.width - 200,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: LinearProgressIndicator(
            backgroundColor: Palette.paper,
            valueColor: AlwaysStoppedAnimation<Color>(Palette.purple),
            color: Palette.purple,
            value: controller.value,
            minHeight: 9,
          ),
        ),
      ),
    ]));
  }
}
