import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/match/match_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/screens/chat/chat_room_screen.dart';
import 'package:waggly/screens/home.dart';
import 'package:waggly/screens/index.dart';
import 'package:waggly/screens/matchFilter/filter.dart';
import 'package:waggly/screens/post/post_home.dart';
import 'package:waggly/screens/user/my_page.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());

    List<Map> resultList = [
      {
        'id': 1,
        'name': '블루킹',
        'gender': 'm',
        'backgroundColor': '',
        'image':
            'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb1uc4y%2FbtsgEcYJewm%2FykOSovJlMrmwZ0TfuidXok%2Fimg.png',
        'profileImg':
            'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F03GIu%2FbtsgTjhD9dk%2FxacFN5SlkNhIlgLEABmbKk%2Fimg.png',
        'major': '18학번 컴퓨터공학과',
        'purpose': ['학업', '취미', '기타'],
        'type': '소통'
      },
      {
        'id': 2,
        'name': '그린킹',
        'gender': 'f',
        'backgroundColor': '',
        'image':
            'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FchgxyL%2FbtsgEafydJt%2FuIgbnfOLBSm6XsEnUAc8z0%2Fimg.png',
        'profileImg':
            'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F6vHam%2FbtsgTjoo6tH%2FHGMbJLq66uVJqn0IYGZKk0%2Fimg.png',
        'major': '18학번 컴퓨터공학과',
        'purpose': ['학업', '취미', '기타'],
        'type': '소통'
      },
      {
        'id': 3,
        'name': '레드킹',
        'gender': 'f',
        'backgroundColor': '',
        'image':
            'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FchgxyL%2FbtsgEafydJt%2FuIgbnfOLBSm6XsEnUAc8z0%2Fimg.png',
        'profileImg':
            'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F6vHam%2FbtsgTjoo6tH%2FHGMbJLq66uVJqn0IYGZKk0%2Fimg.png',
        'major': '18학번 인류학과',
        'purpose': ['학업', '취미', '기타'],
        'type': '소통'
      },
    ];

    final selectedIndex = controller.selectedIndex.value;
    final lastPage = resultList.length - 1;

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: resultList.isNotEmpty
            ? Obx(() => Stack(children: [
                  PageView.builder(
                      controller: controller.pageController.value,
                      pageSnapping: false,
                      onPageChanged: controller.selectedIndex,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: resultList.length,
                      itemBuilder: (context, idx) {
                        return Result(
                          lastPage: lastPage,
                          index: idx,
                          type: resultList[idx]['type'] ?? '',
                          name: resultList[idx]['name'] ?? '',
                          image: resultList[idx]['image'] ?? '',
                          profileImage: resultList[idx]['profileImg'] ?? '',
                          gender: resultList[idx]['gender'] ?? '',
                          major: resultList[idx]['major'] ?? '',
                          purpose: resultList[idx]['purpose'] ?? [],
                        );
                      }),
                ]))
            : Container(
                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "찾으시는 친구가 없어요",
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            color: Colors.black,
                            fontFamily: 'NotoSansKR_Bold',
                          ),
                        ),
                        Text(
                          "다시 시도해주세요",
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            color: Colors.black,
                            fontFamily: 'NotoSansKR_Bold',
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Image.network(
                          'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbET2gR%2FbtsgDMMNDqp%2FB1k6bKkhD7Cye7pVEcsBzK%2Fimg.png',
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Palette.purple,
                          ),
                          child: TextButton(
                            child: Text(
                              '기존 설정으로 진행하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              controller.reFilter.value = false;
                              controller.state.value = 1;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border:
                                Border.all(width: 1.0, color: Palette.purple),
                            color: Colors.white,
                          ),
                          child: TextButton(
                            child: Text(
                              '필터 재설정하기',
                              style: TextStyle(
                                color: Palette.purple,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              controller.reFilter.value = true;
                              controller.state.value = 1;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  String? type;
  String? name;
  String? image;
  String? profileImage;
  String? gender;
  String? major;
  List? purpose;
  int? index;
  int? lastPage;

  Result({
    Key? key,
    required this.type,
    required this.name,
    required this.image,
    required this.profileImage,
    required this.gender,
    required this.purpose,
    required this.major,
    required this.index,
    required this.lastPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MatchFilterController controller = Get.put(MatchFilterController());

    return Container(
      padding: EdgeInsets.only(right: 16.w, left: 16.w),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffE1F4FF),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Palette.gray,
                        iconSize: 20.0.sp,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Text("친구 찾기", style: CommonText.BodyL))
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: 165.w,
                height: 30.h,
                // padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 40.w,
                        height: 20.h,
                        margin: EdgeInsets.only(top: 2.h),
                        decoration: BoxDecoration(
                          color: Palette.main,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          type ?? '',
                          style: TextStyle(
                              fontFamily: "NotoSansKR",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      width: 5.w,
                    ),
                    PurposeBox(
                      purpose: purpose,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120.w,
                child: Image.network(
                  image ?? '',
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(name ?? '',
                              style: TextStyle(
                                  fontFamily: "NotoSansKR",
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                          SizedBox(
                            width: 8.w,
                          ),
                          SizedBox(
                            width: 18.w,
                            child: gender == 'm'
                                ? Image.network(
                                    'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcpRiY6%2FbtsgDM0jeS8%2FfswSWzcDW6UrgUd7DMeTuk%2Fimg.png')
                                : Image.network(
                                    'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FExVRa%2FbtsgFux3o4z%2F0CqXZ6EHWkXbXL4l9hcgG0%2Fimg.png'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        major!,
                        style: TextStyle(
                          fontFamily: "NotoSansKR",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  lastPage == index
                      ? Positioned(
                          top: 10.h,
                          left: 10.w,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.arrow_back_ios_new),
                            color: Palette.main,
                            iconSize: 20.0.sp,
                            onPressed: () {
                              var prevIndex = index! - 1;
                              controller.onPageChange(prevIndex);
                              print(prevIndex);
                            },
                          ),
                        )
                      : index != 0
                          ? Positioned(
                              top: 10.h,
                              left: 10.w,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 52.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.arrow_back_ios_new),
                                      color: Palette.main,
                                      iconSize: 20.0.sp,
                                      onPressed: () {
                                        var prevIndex = index! - 1;
                                        controller.onPageChange(prevIndex);
                                        print(prevIndex);
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.arrow_forward_ios),
                                      color: Palette.main,
                                      iconSize: 20.0.sp,
                                      onPressed: () {
                                        var nextIndex = index! + 1;
                                        controller.onPageChange(nextIndex);
                                        print(nextIndex);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Positioned(
                              top: 10.h,
                              right: 10.w,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.arrow_forward_ios),
                                color: Palette.main,
                                iconSize: 20.0.sp,
                                onPressed: () {
                                  var nextIndex = index! + 1;
                                  controller.onPageChange(nextIndex);
                                  print(nextIndex);
                                },
                              ),
                            )
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                width: MediaQuery.of(context).size.width - 32.w,
                padding: EdgeInsets.only(
                    top: 15.h, bottom: 15.h, right: 20.w, left: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 58.w,
                          child: Image.network(profileImage ?? ''),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 40.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: Palette.main,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      type ?? '',
                                      style: TextStyle(
                                          fontFamily: "NotoSansKR",
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  name ?? '',
                                  style: CommonText.TitleS,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 15.w),
                                PurposeBox(
                                  purpose: purpose,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Palette.main,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child:
                            Text('신청 보내기', style: CommonText.BodyMediumWhite),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PurposeBox extends StatelessWidget {
  List? purpose;

  PurposeBox({Key? key, required this.purpose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '#' + purpose![0],
          style: TextStyle(
            fontFamily: "NotoSansKR",
            fontSize: 12.sp,
            color: Palette.main,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          '#' + purpose![1],
          style: TextStyle(
            fontFamily: "NotoSansKR",
            fontSize: 12.sp,
            color: Palette.main,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          '#' + purpose![2],
          style: TextStyle(
            fontFamily: "NotoSansKR",
            fontSize: 12.sp,
            color: Palette.main,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
