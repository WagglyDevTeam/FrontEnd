import 'package:flutter/material.dart';
import 'package:wagly/components/Post/post_detail_screen.dart';
import 'package:wagly/widgets/index.dart';
import 'package:wagly/utils/colors.dart';
import 'package:wagly/utils/textFrame.dart';

class CommentContext extends StatelessWidget {
  final postId;
  final postTitle;
  final boardType;
  final commentCreatedAt;
  final commentId;
  final commentDesc;

  const CommentContext({
    Key? key,
    @required this.postId,
    @required this.postTitle,
    @required this.boardType,
    @required this.commentCreatedAt,
    @required this.commentId,
    @required this.commentDesc,
  }) : super(key: key);

  Widget build(BuildContext context) {
    PageRouteWithAnimation detail =
        PageRouteWithAnimation(PostDetail(postId: postId));
    return GestureDetector(
        onTap: () => Navigator.of(context).push(detail.slideLeftToRight()),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                postTitle,
                style: CommonText.BodyLargeMain,
              ),
              Text(
                commentCreatedAt,
                style: CommonText.BodyXSmallGray,
              )
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                commentDesc,
                style: CommonText.BodyM,
              ),
              Text(
                boardType,
                style: CommonText.LabelGray,
              )
            ]),
            SizedBox(height: 20),
          ],
        ));
  }
}
