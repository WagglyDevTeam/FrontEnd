import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:waggly/hive/user.dart';

import '../../utils/colors.dart';
import '../../utils/text_frame.dart';

List<String> imageUrlList = [
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/ff74a528-33d1-4119-8123-ddb81f9ead02.jpg",
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/f36e6b05-70e3-4ead-80e5-c7e719bd09d3.jpeg",
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/d999b74b-61e6-4c19-b82d-986341dfaa44.png",
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/cfa56b43-a2c3-45b7-ae3b-9f5be44f1692.png",
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/cfa56b43-a2c3-45b7-ae3b-9f5be44f1692.png",
];

User opponentUser = User(
  id: 25,
  nickName: "고양이 귀여워",
  university: "가나다대학교",
  classNumber: 20,
  gender: 'male',
  major: "산업디자인학과",
  profileImg: "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/cfa56b43-a2c3-45b7-ae3b-9f5be44f1692.png",
);

class ChatRoomDetailScreen extends StatefulWidget {
  const ChatRoomDetailScreen({super.key});

  @override
  State<ChatRoomDetailScreen> createState() => _ChatRoomDetailScreenState();
}

class _ChatRoomDetailScreenState extends State<ChatRoomDetailScreen> {
  bool isToggled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h, top: 10.0.h, bottom: 5.0.h),
                child: SizedBox(
                  height: 30.0.h,
                  child: Text("대화중인 상대", style: CommonText.BodyL),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h, bottom: 10.0.h),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5.0.h),
                      child: SizedBox(
                        height: 58.0.h,
                        width: 58.0.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            opponentUser.profileImg!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10.0.w),
                        child: SizedBox(
                          height: 50.0.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 22.0.h,
                                      child: Text(
                                        opponentUser.nickName!,
                                        style: CommonText.BodyL,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.0.h,
                                    ),
                                    Stack(children: [
                                      Container(
                                        height: 15.0.h,
                                        width: 15.0.w,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black),
                                      ),
                                      Positioned(
                                          top: 0.h,
                                          left: -0.5.w,
                                          child: Icon(
                                            opponentUser.gender == 'female' ? Icons.female : Icons.male,
                                            color: Colors.white,
                                            size: 17,
                                          )),
                                    ]),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  // height: 2.0.h,
                                  ),
                              Text(
                                '${opponentUser.classNumber}학번 ${opponentUser.major!}',
                                style: CommonText.BodyXS,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Divider(
                color: Palette.lightGray,
                thickness: 1.1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h, top: 5.0.h),
                child: SizedBox(
                  height: 30.0.h,
                  child: Text("앨범", style: CommonText.BodyL),
                ),
              ),
              Container(
                height: 90.0.h,
                padding: EdgeInsets.only(top: 5.0.h, left: 20.0.h, right: 20.0.h),
                child: GridView.builder(
                  itemCount: imageUrlList.length >= 4 ? 4 : imageUrlList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
                    // childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
                    mainAxisSpacing: 7, //수평 Padding
                    crossAxisSpacing: 7, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // 마지막 이미지 처리하기
                    if (imageUrlList.length > 4 && index == 3) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 80.0.h,
                            width: 80.0.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                imageUrlList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: GestureDetector(
                              onTap: () => print('click'),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt, // 카메라 아이콘
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: 50.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            imageUrlList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Divider(
                color: Palette.lightGray,
                thickness: 2.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h, top: 5.0.h),
                child: SizedBox(
                  height: 30.0.h,
                  child: Text("채팅방 설정", style: CommonText.BodyL),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0.h, left: 20.0.h, right: 20.0.h, bottom: 10.0.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '알람 끄기',
                          style: CommonText.BodyM,
                        ),
                        SizedBox(width: 10.w),
                        FlutterSwitch(
                          height: 20.0.h,
                          width: 35.0.w,
                          padding: 3.0.r,
                          toggleSize: 15.0,
                          borderRadius: 30.0,
                          activeColor: Palette.main,
                          value: isToggled,
                          onToggle: (value) {
                            setState(() {
                              isToggled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0.h,
                    ),
                    Row(
                      children: [
                        Text(
                          '채팅 고정',
                          style: CommonText.BodyM,
                        ),
                        SizedBox(width: 10.w),
                        FlutterSwitch(
                          height: 20.0.h,
                          width: 35.0.w,
                          padding: 3.0.r,
                          toggleSize: 15.0,
                          borderRadius: 30.0,
                          activeColor: Palette.main,
                          value: isToggled,
                          onToggle: (value) {
                            setState(() {
                              isToggled = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(child: SizedBox(height: double.infinity,)),
              Padding(
                padding: EdgeInsets.only(top: 5.0.h, left: 20.0.h, right: 20.0.h, bottom: 20.0.h),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 30.0.h,
                  decoration: BoxDecoration(
                    color: Palette.main,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextButton(
                    onPressed: () => { print('채팅 나가기 클릭') },
                    child: Text(
                      "채팅 나가기",
                      style: CommonText.BodyBoldWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                onTap: () {
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
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   width: 8.w,
              // ),
              // Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("채팅방 상세", style: CommonText.BodyL))
            ],
          ),
        ),
      ],
    );
  }

  Line() {
    return const SizedBox(
      width: 1,
      height: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              // POINT
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
