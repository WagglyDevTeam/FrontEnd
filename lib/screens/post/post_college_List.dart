import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_common.dart';
import 'package:waggly/model/post/dtos/post_college_dto.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import 'package:waggly/widgets/imageIndicator/index.dart';

import '../../controller/post/post_home_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_frame.dart';


class PostCollegeList extends StatefulWidget {
  const PostCollegeList({Key? key}) : super(key: key);

  @override
  _PostCollegeList createState() => _PostCollegeList();
}

class _PostCollegeList extends State<PostCollegeList> {
  _PostCollegeList({Key? key});
  final ScrollController _scrollController = ScrollController();
  final _postDetailX = Get.put(PostHomeController());
  scrollListener() async {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _postDetailX.getBoardPaging(Get.parameters['collegeId']);
    } else if (_scrollController.offset ==
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      // print('스크롤이 맨 위에 위치해 있습니다');
    }
  }

  @override
  initState() {
    _scrollController.addListener(() {
      scrollListener();
    });
    _postDetailX.getBoardCollege(Get.parameters['collegeId']);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _postDetailX.postListReset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String postName = Get.parameters['collegeName'] ?? "";
    var _page = Status.boardTitle;
    var _pageTitle = _postDetailX.bestPostOn.value ? "로딩 중" : postName;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: TopAppBar(),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: FutureBuilder(
            future: _postDetailX.getBoardCollege(Get.parameters['collegeId']),
            builder : (context, snapshot){
              if(snapshot.connectionState != ConnectionState.done) {
                return Container(
                  height: MediaQuery.of(context).size.height - 200.h,
                  child: ImageIndicator(),
                );
              }else{
                return Obx(() => ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: _postDetailX.postCollegeData.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    int postInt = index - 1;
                    if (index == 0) {
                      /**인기 글*/
                      return Container(
                        padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 8.w,
                            bottom: 16.w),
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
                                SizedBox(width: 6.w),
                                Icon(
                                  Icons.auto_awesome,
                                  color: Palette.main,
                                  size: 17.w,
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
                              child: Obx(() =>
                                  PostContext(
                                    postId: _postDetailX
                                        .bestPostCollegeData.value.postId ??
                                        0,
                                    postTitle: _postDetailX
                                        .bestPostCollegeData
                                        .value.postTitle ??
                                        '',
                                    postDesc: _postDetailX
                                        .bestPostCollegeData.value
                                        .postDesc ??
                                        '',
                                    postCreatedAt: _postDetailX
                                        .bestPostCollegeData
                                        .value
                                        .postCreatedAt ??
                                        '',
                                    authorMajor: _postDetailX
                                        .bestPostCollegeData
                                        .value.authorMajor ??
                                        '',
                                    postImageCnt: _postDetailX
                                        .bestPostCollegeData
                                        .value.postImageCnt ??
                                        0,
                                    postLikeCnt: _postDetailX
                                        .bestPostCollegeData
                                        .value.postLikeCnt ??
                                        0,
                                    postCommentCnt: _postDetailX
                                        .bestPostCollegeData
                                        .value
                                        .postCommentCnt ??
                                        0,
                                    isLikedByMe: _postDetailX
                                        .bestPostCollegeData
                                        .value.isLikedByMe ??
                                        false,
                                    isBlind: _postDetailX
                                        .bestPostCollegeData.value
                                        .isBlind ??
                                        false,
                                    postName: postName,
                                    collegeType: _pageTitle,
                                  )),
                            )
                          ],
                        ),
                      );
                    } else {
                      /**일반 글*/
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
                        child: Obx(() =>
                            PostContext(
                              postId:
                              _postDetailX.postCollegeData[postInt]
                                  .postId ??
                                  0,
                              postTitle: _postDetailX
                                  .postCollegeData[postInt].postTitle ??
                                  '',
                              postDesc: _postDetailX
                                  .postCollegeData[postInt].postDesc ??
                                  '',
                              postCreatedAt: _postDetailX
                                  .postCollegeData[postInt].postCreatedAt ??
                                  '',
                              authorMajor: _postDetailX
                                  .postCollegeData[postInt].authorMajor ??
                                  '',
                              postImageCnt: _postDetailX
                                  .postCollegeData[postInt].postImageCnt ??
                                  0,
                              postLikeCnt: _postDetailX
                                  .postCollegeData[postInt].postLikeCnt ??
                                  0,
                              postCommentCnt: _postDetailX
                                  .postCollegeData[postInt]
                                  .postCommentCnt ??
                                  0,
                              isLikedByMe: _postDetailX
                                  .postCollegeData[postInt].isLikedByMe ??
                                  false,
                              isBlind:
                              _postDetailX.postCollegeData[postInt]
                                  .isBlind ??
                                  false,
                              postName: postName,
                              collegeType: _pageTitle,
                            )),
                      );
                    }
                  },
                ));
              }
            }),
        ));
  }
}


class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  final _postDetailX = Get.put(PostHomeController());
  final String postName = Get.parameters['collegeName'] ?? "";

  @override
  Size get preferredSize => Size.fromHeight(68.h);
  @override
  Widget build(BuildContext context) {
    final _pageTitle = _postDetailX.bestPostOn.value ? "로딩 중" : postName;
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
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text( _pageTitle, style: CommonText.BodyL))
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16.0.w, top: 7.0.h),
              padding: EdgeInsets.all(10.0.r),
              width: 155.0.w,
              height: 36.0.h,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(40.0) // POINT
                ),
                border: Border.all(width: 1.0, color: Palette.lightGray),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ActionButton(
                      event: () {
                        Get.toNamed("/writePage");
                      },
                      isIcon: Icon(
                        Icons.add,
                        color: Palette.gray,
                        size: 18.w,
                      )),
                  line(),
                  ActionButton(
                    //글 검색 페이지 필요함
                      event: () => Get.toNamed("/chatSearch"),
                      isIcon: Icon(
                        Icons.search,
                        color: Palette.gray,
                        size: 18.w,
                      )),
                  line(),
                  ActionButton(
                      event: () async {
                        await Get.put(NotificationController())
                            .getNotification();
                        Get.toNamed('/notification');
                      },
                      isIcon: Icon(
                        Icons.notifications_none,
                        color: Palette.gray,
                        size: 18.w,
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

line() {
  return const SizedBox(
    width: 1,
    height: 10,
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            // POINT
            color: Palette.lightGray,
            width: 1.0,
          ),
        ),
      ),
    ),
  );
}

class PostContext extends StatelessWidget {
  String? postDesc;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  bool? isAnonymous;
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;
  String? postName;
  String? collegeType;

  PostContext(
      {Key? key,
      this.postId,
      this.postTitle,
      this.postDesc,
      this.postCreatedAt,
      this.authorMajor,
      this.postImageCnt,
      this.postLikeCnt,
      this.postCommentCnt,
      this.isLikedByMe,
      this.isBlind,
      this.postName,
      this.collegeType,
      this.isAnonymous})
      : super(key: key);

  final _postDetailX = Get.put(PostHomeController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed("/postDetail/param?postId=$postId&collegeName=$collegeType")
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 210.w,
                child: Text(postTitle ?? "", style: CommonText.BodyL),
              ),
              Text(postCreatedAt ?? "", style: CommonText.BodyEngGray),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: MediaQuery.of(context).size.width - 32.w,
            child: Text(postDesc ?? "", style: CommonText.BodyS),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(authorMajor ?? "", style: CommonText.BodyEngGray),
              CommentSide(
                commentCnt: postCommentCnt ?? 0,
                likeCnt: postLikeCnt ?? 0,
                imgCnt: postImageCnt ?? 0,
              )
            ],
          )
        ],
      ),
    );
  }
}
