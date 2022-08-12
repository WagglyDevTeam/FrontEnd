import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:waggly/screens/sign_in.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/widgets/index.dart';

import '../controller/post/post_controller.dart';
import '../model/post/post.dart';

PageRouteWithAnimation sign = PageRouteWithAnimation(SignInScreen());

const Color boxBorderColor = Colors.purple;

class HomeScreen extends StatelessWidget {
  PostController p = Get.put(PostController());
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await p.getBoard();
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  AdvertisementArea(), // 광고영역
                  SizedBox(height: 25),
                  PostTitleArea(),
                  Obx(() => PostBoxArea(post: p.bestPost.value)),
                  SizedBox(height: 25),
                  GroupChatRecommendTitleArea(),
                  GroupChatRecommendBoxArea(),
                  SizedBox(height: 25),
                  PostTitleArea(),
                  Obx(() => PostBoxArea(post: p.bestPost.value)),
                ],
              ),
            )
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
    double safeWidth = Get.width - 80;


    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 0.7,
          color: Colors.purple,
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
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: safeWidth * 0.29,
                  child: Text(
                    post.postCreatedAt != null
                        ? DateFormat('yyyy-MM-dd').format(post.postCreatedAt!)
                        : "",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 38,
              alignment: Alignment.centerLeft,
              child: Text(
                "${post.postDesc}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: safeWidth * 0.46,
                  child: Text(
                    "시각디자인학과와건축학과",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey),
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
                            size: 16,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "15",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.purple),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.face,
                            size: 16,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "60000",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.purple),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_outlined,
                            size: 16,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "60000",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Colors.purple),
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
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: [
          Text(
            "예술체육계열 인기글",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          SizedBox(width: 4),
          Icon(Icons.auto_awesome, color: Palette.main, size: 22),
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
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 80,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10.0);
          },
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (ctx, index) {
            return Container(
              height: 85.0,
              width: 270.0,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  width: 0.7,
                  color: Colors.purple,
                ),
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        foregroundImage:
                            AssetImage("assets/images/red_face_big.png"),
                      ),
                      Positioned(
                        top: 27,
                        child: Center(
                          child: Text(
                            "99/99",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), // 참여자 수 얼굴
                  SizedBox(width: 15),
                  SizedBox(
                    width: 170,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 55,
                              height: 25,
                              alignment: Alignment.center,
                              // color: Colors.purple,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "대외활동",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Text(
                                "와글와글 채팅방 이름?이름이름이름",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              "#취업",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.purple),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "#취업",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.purple),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "#취업",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.purple),
                            ),
                          ],
                        )
                      ],
                    ),
                  ), // 카테고리, 채팅방이름
                ],
              ),
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
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: [
          Text(
            "그룹채팅 추천",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
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
      alignment: Alignment.center,
      color: Colors.grey,
      height: 100,
      width: double.infinity,
      child: Text(
        "배 너 / 광 고 영 역",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  const HomeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Text(
        '와글리',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
          width: 85,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Get.toNamed('/signIn');
                  // Navigator.of(context).push(sign.slideRitghtToLeft());
                },
                child: Text("로그인"),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    foreground: Paint()..color = Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
