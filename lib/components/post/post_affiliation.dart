import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waggly/components/Post/post_common.dart';
import 'package:waggly/components/Post/post_detail_screen.dart';
import 'package:waggly/widgets/index.dart';
import '../../utils/colors.dart';
import '../../utils/text_frame.dart';
import './post_app_bar.dart';
import './post_data.dart';

class PostAffiliation extends StatelessWidget {
  final String postName;
  PostAffiliation({Key? key, required this.postName}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    var page = Status.home;
    return Scaffold(
      appBar: PostAppbar(postName: postName, page: page),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
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
    PageRouteWithAnimation detail =
        PageRouteWithAnimation(PostDetail(postId: postId, postName: postName));
    return GestureDetector(
      onTap: () => Navigator.of(context).push(detail.slideLeftToRight()),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(postTitle, style: CommonText.BodyL),
              Text(postCreatedAt, style: CommonText.BodyEngGray),
            ],
          ),
          SizedBox(height: 6),
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
