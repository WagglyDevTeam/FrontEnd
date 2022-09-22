import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_common.dart';
import 'package:waggly/utils/lang.dart';
import '../../model/postCollege/dtos/post_college_dto.dart';
import '../../utils/colors.dart';
import '../../utils/text_frame.dart';
import 'package:waggly/widgets/header/page_appbar.dart';


class PostAffiliation extends StatelessWidget {
  PostAffiliation({Key? key}) : super(key: key);
  final String postName = Lang().change("${Get.parameters['collegeName']}");
  var page = Status.boardTitle;
  // final String postName = Lang().change("${collegeName}");
  //final String postName = Get.parameters['collegeName'] ?? "";

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageAppbar(pageTitle: postName, page: page),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              /**인기 글*/
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '인기글',
                          style: CommonText.BodyL,
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.auto_awesome,
                          color: Palette.main,
                          size: 17,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 14, bottom: 14, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: Palette.light,
                              style: BorderStyle.solid,
                              width: 1)),
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
                        postName: postName,
                      ),
                    )
                  ],
                ),
              );
            } else {
              /**일반 글*/
              return Container(
                padding:
                    EdgeInsets.only(top: 16, bottom: 16, left: 26, right: 26),
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
                  postName: postName,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class PostContext extends StatelessWidget {
  final postId;
  final postTitle;
  final postDesc;
  final postCreatedAt;
  final authorMajor;
  final postImageCnt;
  final postLikeCnt;
  final postCommentCnt;
  final isLikedByMe;
  final isBlind;
  final postName;

  const PostContext({
    Key? key,
    @required this.postId,
    @required this.postTitle,
    @required this.postDesc,
    @required this.postCreatedAt,
    @required this.authorMajor,
    @required this.postImageCnt,
    @required this.postLikeCnt,
    @required this.postCommentCnt,
    @required this.isLikedByMe,
    @required this.isBlind,
    @required this.postName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/postDetail/$postId"),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(postTitle, style: CommonText.BodyL),
              Text(postCreatedAt, style: CommonText.BodyEngGray),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            child: Text(postDesc, style: CommonText.BodyS),
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(authorMajor, style: CommonText.BodyEngGray),
              CommentSide(
                commentCnt: postCommentCnt,
                likeCnt: postLikeCnt,
                imgCnt: postImageCnt,
              )
            ],
          )
        ],
      ),
    );
  }
}
