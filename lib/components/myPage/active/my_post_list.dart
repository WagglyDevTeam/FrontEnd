import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waggly/controller/myPage/my_comment_list_controller.dart';
import 'package:waggly/provider/my_comment_provider.dart';
import 'package:waggly/screens/post/post_college_List.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/controller/myPage/my_post_list_controller.dart';
import 'package:waggly/widgets/myPage/my_page_comment.dart';

class MyPostListScreen extends StatelessWidget {
  const MyPostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: MyPostList(),
    );
  }
}


class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  MyPostsListController controller = Get.put(MyPostsListController());
  MyCommentsListController commentController = Get.put(MyCommentsListController());


  @override
  Size get preferredSize => Size.fromHeight(68.h);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
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
              ),
              SizedBox(
                width: 8.w,
              ),
              Obx(
                    () => Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    controller.mine.value ? '내가 작성한 글' : '내가 작성한 댓글',
                    style: CommonText.BodyL,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyPostList extends StatelessWidget {
  MyPostsListController controller = Get.put(MyPostsListController());
  MyCommentsListController commentController = Get.put(MyCommentsListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 28.h;
    final double itemWidth = size.width / 2;
    double appbarHeight = 68.0.h;

    return Stack(children: [
      Column(children: [
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
                      primary: controller.mine.value ? Palette.main : Colors.white,
                      onPrimary: controller.mine.value ? Colors.white : Palette.gray,
                      side: BorderSide(
                        width: 0.5,
                        color: controller.mine.value ? Colors.white : Palette.light,
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
                      primary: !controller.mine.value ? Palette.main : Colors.white,
                      onPrimary: !controller.mine.value ? Colors.white : Palette.gray,
                      side: BorderSide(
                        width: 0.5,
                        color: !controller.mine.value ? Colors.white : Palette.light,
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
          () => controller.mine.value ?
          SizedBox(
                  height: MediaQuery.of(context).size.height - 145.h,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.myPosts.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.only(top: 5.h, bottom: 16.h, left: 26.w, right: 26.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(color: Palette.paper, style: BorderStyle.solid, width: 1),
                                )),
                            child: PostContext(
                              postId: controller.myPosts[index].postId ?? 0,
                              postTitle: controller.myPosts[index].postTitle ?? '',
                              postDesc: controller.myPosts[index].postDesc ?? '',
                              postCreatedAt:
                              DateFormat('MM/dd HH:mm').format(controller.myPosts[index].postCreatedAt! ?? ''),
                              authorMajor: controller.myPosts[index].authorMajor ?? '',
                              postImageCnt: controller.myPosts[index].postImageCnt ?? 0,
                              postLikeCnt: controller.myPosts[index].postLikeCnt ?? 0,
                              postCommentCnt: controller.myPosts[index].postCommentCnt ?? 0,
                              isLikedByMe: controller.myPosts[index].isLikedByMe ?? false,
                              isAnonymous: controller.myPosts[index].isAnonymous ?? false,
                              collegeType: controller.myPosts[index].authorMajor ?? "",
                            ));
                      }))
              : SizedBox(
                      height: MediaQuery.of(context).size.height - 200.h,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: commentController.myComments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(top: 8.h, bottom: 16.h, left: 26.w, right: 26.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(color: Palette.paper, style: BorderStyle.solid, width: 1),
                                  )),
                              child:
                              CommentContext(
                                postId: commentController.myComments[index].postId,
                                postTitle: commentController.myComments[index].postTitle ,
                                boardType: commentController.myComments[index].boardType,
                                commentCreatedAt: DateFormat('MM/dd HH:mm').format(commentController.myComments[index].commentCreatedAt!),
                                commentId: commentController.myComments[index].commentId,
                                commentDesc: commentController.myComments[index].commentDesc,
                              ),
                            );
                            // return GestureDetector(
                            //   onTap: () => {
                            //     Get.toNamed("/postDetail/param?postId=$postId&collegeName=$collegeType")
                            //   },
                            //   child: Column(
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           SizedBox(
                            //             width: 210.w,
                            //             child: Text(postTitle ?? "", style: CommonText.BodyL),
                            //           ),
                            //           Text(postCreatedAt ?? "", style: CommonText.BodyEngGray),
                            //         ],
                            //       ),
                            //       SizedBox(height: 10.h),
                            //       Container(
                            //         width: MediaQuery.of(context).size.width - 32.w,
                            //         child: Text(postDesc ?? "", style: CommonText.BodyS),
                            //       ),
                            //       SizedBox(height: 6.h),
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(authorMajor ?? "", style: CommonText.BodyEngGray),
                            //           CommentSide(
                            //             commentCnt: postCommentCnt ?? 0,
                            //             likeCnt: postLikeCnt ?? 0,
                            //             imgCnt: postImageCnt ?? 0,
                            //           )
                            //         ],
                            //       )
                            //     ],
                            //   ),
                            // );
                          })),
        ),
      ]),
    ]);
  }
}
