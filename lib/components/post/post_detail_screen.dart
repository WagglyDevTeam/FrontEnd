// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waggly/components/Post/post_affiliation.dart';
import 'package:waggly/components/Post/post_app_bar.dart';
import 'package:waggly/components/Post/post_common.dart';
import 'package:waggly/components/Post/post_data.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

class PostDetail extends StatelessWidget {
  final postId;
  final postName;
  final detailData = PostDetailData(
      postId: 12,
      postTitle: "교수님 기절바람",
      postDesc: "얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어",
      postCreatedAt: "02/18 19:50",
      postImages: [],
      postLikeCnt: 6,
      postCommentCnt: 4,
      isLikedByMe: true,
      authorId: 6,
      authorMajor: "시각디자인학과",
      authorNickname: "포스팅라이트",
      authorProfileImg:
          'https://cdn.pixabay.com/photo/2022/05/28/06/39/cat-7226671_960_720.jpg',
      isBlind: false);

  final List<CommentData> commentData = [
    CommentData(
        commentId: 2,
        commentCreatedAt: "02.18 19:50",
        commentLikeCnt: 4,
        commentDesc: "ㅋㅋㅋㅋㅋㅋㅋ완전 웃겨ㅋ 사실 안웃겨",
        isLikedByMe: true,
        authorId: 4,
        authorMajor: "시각디자인학과",
        authorNickname: "익명",
        authorProfileImg:
            "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
        isBlind: false,
        replies: [
          ReCommentData(
              replyId: 2,
              replyCreatedAt: "02.18 19:50",
              replyLikeCnt: 4,
              replyDesc: "어 나도 탑승할게...",
              isLikedByMe: true,
              authorId: 4,
              authorMajor: "시각디자인학과",
              authorNickname: "익명",
              authorProfileImg:
                  "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
              isBlind: false),
          ReCommentData(
              replyId: 3,
              replyCreatedAt: "02.18 19:50",
              replyLikeCnt: 4,
              replyDesc: "너도..? 나두...",
              isLikedByMe: true,
              authorId: 6,
              authorMajor: "시각디자인학과",
              authorNickname: "포스팅라이트",
              authorProfileImg:
                  "https://cdn.pixabay.com/photo/2022/05/28/06/39/cat-7226671_960_720.jpg",
              isBlind: false),
          ReCommentData(
              replyId: 3,
              replyCreatedAt: "02.18 19:50",
              replyLikeCnt: 4,
              replyDesc: "너도..? 나두...",
              isLikedByMe: true,
              authorId: 3,
              authorMajor: "시각디자인학과",
              authorNickname: "탈퇴자",
              authorProfileImg:
                  "https://cdn.pixabay.com/photo/2022/05/28/06/39/cat-7226671_960_720.jpg",
              isBlind: false),
        ]),
    CommentData(
        commentId: 2,
        commentCreatedAt: "02.18 19:50",
        commentLikeCnt: 4,
        commentDesc: "ㅋㅋㅋㅋㅋㅋㅋ완전 웃겨ㅋ 사실 안웃겨",
        isLikedByMe: true,
        authorId: 4,
        authorMajor: "시각디자인학과",
        authorNickname: "익명",
        authorProfileImg:
            "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
        isBlind: false,
        replies: [])
  ];

  PostDetail({Key? key, @required this.postId, @required this.postName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var page = Status.detail;
    return Scaffold(
      appBar: PostAppbar(postName: postName, page: page),
      body: Container(
        color: Colors.white,
        child: Column(children: [
          DetailContext(detailData: detailData, commentData: commentData)
        ]),
      ),
    );
  }
}

class DetailContext extends StatelessWidget {
  final PostDetailData detailData;
  final List<CommentData> commentData;

  DetailContext({Key? key, required this.detailData, required this.commentData})
      : super(key: key);

  @override
  double size = 1.0;

  Widget build(BuildContext context) {
    var data = detailData;
    var comments = commentData;
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthorForm(
                image: data.authorProfileImg,
                nickName: data.authorNickname,
                major: data.authorMajor ?? '',
                shape: Shape.posting,
                isMaster: false,
              ),
              Text(data.postCreatedAt ?? '', style: CommonText.BodyEngGray),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 7, left: 16, right: 16, bottom: 7),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(data.postTitle ?? '', style: CommonText.BodyL),
            SizedBox(
              height: 5,
            ),
            Text(data.postDesc, style: CommonText.BodyM),
          ]),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: data.postImages.isEmpty ? 0 : 95,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: PostDifferentList(
            widgetList: [
              for (var i = 0; i < data.postImages.length; i++)
                Container(
                  width: data.postImages.isEmpty ? 0 : 95,
                  height: data.postImages.isEmpty ? 0 : 95,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(data.postImages[i]),
                          fit: BoxFit.cover)),
                )
            ],
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DetailBtn(
                    name: '좋아요',
                    svg: 'assets/icons/sentiment.svg',
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DetailBtn(
                    name: '즐겨찾기',
                    svg: 'assets/icons/star.svg',
                    onTap: () {},
                  ),
                ],
              ),
              CommentSide(
                imgCnt: data.postImages.length,
                likeCnt: data.postLikeCnt,
                commentCnt: data.postCommentCnt,
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 320,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentForm(
                  comment: comments[index], postingAuthorId: data.authorId);
            },
          ),
        ),
        Container(
          height: 20,
          child: TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Hint',
          )),
        )
      ]),
    );
  }
}

class DetailBtn extends StatelessWidget {
  final String name;
  final String svg;
  final void Function()? onTap;
  const DetailBtn(
      {Key? key, required this.name, required this.svg, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.5,
          color: Palette.lightGray,
        ),
      ),
      child: GestureDetector(
          onTap: onTap,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svg,
                  fit: BoxFit.scaleDown,
                  width: 16,
                  height: 16,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  name,
                  style: CommonText.BodyEngMain,
                )
              ])),
    );
  }
}

class DetailComment extends StatelessWidget {
  final PostDetailData detailData;
  const DetailComment({Key? key, required this.detailData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
