import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageIndicator extends StatefulWidget {
  ImageIndicator({Key? key}) : super(key: key);

  @override
  _ImageIndicatorState createState() => _ImageIndicatorState();
}

class _ImageIndicatorState extends State<ImageIndicator> {
  final int _count = 0;
  var imgList = [
    "https://blog.kakaocdn.net/dn/lqgEB/btrHZpYXw7z/BhhbhA1nwpEngejDq7TVA0/img.png",
    "https://blog.kakaocdn.net/dn/cAzaaO/btrHZD3Jlvo/P4Rec5yBcmASmqu8TVZ8xk/img.png",
    "https://blog.kakaocdn.net/dn/dBeQ2Y/btrH1bLIQ6A/cPCBj2thwNsc94EAQvqxH0/img.png",
    "https://blog.kakaocdn.net/dn/tklol/btrH0wW6GEw/WWmTM0sn0fVIzqFFR0iO11/img.png"
  ];

  // Timer? timer;

  // @override
  // void initState() {
  //   if (mounted) {
  //     Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
  //       final isLast = _count == imgList.length - 1;
  //       setState(() => _count = isLast ? 0 : _count + 1);
  //     });
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(child: child, opacity: animation);
          },
          child: Container(
            child: SizedBox(width: 50.0, height: 50.0, child: Image.network(imgList[_count])),
            key: ValueKey<int>(_count),
          ),
        ),
      ],
    );
  }
}
