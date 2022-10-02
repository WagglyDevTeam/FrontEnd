import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_common.dart';
import '../../controller/post/post_home_controller.dart';
import '../../model/post/dtos/post_college_dto.dart';
import '../../utils/colors.dart';
import '../../utils/text_frame.dart';
import './post_app_bar.dart';
import 'package:skeletons/skeletons.dart';

class PostAffiliation extends StatefulWidget {
  const PostAffiliation({Key? key}) : super(key: key);

  @override
  _PostAffiliation createState() => _PostAffiliation();
}

class _PostAffiliation extends State<PostAffiliation> {
  _PostAffiliation({Key? key});
  final String postName = Get.parameters['collegeName'] ?? "";
  final _postDetailX = Get.put(PostHomeController());
  final dto =
      PostCollegeDto(college: Get.parameters['collegeId'], page: 0, size: 10);
  @override
  initState() {
    _postDetailX.getBoardCollege(dto);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var page = Status.home;
    // print(_postDetailX.bestPostCollegeData.value);
    // print(_postDetailX.postCollegeData.value);
    return Scaffold(
        appBar: PostAppbar(
            postName: _postDetailX.bestPostOn.value ? "로딩 중" : postName,
            page: page),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Obx(() => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _postDetailX.postCollegeData.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  int postInt = index - 1;
                  if (index == 0) {
                    /**인기 글*/
                    return Container(
                      padding: EdgeInsets.all(16.w),
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
                            child: Obx(() => PostContext(
                                  postId: _postDetailX
                                          .bestPostCollegeData.value.postId ??
                                      0,
                                  postTitle: _postDetailX.bestPostCollegeData
                                          .value.postTitle ??
                                      '',
                                  postDesc: _postDetailX
                                          .bestPostCollegeData.value.postDesc ??
                                      '',
                                  postCreatedAt: _postDetailX
                                          .bestPostCollegeData
                                          .value
                                          .postCreatedAt ??
                                      '',
                                  authorMajor: _postDetailX.bestPostCollegeData
                                          .value.authorMajor ??
                                      '',
                                  postImageCnt: _postDetailX.bestPostCollegeData
                                          .value.postImageCnt ??
                                      0,
                                  postLikeCnt: _postDetailX.bestPostCollegeData
                                          .value.postLikeCnt ??
                                      0,
                                  postCommentCnt: _postDetailX
                                          .bestPostCollegeData
                                          .value
                                          .postCommentCnt ??
                                      0,
                                  isLikedByMe: _postDetailX.bestPostCollegeData
                                          .value.isLikedByMe ??
                                      false,
                                  isBlind: _postDetailX
                                          .bestPostCollegeData.value.isBlind ??
                                      false,
                                  postName: postName,
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
                      child: Obx(() => PostContext(
                            postId:
                                _postDetailX.postCollegeData[postInt].postId ??
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
                                    .postCollegeData[postInt].postCommentCnt ??
                                0,
                            isLikedByMe: _postDetailX
                                    .postCollegeData[postInt].isLikedByMe ??
                                false,
                            isBlind:
                                _postDetailX.postCollegeData[postInt].isBlind ??
                                    false,
                            postName: postName,
                          )),
                    );
                  }
                },
              )),
        ));
  }
}

class PostContext extends StatelessWidget {
  String? postDesc;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;
  String? postName;

  PostContext({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(postId);
    return GestureDetector(
      onTap: () =>
          Get.toNamed("/postDetail/param?postId=$postId&collegeName=인문계열"),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(postTitle ?? "", style: CommonText.BodyL),
              Text(postCreatedAt!, style: CommonText.BodyEngGray),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: MediaQuery.of(context).size.width - 32.w,
            child: Text(postDesc!, style: CommonText.BodyS),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(authorMajor!, style: CommonText.BodyEngGray),
              CommentSide(
                commentCnt: postCommentCnt!,
                likeCnt: postLikeCnt!,
                imgCnt: postImageCnt!,
              )
            ],
          )
        ],
      ),
    );
  }
}
