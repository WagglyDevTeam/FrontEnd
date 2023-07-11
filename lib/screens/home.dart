import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waggly/controller/home/home_controller.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/post/dtos/post_response_dto.dart';
import 'package:waggly/screens/user/sign_in.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

PageRouteWithAnimation sign = PageRouteWithAnimation(SignInScreen());
List<dynamic> groupChatItem = [
  {"a": "b"},
  {"c": "d"},
  {"e": "f"},
  {"g": "h"},
  {"i", "j"}
];

HomeController _homeController = Get.find();
SignInController signInController = Get.find();
double bottomAppbarHeight = 55.0;
double appbarHeight = 68.0.h;

class HomeScreen extends StatelessWidget {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //TODO: HomeAppbar와 Body 사이에 약간의 공간이 있는데 뭐지?
      //TODO: 아이폰 하단바 높이 조절해야함
      //TODO: SVG 이미지 배너 왜 안나옴
      appBar: TopAppBar(),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await _homeController.getHome();
        },
        child: ListView(
          children: [
            AdvertisementArea(),
            // 광고영역
            SizedBox(height: 10.h),
            TipBoxArea(),
            SizedBox(height: 10.h),
            // CircleIndicator(),
            SizedBox(height: 24.h),
            Obx(() => PostTitleArea(_homeController.college.value)),
            Obx(() => PostBoxArea(post: _homeController.collegeBestPost.value)),
            SizedBox(height: 24.h),
            // GroupChatRecommendTitleArea(),
            PostTitleArea("다른 계열"),
            SizedBox(height: 5.h),
            Expanded(child: RandomPostBoxArea()),
            // Obx(() => PostBoxArea(post: _homeController.othersBestPost.value)),

          ],
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
          title: Text('와글리', style: CommonText.TitleL),
          actions: [
            InkWell(
              onTap: () async {
                // 알림 페이지로 이동
                await Get.put(NotificationController()).getNotification();
                Get.toNamed('/notification');
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 16.0.w),
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
                      size: 18.r,
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
            ),
          ],
        ),
      ],
    );
  }
}

class PostBoxArea extends StatelessWidget {
  final PostResponseDto post;

  PostBoxArea({required this.post});

  @override
  Widget build(BuildContext context) {
    SignInController signInController = Get.put(SignInController());
    double safeWidth = Get.width - 72.w;
    return InkWell(
      onTap: () {
        signInController
            .checkLoggedIn()
            .value == false
            ? ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "로그인이 필요합니다.",
              textAlign: TextAlign.center,
            ),
            duration: Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: bottomAppbarHeight + 20, left: 50.w, right: 50.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
          ),
        )
            : Get.toNamed("/postDetail/param?postId=7&collegeName=인문계열");
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        padding: EdgeInsets.fromLTRB(16.0.w, 12.0.h, 16.0.w, 12.0.h),
        height: 115.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            width: 0.7,
            color: Palette.lavender,
          ),
        ),
        width: MediaQuery
            .of(context)
            .size
            .width,
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
                      post.postCreatedAt != null ? post.postCreatedAt! : "",
                      style: CommonText.BodyEngGray,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              // 제목, 날짜
              SizedBox(height: 7.h),
              Container(
                height: 38.h,
                alignment: Alignment.centerLeft,
                child: Obx(
                      () =>
                  signInController
                      .checkLoggedIn()
                      .value == true
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
                            filter: ImageFilter.blur(
                                sigmaX: 2.5, sigmaY: 2.5),
                            child: Container(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 내용
              SizedBox(height: 7.h),
              Obx(() =>
              signInController
                  .checkLoggedIn()
                  .value == true
                  ? MajorAreaLogin(safeWidth: safeWidth, post: post)
                  : MajorAreaLogout(safeWidth: safeWidth, post: post)),
              // 학과, 이미지, 좋아요, 코멘트 수
            ],
          ),
        ),
      ),
    );
  }
}

class RandomPostBoxArea extends StatelessWidget {
  const RandomPostBoxArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInController signInController = Get.put(SignInController());
    double safeWidth = Get.width - 72.w;
    return InkWell(
        onTap: () {
          signInController
              .checkLoggedIn()
              .value == false
              ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "로그인이 필요합니다.",
                textAlign: TextAlign.center,
              ),
              duration: Duration(milliseconds: 1000),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                  bottom: bottomAppbarHeight + 20, left: 50.w, right: 50.w),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          )
              : Get.toNamed("/postDetail/param?postId=7&collegeName=인문계열");
        },
        child: Obx(() =>
            Column(
              children: [
            ListView.builder(
            scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _homeController.othersBestPost.length,
                itemBuilder: (context, index) {
               return Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                  padding: EdgeInsets.fromLTRB(16.0.w, 12.0.h, 16.0.w, 12.0.h),
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 0.7,
                      color: Palette.lavender,
                    ),
                  ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child:Skeleton(
                          isLoading: _homeController.othersBestPost[index]
                              .postTitle != null ? false : true,
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
                                      "${_homeController.othersBestPost[index]
                                          .postTitle}",
                                      style: CommonText.BodyL,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: safeWidth * 0.29,
                                    child: Text(
                                      _homeController.othersBestPost[index]
                                          .postCreatedAt != null
                                          ? _homeController
                                          .othersBestPost[index].postCreatedAt!
                                          : "",
                                      style: CommonText.BodyEngGray,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              // 제목, 날짜
                              SizedBox(height: 7.h),
                              Container(
                                height: 38.h,
                                alignment: Alignment.centerLeft,
                                child: Obx(
                                      () =>
                                  signInController
                                      .checkLoggedIn()
                                      .value == true
                                      ? Text(
                                    "${_homeController.othersBestPost[index]
                                        .postDesc}",
                                    style: CommonText.BodyM,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                      : ClipRect(
                                    child: Stack(
                                      children: [
                                        Text(
                                          "${_homeController
                                              .othersBestPost[index].postDesc}",
                                          style: CommonText.BodyM,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Positioned.fill(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 2.5, sigmaY: 2.5),
                                            child: Container(
                                              color: Colors.white.withOpacity(
                                                  0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // 내용
                              SizedBox(height: 7.h),
                              Obx(() =>
                              signInController
                                  .checkLoggedIn()
                                  .value == true
                                  ? MajorAreaLogin(safeWidth: safeWidth, post: _homeController.othersBestPost[index])
                                  : MajorAreaLogout(safeWidth: safeWidth, post: _homeController.othersBestPost[index])),
                              // 학과, 이미지, 좋아요, 코멘트 수
                            ],
                          ),
                        ));
                      }
                  ),
              ]
            )
    ));}
}

class MajorAreaLogin extends StatelessWidget {
  MajorAreaLogin({
    Key? key,
    required this.safeWidth,
    required this.post,
  }) : super(key: key);

  final double safeWidth;
  final PostResponseDto post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: safeWidth * 0.46,
          child: Text(
            "${post.authorMajor}",
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
              if (post.postImageCnt != 0)
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
                      "${post.postImageCnt}",
                      style: CommonText.BodyEngMain.copyWith(fontSize: 10.0.sp),
                    ),
                  ],
                ),
              SizedBox(
                width: 5.w,
              ),
              if (post.postLikeCnt != 0)
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
                      "${post.postLikeCnt}",
                      style: CommonText.BodyEngMain,
                    ),
                  ],
                ),
              SizedBox(
                width: 5.w,
              ),
              if (post.postCommentCnt != 0)
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
                      "${post.postCommentCnt}",
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
    required this.post,
  }) : super(key: key);

  final PostResponseDto post;
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
                  "${post.authorMajor}",
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
                          "${post.postImageCnt}",
                          style: CommonText.BodyEngMain.copyWith(
                              fontSize: 10.0.sp),
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
                          "${post.postLikeCnt}",
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
                          "${post.postCommentCnt}",
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
  PostTitleArea(this.title);

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(25.w, 0, 20.w, 10.h),
      child: Row(
        children: [
          Text(
            "$title 인기글",
            style: CommonText.TitleS,
          ),
          SizedBox(width: 4.w),
          Icon(Icons.auto_awesome, color: Palette.main, size: 20.h),
        ],
      ),
    );
  }
}

class TipBoxArea extends StatelessWidget {
  // final File? image;
  TipBoxArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isLoggedIn = Get
        .put(SignInController())
        .isLoggedIn;
    final _pageController =
    PageController(viewportFraction: 0.8, keepPage: true);

    List<dynamic> items = [
      {
        "id": 1,
        "title": "공강시간에 뭐할까?",
        "type": "꿀팁",
        "description": "선배가 알려주는 알차게 공강 활용하는 방법",
        "img":
        'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb7ky6d%2FbtshjvKkLHs%2FOXiQnTwfhVDInGEGd6Abbk%2Fimg.png',
        "url": "https://money-rabbit-diary.tistory.com/6"
      },
      {
        "id": 2,
        "title": "성북구 맛집 탐방",
        "type": "맛집탐방",
        "description": "성북구의 숨겨진 찐 맛집!",
        "img":
        'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fxh4Kb%2FbtshqyMs7Qp%2FN0UMUMkSMvNie1CwGSkgz1%2Fimg.png',
        "url": 'https://www.google.com'
      },
      {
        "id": 3,
        "title": "공강시간에 뭐할까?",
        "type": "꿀팁",
        "description": "선배가 알려주는 알차게 공강 활용하는 방법",
        "img":
        'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb7ky6d%2FbtshjvKkLHs%2FOXiQnTwfhVDInGEGd6Abbk%2Fimg.png',
        "url": 'https://www.naver.com/'
      },
      {
        "id": 4,
        "title": "공강시간에 뭐할까?",
        "type": "꿀팁",
        "description": "선배가 알려주는 알차게 공강 활용하는 방법",
        "img":
        'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb7ky6d%2FbtshjvKkLHs%2FOXiQnTwfhVDInGEGd6Abbk%2Fimg.png',
        "url": 'https://www.naver.com/'
      },
      {
        "id": 5,
        "title": "공강시간에 뭐할까?",
        "type": "꿀팁",
        "description": "선배가 알려주는 알차게 공강 활용하는 방법",
        "img":
        'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb7ky6d%2FbtshjvKkLHs%2FOXiQnTwfhVDInGEGd6Abbk%2Fimg.png',
        "url": 'https://www.naver.com/'
      },
    ];

    final pages = List.generate(
      items.length,
          (index) =>
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width / 2 - 24.w,
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
            margin: index == 0
                ? EdgeInsets.only(left: 16.w)
                : index == 4
                ? EdgeInsets.only(right: 16.w)
                : EdgeInsets.only(left: 0, right: 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(items[index]['img']), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(items[index]['url']);
                    await launchUrl(url);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8.0.w, 3.0.h, 8.0.w, 3.0.h),
                    decoration: BoxDecoration(
                      color: items[index]["type"] == '꿀팁'
                          ? Color(0xffFFECBC)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20.0.r),
                    ),
                    child: Text(
                      items[index]['type'],
                      style: TextStyle(
                        color: items[index]["type"] == '꿀팁'
                            ? Color(0xffff7a00)
                            : Colors.red,
                        fontSize: 10.0.sp,
                        fontFamily: 'NotoSansKR',
                      ),
                    ),
                  ),
                ), // 참여자 수 얼굴
                SizedBox(height: 7.h),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index]['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CommonText.BodyL,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 70.h,
                        child: Text(
                          items[index]['description'],
                          style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 12.0.sp,
                            fontFamily: 'NotoSansKR',
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              // POINT
                              color: Palette.data,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "자세히보기",
                          style: TextStyle(
                            color: Palette.data,
                            fontSize: 10.0.sp,
                            fontFamily: 'NotoSansKR',
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // 카테고리, 채팅방이름
              ],
            ),
          ),
    );

    return SizedBox(
      child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 16.0.w);
                    },
                    controller: _pageController,
                    itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages[index % pages.length];
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const ScrollingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: Palette.lightGray,
                      activeDotColor: Palette.main),
                )
                ,
              ]
          )
      )
      ,
    );
  }
}
//순수짠거...
class CircleIndicator extends StatelessWidget {
  const CircleIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _homeController.tipState.value == 1 ? 8.w : 6.w,
          height: _homeController.tipState.value == 1 ? 8.h : 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _homeController.tipState.value == 1
                ? Palette.purple
                : Palette.lightGray,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: _homeController.tipState.value == 2 ? 8.w : 6.w,
          height: _homeController.tipState.value == 2 ? 8.h : 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _homeController.tipState.value == 2
                ? Palette.purple
                : Palette.lightGray,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: _homeController.tipState.value == 3 ? 8.w : 6.w,
          height: _homeController.tipState.value == 3 ? 8.h : 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _homeController.tipState.value == 3
                ? Palette.purple
                : Palette.lightGray,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: _homeController.tipState.value == 4 ? 8.w : 6.w,
          height: _homeController.tipState.value == 4 ? 8.h : 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _homeController.tipState.value == 4
                ? Palette.purple
                : Palette.lightGray,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: _homeController.tipState.value == 5 ? 8.w : 6.w,
          height: _homeController.tipState.value == 5 ? 8.h : 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _homeController.tipState.value == 5
                ? Palette.purple
                : Palette.lightGray,
          ),
        ),
      ],
    );
  }
}

class GroupChatRecommendBoxArea extends StatelessWidget {
  // final File? image;
  GroupChatRecommendBoxArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isLoggedIn = Get
        .put(SignInController())
        .isLoggedIn;

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
                  width: 260.0.w,
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
                              foregroundImage:
                              AssetImage("assets/images/red_face_big.png"),
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
                                  padding: EdgeInsets.fromLTRB(
                                      5.0.w, 3.0.h, 5.0.w, 3.0.h),
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
                                  () =>
                              isLoggedIn.value == true
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
                                          style:
                                          CommonText.BodyXSmallMain,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "#취직",
                                          style:
                                          CommonText.BodyXSmallMain,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "#파이팅",
                                          style:
                                          CommonText.BodyXSmallMain,
                                        ),
                                      ],
                                    ),
                                    Positioned.fill(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2, sigmaY: 2),
                                        child: Container(
                                          color: Colors.white
                                              .withOpacity(0.1),
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
                      SizedBox(width: 6.5.w),
                      Stack(
                        children: [
                          Container(
                            width: 36.0.w,
                            height: 36.0.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5.w,
                                color: Palette.light,
                              ),
                              borderRadius: BorderRadius.circular(100.0.w),
                            ),
                          ),
                          Positioned(
                            left: 10.w,
                            top: 10.h,
                            child: SizedBox(
                              width: 16.0.w,
                              height: 16.0.h,
                              child: SvgPicture.asset(
                                'assets/icons/play.svg',
                                color: Palette.iris,
                              ),
                            ),
                          )
                        ],
                      ),
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
        if (Get
            .put(SignInController())
            .checkLoggedIn()
            .value == true) {
          Get.put(SignInController()).logout();
        } else {
          Get.toNamed('/signInPage');
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
