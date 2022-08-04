import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wagly/utils/colors.dart';
import 'package:wagly/widgets/index.dart';
import 'package:wagly/screens/signIn/signIn.screen.dart';

import '../controllers/postController.dart';
import '../models/post/post.dart';

PageRouteWithAnimation sign = PageRouteWithAnimation(const SignInScreen());

const Color boxBorderColor = Colors.purple;

class HomeScreen extends StatelessWidget {
  // PostController p = Get.put(PostController());
  PostController p = Get.find();

  @override
  Widget build(BuildContext context) {
    print("here2");
    return Scaffold(
      appBar: const HomeAppbar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 10),
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
    );
  }
}

class PostBoxArea extends StatelessWidget {
  final Post post;
  PostBoxArea({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 0.7,
          color: Colors.purple,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // color: Colors.green,
                width: MediaQuery.of(context).size.width * 0.54,
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
                // color: Colors.green.shade300,
                width: MediaQuery.of(context).size.width * 0.249,
                child: Text(
                  "${post.postCreatedAt}",
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
            alignment: Alignment.centerLeft,
            // color: Colors.green.shade300,
            width: MediaQuery.of(context).size.width,
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
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.319,
                child: Text(
                  "시각디자인학과",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                // color: Colors.green.shade300,
                width: MediaQuery.of(context).size.width * 0.47,
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
                          width: 3,
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
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.face,
                          size: 16,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "6000",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_outlined,
                          size: 16,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "6000",
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
    return SizedBox(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (ctx, index) {
            return Row(
              children: [
                Container(
                  height: 85.0,
                  width: 270.0,
                  margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
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
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.purple),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "#취업",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.purple),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "#취업",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.purple),
                                ),
                              ],
                            )
                          ],
                        ),
                      ), // 카테고리, 채팅방이름
                    ],
                  ),
                ),
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
      // child: Text(
      //   "광 고 영 역",
      //   style: TextStyle(
      //     fontSize: 25,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
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
      title: const Text('와글리',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
      actions: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            width: 85,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(sign.slideRitghtToLeft());
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
                // style: ButtonStyle(
                //   padding: EdgeInsets.zero,
                //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //     RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                //   backgroundColor:
                //       MaterialStateProperty.all<Color>(Palette.purple),
                // )),
              ],
            ))
      ],
    );
  }
}
