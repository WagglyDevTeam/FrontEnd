

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
    final SignInController _signInController = Get.put(SignInController());

    final ScrollController _scrollController = ScrollController();

    List<Map> resultList = [
      {'id': 1,
        'name': '블루킹',
        'gender': 'm',
        'backgroundColor' : '',
        'image': 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb1uc4y%2FbtsgEcYJewm%2FykOSovJlMrmwZ0TfuidXok%2Fimg.png',
        'profileImg': 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F03GIu%2FbtsgTjhD9dk%2FxacFN5SlkNhIlgLEABmbKk%2Fimg.png',
        'major': '18학번 컴퓨터공학과',
        'purpose': ['학업', '취미', '기타'],
       'type':'소통'
      },
      {'id': 2,
        'name': '그린킹',
        'gender': 'f',
        'backgroundColor' : '',
        'image': 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FchgxyL%2FbtsgEafydJt%2FuIgbnfOLBSm6XsEnUAc8z0%2Fimg.png',
        'profileImg': 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F6vHam%2FbtsgTjoo6tH%2FHGMbJLq66uVJqn0IYGZKk0%2Fimg.png',
        'major': '18학번 컴퓨터공학과',
        'purpose': ['학업', '취미', '기타'],
        'type':'소통'
      },
    ];

    return Scaffold(
      body: SizedBox(
       height: MediaQuery.of(context).size.height,
        child: resultList.isNotEmpty ? ListView.builder(
            // controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              return Result(
                  type: resultList[index]['type'] ?? '',
                  name: resultList[index]['name']?? '',
                  image: resultList[index]['image']?? '',
                  profileImage: resultList[index]['profileImg']?? '',
                  gender: resultList[index]['gender']?? '',
              );
            }
        ) :  Container(
          padding: EdgeInsets.only(right: 16.w, left: 16.w),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
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
                        color: Colors.white,
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
              SizedBox(height: 80.h,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("찾으시는 친구가 없어요", style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.black,
                fontFamily: 'NotoSansKR_Bold',),),
              Text("다시 시도해주세요", style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.black,
                fontFamily: 'NotoSansKR_Bold',),),
              SizedBox(height: 30.h,),
              Image.network(
                'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbET2gR%2FbtsgDMMNDqp%2FB1k6bKkhD7Cye7pVEcsBzK%2Fimg.png',
              ),
              SizedBox(height: 30.h,),
              Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Palette.purple,),
                child: TextButton(
                  child: Text(
                    '기존 설정으로 진행하기',
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: (){
                    controller.reFilter.value = false;
                    controller.state.value = 1;
                  },
                ),
              ),
              SizedBox(height: 15.h,),
              Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(width: 1.0, color: Palette.purple),
                  color: Colors.white,),
                child: TextButton(
                  child: Text(
                    '필터 재설정하기',
                    style: TextStyle(
                      color:Palette.purple,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: (){
                    controller.reFilter.value = true;
                    controller.state.value = 1;
                  },
                ),
              ),
              SizedBox(height: 100.h,),
            ],
          )],
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


  Result({Key? key,
    required this.type,
    required this.name,
    required this.image,
    required this.profileImage,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.w, left: 16.w),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffE1F4FF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
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
          SizedBox(height: 30.h,),
          Container(
            width: 160.w,
            height: 30.h,
            padding: EdgeInsets.all(5),
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
                  padding: EdgeInsets.only(top: 3.h),
                  decoration: BoxDecoration(
                    color: Palette.main,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                    child: Text(type ?? '', style: TextStyle( color: Colors.white),textAlign: TextAlign.center,)
                ),
                SizedBox(width: 5.w,),
                Row(
                  children: [
                    Text('#학업'),
                    SizedBox(width: 5.w,),
                    Text('#취직'),
                    SizedBox(width: 5.w,),
                    Text('#기타'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h,),
          Container(
                width: MediaQuery.of(context).size.width - 120.w,
                child: Image.network(image ?? '', ),
          ),
          SizedBox(height: 20.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name ?? '', style: TextStyle(
                  fontFamily: "NotoSansKR",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black)),
                  SizedBox(width: 8.w,),
                  SizedBox(
                    width: 18.w,
                    child: gender == 'm' ?
                    Image.network('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcpRiY6%2FbtsgDM0jeS8%2FfswSWzcDW6UrgUd7DMeTuk%2Fimg.png')
                        : Image.network('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FExVRa%2FbtsgFux3o4z%2F0CqXZ6EHWkXbXL4l9hcgG0%2Fimg.png'),
                  )
                ],
              ),
              SizedBox(height: 8.h,),
              Text('18학번 컴퓨터 공학과'),
            ],
          ),
          SizedBox(height: 30.h),
          Container(
            width: MediaQuery.of(context).size.width - 32.w,
            padding: EdgeInsets.only(top:15.h, bottom: 15.h, right: 20.w, left: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 58.w,
                      child: Image.network(profileImage ?? ''),
                    ),
                    SizedBox(width: 10.w,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 40.w,
                                height: 20.h,
                                padding: EdgeInsets.only(top: 3.h),
                                decoration: BoxDecoration(
                                  color: Palette.main,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(type ?? '', style: TextStyle( color: Colors.white),textAlign: TextAlign.center,)
                            ),
                            SizedBox(width: 5.w,),
                            Text(name ?? '', style: CommonText.TitleS,),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          children: [
                            SizedBox(width: 15.w,),
                            Text('#학업'),
                            SizedBox(width: 5.w,),
                            Text('#취직'),
                            SizedBox(width: 5.w,),
                            Text('#기타'),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10.h,),
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Palette.main,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextButton(
                    onPressed: () {  },
                    child: Text('신청 보내기', style: CommonText.BodyMediumWhite),
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
