import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:waggly/screens/sign_in.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/index.dart';
import 'package:waggly/controller/post/post_controller.dart';
import 'package:waggly/model/post/post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PageRouteWithAnimation sign = PageRouteWithAnimation(SignInScreen());

List<dynamic> groupChatItem = [
  {"a": "b"}, {"c": "d"}, {"e": "f"}, {"g": "h"}, {"i","j"}
];

class HomeScreen extends StatelessWidget {
  PostController p = Get.put(PostController());
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //TODO: HomeAppbar와 Body 사이에 약간의 공간이 있는데 뭐지?
      //TODO: 아이폰 하단바 높이 조절해야함
      //TODO: SVG 이미지 배너 왜 안나옴
      appBar: HomeAppbar(),
      body: Container(
        // transform: Matrix4.translationValues(0, -10, 0),
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await p.getBoard();
          },
          child: ListView(
            children: [
              AdvertisementArea(), // 광고영역
              SizedBox(height: 24.h),
              PostTitleArea(),
              Obx(() => PostBoxArea(post: p.bestPost.value)),
              SizedBox(height: 24.h),
              GroupChatRecommendTitleArea(),
              GroupChatRecommendBoxArea(),
              SizedBox(height: 24.h),
              PostTitleArea(),
              Obx(() => PostBoxArea(post: p.bestPost.value)),
            ],
          ),
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
    double safeWidth = Get.width - 72.w;

    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      padding: EdgeInsets.fromLTRB(16.0.w, 12.0.h, 16.0.w, 12.0.h),
      height: 112.h,
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
            ),
            SizedBox(height: 7.h),
            Container(
              height: 38.h,
              alignment: Alignment.centerLeft,
              child: Text(
                "${post.postDesc}",
                style: CommonText.BodyM,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: safeWidth * 0.46,
                  child: Text(
                    "시각디자인학과와건축학과",
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
                            Icons.landscape,
                            size: 13.r,
                            color: Palette.violet,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "15",
                            style: CommonText.BodyEngMain.copyWith(fontSize: 10.0.r),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.face,
                            size: 13.r,
                            color: Palette.violet,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "6000",
                            style: CommonText.BodyEngMain,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_outlined,
                            size: 13.r,
                            color: Palette.violet,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "6000",
                            style: CommonText.BodyEngMain,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
                if (index == 0) SizedBox(width: 16.0.w),
                Container(
                  height: 85.0.h,
                  width: 217.0.w,
                  padding: EdgeInsets.all(12.5.r),
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
                            )
                          ],
                        ),
                      ), // 카테고리, 채팅방이름
                    ],
                  ),
                ),
                if (index == groupChatItem.length-1) SizedBox(width: 16.0.w),
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
    return Container(
      width: double.infinity,
      height: 80.0.h,
      color: Color(0xFFF3F3F3),
      child: Image.asset("assets/images/main_banner.png"),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
              ],
            )
          ],
        ),
      ],
    );
  }
}
