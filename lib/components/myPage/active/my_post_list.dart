import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waggly/controller/myPage/my_comment_list_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/controller/myPage/my_post_list_controller.dart';
import 'package:waggly/widgets/myPage/my_page_comment.dart';
import '../../post/post_college_List.dart';

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

class MyPostList extends StatelessWidget {
  MyPostsListController controller = Get.put(MyPostsListController());
  MyCommentsListController commentController =
      Get.put(MyCommentsListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 28.h;
    final double itemWidth = size.width / 2;
    double appbarHeight = 68.0.h;

    return Stack(children: [
      Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20.h, left: 16.w),
          height: appbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Palette.lightGray),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Palette.gray,
                  iconSize: 20.0.sp,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Obx(
                () => Container(
                  width: 200.w,
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    controller.mine.value ? '내가 쓴 글' : '내가 쓴 댓글',
                    style: CommonText.BodyL,
                  ),
                ),
              ),
            ],
          ),
        ),
        //아이콘 버튼
        Obx(
          () => Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(5),
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.subject,
                      size: 16.0,
                    ),
                    onPressed: () {
                      controller.mine.value = true;
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          controller.mine.value ? Palette.main : Colors.white,
                      onPrimary:
                          controller.mine.value ? Colors.white : Palette.gray,
                      side: BorderSide(
                        width: 0.5,
                        color: controller.mine.value
                            ? Colors.white
                            : Palette.light,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 16.0,
                    ),
                    onPressed: () {
                      controller.mine.value = false;
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          !controller.mine.value ? Palette.main : Colors.white,
                      onPrimary:
                          !controller.mine.value ? Colors.white : Palette.gray,
                      side: BorderSide(
                        width: 0.5,
                        color: !controller.mine.value
                            ? Colors.white
                            : Palette.light,
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
        ),
        //리스트
        Obx(
          () => controller.mine.value
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 120.h,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.myPosts.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.only(
                                top: 8.h,
                                bottom: 16.h,
                                left: 26.w,
                                right: 26.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      color: Palette.paper,
                                      style: BorderStyle.solid,
                                      width: 1),
                                )),
                            child: PostContext(
                              postId: controller.myPosts[index].postId ?? 0,
                              postTitle:
                                  controller.myPosts[index].postTitle ?? '',
                              postDesc:
                                  controller.myPosts[index].postDesc ?? '',
                              postCreatedAt: DateFormat('MM/dd HH:mm').format(
                                  controller.myPosts[index].postCreatedAt! ??
                                      ''),
                              authorMajor:
                                  controller.myPosts[index].authorMajor ?? '',
                              postImageCnt:
                                  controller.myPosts[index].postImageCnt ?? 0,
                              postLikeCnt:
                                  controller.myPosts[index].postLikeCnt ?? 0,
                              postCommentCnt:
                                  controller.myPosts[index].postCommentCnt ?? 0,
                              isLikedByMe:
                                  controller.myPosts[index].isLikedByMe ??
                                      false,
                              isBlind:
                                  controller.myPosts[index].authorMajor ?? 0,
                              postName:
                                  controller.myPosts[index].postTitle ?? 0,
                            ));
                      }))
              : Obx(
                  () => SizedBox(
                      height: MediaQuery.of(context).size.height - 120.h,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: commentController.myComments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  top: 8.h,
                                  bottom: 16.h,
                                  left: 26.w,
                                  right: 26.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Palette.paper,
                                        style: BorderStyle.solid,
                                        width: 1),
                                  )),
                              child: CommentContext(
                                postId:
                                    commentController.myComments[index].postId,
                                postTitle:
                                    commentController.myComments[index].postId,
                                boardType:
                                    commentController.myComments[index].postId,
                                commentCreatedAt:
                                    commentController.myComments[index].postId,
                                commentId:
                                    commentController.myComments[index].postId,
                                commentDesc:
                                    commentController.myComments[index].postId,
                              ),
                            );
                          })),
                ),
        ),
      ])
    ]);
  }
}
