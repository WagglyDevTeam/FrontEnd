import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:waggly/components/post/post_modal.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:get/get.dart';

import '../../controller/postDetail/post_detail_controller.dart';

class PostDifferentList extends StatelessWidget {
  PostDifferentList({Key? key, required this.widgetList}) : super(key: key);
  List<Widget> widgetList;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
            child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widgetList.length,
          itemBuilder: (context, index) {
            return widgetList[index];
          },
        )));
  }
}

class CommentSide extends StatelessWidget {
  int? imgCnt;
  int? likeCnt;
  int? commentCnt;

  CommentSide({
    Key? key,
    this.imgCnt,
    this.likeCnt,
    this.commentCnt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/imgs.svg',
              fit: BoxFit.scaleDown,
              width: 16,
              height: 16,
            ),
            Text(imgCnt?.toString() ?? '', style: CommonText.BodyEngMain11),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/sentiment.svg',
              fit: BoxFit.scaleDown,
              width: 16,
              height: 16,
            ),
            Text(likeCnt?.toString() ?? '', style: CommonText.BodyEngMain11),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/commentRectangle.svg',
              fit: BoxFit.scaleDown,
              width: 16,
              height: 16,
            ),
            Text(commentCnt?.toString() ?? '', style: CommonText.BodyEngMain11),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        SizedBox(
          width: 3,
        ),
      ]),
    );
  }
}

enum Shape { posting, comment }

enum CommentShape { top, bottom }

class CommentBox extends StatelessWidget {
  final int authorId;
  final String authorMajor;
  final String authorNickname;
  final String authorProfileImg;
  final bool isBlind;
  final int commentId;
  final String commentCreatedAt;
  final String? commentDeletedAt;
  final int commentLikeCnt;
  final String commentDesc;
  final bool isLikedByMe;
  final CommentShape shape;
  final int postAuthorId;
  // final bool isAnonymous;
  CommentBox({
    Key? key,
    required this.authorId,
    required this.authorMajor,
    required this.authorNickname,
    required this.authorProfileImg,
    required this.isBlind,
    required this.commentId,
    required this.commentCreatedAt,
    required this.commentDeletedAt,
    required this.commentLikeCnt,
    required this.commentDesc,
    required this.isLikedByMe,
    required this.shape,
    required this.postAuthorId,
    // required this.isAnonymous,
  }) : super(key: key);

  /// 댓글 , 대댓글 구분
  bool isShape() {
    return shape == CommentShape.bottom ? true : false;
  }

  /// 댓글 작성자 확인
  bool isAuthor() {
    final box = Hive.box<User>('user');
    var meId = box.get('user')?.id;
    return meId == authorId ? true : false;
  }

  /// 게시판 작성자 확인
  bool isMaster() {
    return postAuthorId == authorId ? true : false;
  }

  /// 둘다 작성자 확인
  double modalTop() {
    if (isMaster()) {
      if (isAuthor()) {
        return 160.0;
      }
      return 123.0;
    }
    return 123.0;
  }

  /// post detail getX
  final PostDetailController _postDetailX = Get.put(PostDetailController());

  /// 댓글 or 대댓글 좋아요 이벤트
  void commentLike() {
    if (!isShape()) {
      _postDetailX.updateLikeBoardComment(commentId: commentId, commentLikeCnt: commentLikeCnt, isLikedByMe: isLikedByMe);
    } else {
      _postDetailX.updateLikeBoardCommentReply(commentId: commentId);
    }
  }

  /// 댓글 or 대댓글 삭제 이벤트
  void commentDelete(BuildContext context) {
    // if (!isShape()) {
    _postDetailX.delectBoardComment(commnetId: commentId);
    Navigator.pop(context);
    // } else {
    //   _postDetailX.delectBoardCommentReply(replycommnetId: commentId);
    // }
  }

  /// 댓글 or 대댓글 신고 이벤트
  void commentReport() {
    if (!isShape()) {
      print("$commentId , $authorId , 댓글 신고종류");
    } else {
      print("$commentId , $authorId , 대댓글 신고종류");
    }
  }

  /// 대댓글 이벤트 on
  void replyEventOn() {
    if (_postDetailX.selectCommentEvent.value.commentId == commentId) {
      _postDetailX.selectCommentReplyOn(commentId: 0, name: '');
    } else {
      _postDetailX.selectCommentReplyOn(commentId: commentId, name: authorNickname);
    }
  }

  ///클릭시 인풋에 대댓글 넣어주기 위해서 트리거 만든거 지금 제대록 작동안함
  void inputOn() {
    if (_postDetailX.reCommentInputOn.value) {
      _postDetailX.reCommentInputOn.value = false;
    } else {
      _postDetailX.reCommentInputOn.value = true;
    }
  }

  Color changeColor() {
    return _postDetailX.selectCommentEvent.value.commentId == commentId
        ? Palette.candy
        : isShape()
            ? Palette.paperLow
            : Colors.white;
  }

  /// 대댓글 모달 버튼 리스트
  Widget ButtonList(BuildContext context) {
    return Column(
      children: [
        if (isAuthor()) ModalButton(title: '삭제하기', event: () => commentDelete(context)),
        if (isMaster()) ModalButton(title: '신고하기', event: commentReport),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double modalHeight = modalTop();
    String title = '더보기';
    PostModal modalOn = PostModal(context: context, contents: ButtonList(context), height: modalHeight, title: title);
    if (commentDeletedAt == null) {
      return Obx(() => Container(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
          width: 380.w,
          decoration: BoxDecoration(
              color: changeColor(),
              border: Border(
                top: BorderSide(color: isShape() ? Colors.white : Palette.paper, style: BorderStyle.solid, width: 1),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isShape())
                SizedBox(
                    width: 25.w,
                    child: Padding(
                      padding: EdgeInsets.only(top: 6, right: 3),
                      child: SvgPicture.asset(
                        'assets/icons/commentArrow.svg',
                        fit: BoxFit.scaleDown,
                        width: 16,
                        height: 16,
                        color: Palette.lightGray,
                      ),
                    )),
              SizedBox(
                  width: isShape() ? 300.w : 325.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AuthorForm(
                            image: authorProfileImg,
                            nickName: authorNickname,
                            major: authorMajor,
                            shape: Shape.comment,
                            isMaster: isMaster(),
                          ),
                          Container(
                            width: !isShape() ? 76.w : 50.w,
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1.0, color: Palette.lightGray),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                              //*좋아요 기능*/
                              SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: SvgPicture.asset(
                                      'assets/icons/sentiment.svg',
                                      fit: BoxFit.scaleDown,
                                      width: 10,
                                      height: 10,
                                      color: Palette.violet,
                                    ),
                                    onPressed: commentLike,
                                  )),
                              if (!isShape())
                                Container(
                                  width: 1,
                                  height: 10,
                                  color: Palette.lightGray,
                                ),
                              //*대댓글 기능*/
                              if (!isShape())
                                SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: SvgPicture.asset(
                                        'assets/icons/commentRectangle.svg',
                                        fit: BoxFit.scaleDown,
                                        width: 10,
                                        height: 10,
                                        color: Palette.violet,
                                      ),
                                      onPressed: () {
                                        replyEventOn();
                                        inputOn();
                                      },
                                    )),
                              Container(
                                width: 1,
                                height: 10,
                                color: Palette.lightGray,
                              ),
                              //*댓글 more 기능*/
                              SizedBox(
                                width: 10,
                                height: 10,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(Icons.more_horiz),
                                  iconSize: 10,
                                  color: Palette.violet,
                                  onPressed: () {
                                    modalOn.ModalOn();
                                  },
                                ),
                              )
                            ]),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 3.h, bottom: 6.h),
                          child: Text(
                            commentDesc,
                            style: CommonText.BodyM,
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            commentCreatedAt,
                            style: CommonText.BodyEngGray,
                          ),
                          if (!isMaster())
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/sentiment.svg',
                                  fit: BoxFit.scaleDown,
                                  width: 10,
                                  height: 10,
                                  color: Palette.violet,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "$commentLikeCnt",
                                  style: CommonText.BodyEngMain11,
                                )
                              ],
                            )
                        ],
                      )
                    ],
                  ))
            ],
          )));
    } else {
      return Obx(() => Container(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
          width: 380.w,
          decoration: BoxDecoration(
              color: changeColor(),
              border: Border(
                top: BorderSide(color: isShape() ? Colors.white : Palette.paper, style: BorderStyle.solid, width: 1),
              )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isShape())
                Row(
                  children: [
                    SizedBox(
                        width: 25.w,
                        child: SvgPicture.asset(
                          'assets/icons/commentArrow.svg',
                          fit: BoxFit.scaleDown,
                          width: 16,
                          height: 16,
                          color: Palette.lightGray,
                        )),
                    SizedBox(
                      width: 5.0.w,
                    ),
                  ],
                ),
              SizedBox(
                child: Text("삭제된 댓글입니다."),
              )
            ],
          )));
    }
  }
}

class AuthorForm extends StatelessWidget {
  final String? image;
  final String? nickName;
  final String? major;
  final Shape? shape;
  final bool? isMaster;

  AuthorForm({
    Key? key,
    required this.image,
    required this.nickName,
    required this.major,
    required this.shape,
    required this.isMaster,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: shapePostion() ? 15 : 13,
          backgroundImage: Withdrawal() ? null : NetworkImage(image!),
          backgroundColor: Palette.data,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
            Withdrawal()
                ? '(알수없음)'
                : isMaster!
                    ? '글쓴이'
                    : nickName!,
            style: Withdrawal()
                ? CommonText.BodyM
                : shapePostion()
                    ? CommonText.TitleS
                    : isMaster!
                        ? CommonText.BodyMediumPurple
                        : CommonText.BodyM),
        SizedBox(
          width: 6,
        ),
        Text(major!, style: shapePostion() ? CommonText.LabelGray : CommonText.BodyXSmallGray),
      ],
    );
  }

  Withdrawal() {
    if (nickName == '탈퇴자') {
      return true;
    } else {
      return false;
    }
  }

  shapePostion() {
    if (shape == Shape.posting) {
      return true;
    } else {
      return false;
    }
  }
}
