import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/controller/Mypage/my_post_list_controller.dart';
import 'package:waggly/model/Mypage/my_page_model.dart';
import 'package:waggly/widgets/MyPage/my_page_comment.dart';
import '../../Post/post_affiliation.dart';
import '../../Post/post_data.dart';

class MyPostListScreen extends StatelessWidget {
  const MyPostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MyPostList(),
    );
  }
}

class MyPostList extends StatefulWidget {
  const MyPostList({Key? key}) : super(key: key);

  @override
  _MyPostListState createState() => _MyPostListState();
}

class _MyPostListState extends State<MyPostList> {
  //항상 위에 있어야한다. 안그럼 렌더안됨..
  @override
  void initState() {
    super.initState();
    getMyComments();
  }

  bool myPost = false;
  List<dynamic> commentList = [];

  final List<PostSpecificData> data = [
    PostSpecificData(
      postId: 12,
      postTitle: "누가 교수님 좀 기절시켜줘",
      postDesc: "얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 ",
      postCreatedAt: "02/18 19:50",
      authorMajor: "시각디자인학과",
      postImageCnt: 3,
      postLikeCnt: 6,
      postCommentCnt: 4,
      isLikedByMe: true,
      isBlind: false,
    ),
    PostSpecificData(
      postId: 13,
      postTitle: "전공 수업 질문",
      postDesc: "스레과~ 다들 전공과목 어떤거 들어? 다른 곳은 어떨지 궁금하다 많이 다르려나? ",
      postCreatedAt: "02/18 19:50",
      authorMajor: "스포츠레저학과",
      postImageCnt: 1,
      postLikeCnt: 68,
      postCommentCnt: 2,
      isLikedByMe: true,
      isBlind: false,
    ),
    PostSpecificData(
      postId: 16,
      postTitle: "다들 노트북 어떤 제품 많이 써?",
      postDesc:
          "내 사촌동생이 이번에 미대 입학해서 노트북 궁금해하던데 추천 좀 해주라! 너네가 노트북을 추천해주면 내 사동의 대학 생활이 달라질거라 확신해 나를 위해 이 글을 누르고 댓글을 써주는 아량을 한번 베풀어 줄 누군가 있을까 여기..?",
      postCreatedAt: "02/18 19:50",
      authorMajor: "시각디자인학과",
      postImageCnt: 3,
      postLikeCnt: 80,
      postCommentCnt: 1,
      isLikedByMe: true,
      isBlind: false,
    ),
    PostSpecificData(
      postId: 17,
      postTitle: "악기 브랜드 뭐써?",
      postDesc: "각자 자기 악기랑 브랜드 알려주라! ",
      postCreatedAt: "02/18 19:50",
      authorMajor: "기악과",
      postImageCnt: 3,
      postLikeCnt: 80,
      postCommentCnt: 2,
      isLikedByMe: true,
      isBlind: false,
    ),
    PostSpecificData(
      postId: 18,
      postTitle: "다들 학교 커리큘럼",
      postDesc: "얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 ",
      postCreatedAt: "02/18 19:50",
      authorMajor: "기악과",
      postImageCnt: 3,
      postLikeCnt: 80,
      postCommentCnt: 1,
      isLikedByMe: true,
      isBlind: false,
    ),
  ];

  //내가 쓴 댓글
  void getMyComments() async {
    final controller = Get.put(MyPostListController());
    for (var i = 0; i < controller.myCommentsList.length; i++) {
      // var comment = controller.myCommentsList[i];
      // commentList.add(
      //   // MyPostListModel(
      //   //   postId: comment.postId,
      //   //   postTitle: comment.postTitle,
      //   //   boardType: comment.boardType,
      //   //   commentId: comment.commentId,
      //   //   commentCreatedAt: comment.commentCreatedAt,
      //   //   commentDesc: comment.commentDesc,
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 28;
    final double itemWidth = size.width / 2;

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Stack(children: [
        Column(children: [
          Stack(
            children: [
              Container(
                height: 70,
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      margin: EdgeInsets.only(top: 20, right: 10, left: 16),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Palette.lightGray),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Palette.gray,
                        iconSize: 20.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    if (myPost)
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 25),
                        child: Text(
                          '내가 쓴 글',
                          style: CommonText.BodyL,
                        ),
                      ),
                    if (!myPost)
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 25),
                        child: Text(
                          '내가 쓴 댓글',
                          style: CommonText.BodyL,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.subject,
                      size: 16.0,
                    ),
                    onPressed: () {
                      setState(() {
                        myPost = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: myPost ? Palette.main : Colors.white,
                      onPrimary: myPost ? Colors.white : Palette.gray,
                      side: BorderSide(
                        width: 0.5,
                        color: myPost ? Colors.white : Palette.light,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 16.0,
                    ),
                    onPressed: () {
                      setState(() {
                        myPost = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: !myPost ? Palette.main : Colors.white,
                      onPrimary: !myPost ? Colors.white : Palette.gray,
                      side: BorderSide(
                        width: 0.5,
                        color: !myPost ? Colors.white : Palette.light,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  ),
                ),
              ],
            ),
          ),
          if (myPost)
            SizedBox(
              height: MediaQuery.of(context).size.height - 140,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          top: 16, bottom: 16, left: 26, right: 26),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                                color: Palette.paper,
                                style: BorderStyle.solid,
                                width: 1),
                          )),
                      child: PostContext(
                        postId: data[index].postId,
                        postTitle: data[index].postTitle,
                        postDesc: data[index].postDesc,
                        postCreatedAt: data[index].postCreatedAt,
                        authorMajor: data[index].authorMajor,
                        postImageCnt: data[index].postImageCnt,
                        postLikeCnt: data[index].postLikeCnt,
                        postCommentCnt: data[index].postCommentCnt,
                        isLikedByMe: data[index].isLikedByMe,
                        isBlind: data[index].isBlind,
                        //postName: postName,
                      ),
                    );
                  }),
            ),
          if (!myPost)
            SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: commentList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 0.5, color: Palette.paper),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 26, right: 26),
                                child: CommentContext(
                                  postId: commentList[index].postId,
                                  postTitle: commentList[index].postTitle,
                                  boardType: commentList[index].boardType,
                                  commentCreatedAt:
                                      commentList[index].commentCreatedAt,
                                  commentId: commentList[index].commentId,
                                  commentDesc: commentList[index].commentDesc,
                                )),
                            Divider(
                                thickness: 0.5,
                                height: 0.5,
                                color: Palette.lightGray),
                          ],
                        ),
                      );
                    }))
        ])
      ]),
    );
  }
}
