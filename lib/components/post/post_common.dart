import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

class PostDifferentList extends StatelessWidget {
  PostDifferentList({Key? key, required this.widgetList}) : super(key: key);
  List<Widget> widgetList;

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
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
  final int imgCnt;
  final int likeCnt;
  final int commentCnt;

  const CommentSide(
      {Key? key,
        required this.imgCnt,
        required this.likeCnt,
        required this.commentCnt,
      })
      : super(key: key);

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
            Text(imgCnt.toString(), style: CommonText.BodyEngMain11),
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
            Text(likeCnt.toString(), style: CommonText.BodyEngMain11),
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
            Text(commentCnt.toString(), style: CommonText.BodyEngMain11),
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

class AuthorForm extends StatelessWidget {
  final String? image;
  final String? nickName;
  final String? major;
  final Shape? shape;
  final bool? isMaster;

  AuthorForm(
      {Key? key,
        required this.image,
        required this.nickName,
        required this.major,
        required this.shape,
        required this.isMaster})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: shapePostion() ? 15 : 13,
            backgroundImage: Withdrawal() ? null : NetworkImage(image!),
            backgroundColor: Palette.data),
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
        Text(major!,
            style: shapePostion()
                ? CommonText.LabelGray
                : CommonText.BodyXSmallGray),
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

enum CommentShape { top, bottom }

class CommentBox extends StatelessWidget {
  final int authorId;
  final String authorMajor;
  final String authorNickname;
  final String authorProfileImg;
  final bool isBlind;
  final int commentId;
  final String commentCreatedAt;
  final int commentLikeCnt;
  final String commentDesc;
  final bool isLikedByMe;
  final CommentShape shape;
  final int postingAuthorId;
  CommentBox(
      {Key? key,
        required this.authorId,
        required this.authorMajor,
        required this.authorNickname,
        required this.authorProfileImg,
        required this.isBlind,
        required this.commentId,
        required this.commentCreatedAt,
        required this.commentLikeCnt,
        required this.commentDesc,
        required this.isLikedByMe,
        required this.shape,
        required this.postingAuthorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w, right: 16.w),
        width: 380.w,
        decoration: BoxDecoration(
            color: isShape() ? Palette.paperLow : Colors.white,
            border: Border(
              top: BorderSide(
                  color: isShape() ? Colors.white : Palette.paper,
                  style: BorderStyle.solid,
                  width: 1),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isShape())
              Container(
                  width:25.w,
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
            Container(
                width:isShape() ?300.w :  325.w,
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
                          padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1.0, color: Palette.lightGray),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/sentiment.svg',
                                  fit: BoxFit.scaleDown,
                                  width: 16,
                                  height: 16,
                                  color: Palette.violet,
                                ),
                                if (!isShape())
                                  Container(
                                    width: 1,
                                    height: 10,
                                    color: Palette.lightGray,
                                  ),
                                if (!isShape())
                                  SvgPicture.asset(
                                    'assets/icons/commentRectangle.svg',
                                    fit: BoxFit.scaleDown,
                                    width: 16,
                                    height: 16,
                                    color: Palette.violet,
                                  ),
                                Container(
                                  width: 1,
                                  height: 10,
                                  color: Palette.lightGray,
                                ),
                                Icon(
                                  Icons.more_horiz,
                                  size: 10,
                                  color: Palette.violet,
                                )
                              ]),
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 3.h, bottom: 6.h ),
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
                                commentLikeCnt.toString(),
                                style: CommonText.BodyEngMain11,
                              )
                            ],
                          )
                      ],
                    )
                  ],
                ))
          ],
        ));
  }

  isShape() {
    if (shape == CommentShape.bottom) {
      return true;
    } else {
      return false;
    }
  }

  isMaster() {
    if (postingAuthorId == authorId) {
      return true;
    } else {
      return false;
    }
  }
}
