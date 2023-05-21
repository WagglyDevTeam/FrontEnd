

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<dynamic> resultList = [{'id': 1,'name': '블루킹', 'sex': 'm', 'image': 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb1uc4y%2FbtsgEcYJewm%2FykOSovJlMrmwZ0TfuidXok%2Fimg.png', 'profileImg': 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F03GIu%2FbtsgTjhD9dk%2FxacFN5SlkNhIlgLEABmbKk%2Fimg.png', 'major': '18학번 컴퓨터공학과', 'purpose': ['학업', '취미', '기타'], 'type':'소통'}];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: Result(),
    );
  }
}


class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(68.h);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Palette.lightGray),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Palette.gray,
                    iconSize: 20.0.sp,
                    onPressed: () {
                      Get.toNamed('/matchFilter');
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("친구 찾기", style: CommonText.BodyL))
            ],
          ),
        ),
      ],
    );
  }
}

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text('소통'),
            Text('#학업 #취직 #기타'),
          ],
        ),
        Container(
          child: Text('img'),
        ),
        Column(
          children: [
            Text('블루킹'),
            Text('18학번 컴퓨터 공학과'),
          ],
        ),
        Container(
          child:Column(
            children: [
              Row(
                children: [
                  Text('img'),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('소통'),
                          Text('블루킹'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('#학업'),
                          Text('#취직'),
                          Text('#기타'),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Container(
                child: TextButton(
                  onPressed: () {  },
                  child: Text('신청 보내기'),
                ),
              )
            ],
          ),
        )

      ],
    );
  }
}
