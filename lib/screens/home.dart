import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:waggly/controller/home/home_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/screens/sign_in.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/index.dart';
import 'package:waggly/controller/post/post_controller.dart';
import 'package:waggly/model/post/post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PageRouteWithAnimation sign = PageRouteWithAnimation(SignInScreen());
List<dynamic> groupChatItem = [
  {"a": "b"},
  {"c": "d"},
  {"e": "f"},
  {"g": "h"},
  {"i", "j"}
];

class HomeScreen extends StatelessWidget {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    PostController postController = Get.put(PostController());
    SignInController signInController = Get.put(SignInController());

    return Scaffold(
      backgroundColor: Colors.white,
      //TODO: HomeAppbar와 Body 사이에 약간의 공간이 있는데 뭐지?
      //TODO: 아이폰 하단바 높이 조절해야함
      //TODO: SVG 이미지 배너 왜 안나옴
      appBar: HomeAppbar(),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await homeController.getHome();
        },
        child: ListView(
          children: [
            AdvertisementArea(), // 광고영역
            SizedBox(height: 24.h),
            PostTitleArea(),
            Obx(() => PostBoxArea(post: postController.bestPost.value)),
            SizedBox(height: 24.h),
            GroupChatRecommendTitleArea(),
            GroupChatRecommendBoxArea(),
            SizedBox(height: 24.h),
            PostTitleArea(),
            Obx(() => PostBoxArea(post: postController.bestPost.value)),
          ],
        ),
      ),
    );
  }
}

class PostBoxArea extends StatelessWidget {
  final Post post;

  PostBoxArea({required this.post});

  @override
  Widget build(BuildContext context) {
    SignInController signInController = Get.put(SignInController());
    double safeWidth = Get.width - 72.w;

    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      padding: EdgeInsets.fromLTRB(16.0.w, 12.0.h, 16.0.w, 12.0.h),
      height: 113.5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 0.7,
          color: Palette.lavender,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Skeleton(
        isLoading: post.postTitle != null ? false : true,
        skeleton: SkeletonParagraph(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: safeWidth * 0.7,
                  child: Text(
                    "${post.postTitle}",
                    style: CommonText.BodyL,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: safeWidth * 0.29,
                  child: Text(
                    post.postCreatedAt != null ? DateFormat('MM/dd HH:mm').format(post.postCreatedAt!) : "",
                    style: CommonText.BodyEngGray,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ), // 제목, 날짜
            SizedBox(height: 7.h),
            Container(
              height: 38.h,
              alignment: Alignment.centerLeft,
              child: Obx(
                () => signInController.checkLoggedIn().value == true
                    ? Text(
                        "${post.postDesc}",
                        style: CommonText.BodyM,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : ClipRect(
                        child: Stack(
                          children: [
                            Text(
                              "${post.postDesc}",
                              style: CommonText.BodyM,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                                child: Container(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ), // 내용
            SizedBox(height: 7.h),
            Obx(() => signInController.checkLoggedIn().value == true
                ? MajorAreaLogin(safeWidth: safeWidth)
                : MajorAreaLogout(safeWidth: safeWidth)), // 학과, 이미지, 좋아요, 코멘트 수
          ],
        ),
      ),
    );
  }
}

class MajorAreaLogin extends StatelessWidget {
  MajorAreaLogin({
    Key? key,
    required this.safeWidth,
  }) : super(key: key);

  final double safeWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: safeWidth * 0.46,
          child: Text(
            "치토스양념제조학과",
            style: CommonText.BodyXSmallGray,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: safeWidth * 0.53,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 13.w,
                    color: Palette.violet,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "150",
                    style: CommonText.BodyEngMain.copyWith(fontSize: 10.0.sp),
                  ),
                ],
              ),
              SizedBox(
                width: 5.w,
              ),
              Row(
                children: [
                  Icon(
                    Icons.sentiment_satisfied,
                    size: 13.w,
                    color: Palette.violet,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "60000",
                    style: CommonText.BodyEngMain,
                  ),
                ],
              ),
              SizedBox(
                width: 5.w,
              ),
              Row(
                children: [
                  Icon(
                    Icons.mode_comment_outlined,
                    size: 13.w,
                    color: Palette.violet,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "60000",
                    style: CommonText.BodyEngMain,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MajorAreaLogout extends StatelessWidget {
  const MajorAreaLogout({
    Key? key,
    required this.safeWidth,
  }) : super(key: key);

  final double safeWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: safeWidth * 0.46,
                child: Text(
                  "치토스양념제조학과",
                  style: CommonText.BodyXSmallGray,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: safeWidth * 0.53,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 13.w,
                          color: Palette.violet,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "150",
                          style: CommonText.BodyEngMain.copyWith(fontSize: 10.0.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied,
                          size: 13.w,
                          color: Palette.violet,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "60000",
                          style: CommonText.BodyEngMain,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mode_comment_outlined,
                          size: 13.w,
                          color: Palette.violet,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "60000",
                          style: CommonText.BodyEngMain,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostTitleArea extends StatelessWidget {
  const PostTitleArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(25.w, 0, 20.w, 10.h),
      child: Row(
        children: [
          Text(
            "예술체육계열 인기글",
            style: CommonText.TitleS,
          ),
          SizedBox(width: 4.w),
          Icon(Icons.auto_awesome, color: Palette.main, size: 20.h),
        ],
      ),
    );
  }
}

class GroupChatRecommendBoxArea extends StatelessWidget {
  // final File? image;
  GroupChatRecommendBoxArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isLoggedIn = Get.put(SignInController()).isLoggedIn;

    return SizedBox(
      height: 72.h,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 16.0.w);
          },
          scrollDirection: Axis.horizontal,
          itemCount: groupChatItem.length,
          itemBuilder: (ctx, index) {
            return Row(
              children: [
                if (index == 0) SizedBox(width: 20.0.w),
                Container(
                  height: 85.0.h,
                  width: 217.0.w,
                  padding: EdgeInsets.fromLTRB(12.5.w, 12.5.h, 12.5.w, 12.5.h),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 0.7,
                      color: Palette.lavender,
                    ),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 48.0.w,
                            height: 48.0.h,
                            child: CircleAvatar(
                              radius: 30.0,
                              foregroundImage: AssetImage("assets/images/red_face_big.png"),
                            ),
                          ),
                          Positioned(
                            top: 22.5.h,
                            child: Center(
                              child: Text(
                                "99/99",
                                style: CommonText.BodyEngWhite,
                              ),
                            ),
                          ),
                        ],
                      ), // 참여자 수 얼굴
                      SizedBox(width: 7.w),
                      SizedBox(
                        width: 135.5.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(5.0.w, 3.0.h, 5.0.w, 3.0.h),
                                  height: 14.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Palette.main,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    "대외활동",
                                    style: CommonText.ChipWhite,
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "와글와글 채팅방 이름?이름이름이름",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: CommonText.BodyL,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Obx(
                              //TODO: 리스트로 바꾸기
                              () => isLoggedIn.value == true
                                  ? Row(
                                      children: [
                                        Text(
                                          "#도전",
                                          style: CommonText.BodyXSmallMain,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "#취직",
                                          style: CommonText.BodyXSmallMain,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "#파이팅",
                                          style: CommonText.BodyXSmallMain,
                                        ),
                                      ],
                                    )
                                  : ClipRect(
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "#도전",
                                                style: CommonText.BodyXSmallMain,
                                              ),
                                              SizedBox(width: 3.w),
                                              Text(
                                                "#취직",
                                                style: CommonText.BodyXSmallMain,
                                              ),
                                              SizedBox(width: 3.w),
                                              Text(
                                                "#파이팅",
                                                style: CommonText.BodyXSmallMain,
                                              ),
                                            ],
                                          ),
                                          Positioned.fill(
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                              child: Container(
                                                color: Colors.white.withOpacity(0.1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ), // 카테고리, 채팅방이름
                    ],
                  ),
                ),
                if (index == groupChatItem.length - 1) SizedBox(width: 20.0.w),
              ],
            );
          }),
    );
  }
}

class GroupChatRecommendTitleArea extends StatelessWidget {
  const GroupChatRecommendTitleArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(25.w, 0, 20.w, 10.h),
      child: Row(
        children: [
          Text(
            "그룹채팅 추천",
            style: CommonText.TitleS,
          ),
        ],
      ),
    );
  }
}

class AdvertisementArea extends StatelessWidget {
  const AdvertisementArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 로긴 로그아웃 체크
        if (Get.put(SignInController()).checkLoggedIn().value == true) {
          Get.put(SignInController()).logout();
        }
      },
      child: Container(
        width: double.infinity,
        height: 80.0.h,
        color: Color(0xFFF3F3F3),
        child: Image.asset("assets/images/main_banner.png"),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  double appbarHeight = 68.0.h;

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight);

  HomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInController signInController = Get.find();


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text(
            '와글리',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          actions: <Widget>[
            signInController.checkLoggedIn().value == true
                ? InkWell(
                    onTap: () {
                      // 알림 페이지로 이동
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 15.0.w, top: 7.0.h),
                      width: 36.0.w,
                      height: 36.0.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Palette.lightGray),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications_none,
                            color: Palette.gray,
                            size: 18.w,
                          ),
                          Positioned(
                            top: 1.6.h,
                            left: 11.w,
                            // right: -20,
                            child: Container(
                              width: 6.0.w,
                              height: 6.0.h,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.5.w, color: Colors.white),
                                color: Color(0xFFFF5F5F),
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed('/signInPage');
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16.0.w),
                          alignment: Alignment.center,
                          width: 60.0.w,
                          height: 24.0.h,
                          child: Text(
                            "로그인",
                            style: CommonText.LabelWhite,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.main,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ],
    );
  }
}
