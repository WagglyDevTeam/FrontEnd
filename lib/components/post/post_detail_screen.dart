// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_app_bar.dart';
import 'package:waggly/components/Post/post_common.dart';
import 'package:waggly/components/post/custom_text_form_field.dart';
import 'package:waggly/controller/postDetail/post_detail_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

const double contentsHeight = 665.0;
const double contentsWidth = 360.0;
const double imageBoxSize = 100.0;
const double contentsPadding = 18.0;

/// 게시판 상세 페이지 레이아웃
class PostDetail extends StatelessWidget {
  /// 게시판 상세 페이지 Id
  final String postId = "${Get.parameters['collegeName']}";

  PostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const postId = "아이디";
    const postName = "예술계열";
    var page = Status.detail;
    return Scaffold(
      appBar: PostAppbar(postName: postName, page: page),
      body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              DetailContext(),
            ]),
          )),
    );
  }
}

/// 게시판 상세 페이지 ui
class DetailContext extends StatelessWidget {
  DetailContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 게시판 상세 페이지 GetX 데이터
    final PostDetailController _postDetailX = Get.put(PostDetailController());

    /// 게시판 상세 페이지 GetX 좋아요 이벤트
    onLikedByMe() {
      _postDetailX.updateDetailBoardLike(
        isLikedByMe: _postDetailX.postDetail.value.isLikedByMe!,
        postLikeCnt: _postDetailX.postDetail.value.isLikedByMe!
            ? _postDetailX.postDetail.value.postLikeCnt! - 1
            : _postDetailX.postDetail.value.postLikeCnt! + 1,
        postId: _postDetailX.postDetail.value.postId!,
      );
    }

    ///게시판 상세 페이지 GetX 즐겨찾기 이벤트
    onBookMarkByMe() {
      _postDetailX.updateDetailBoardBookmark(
        isBlind: !_postDetailX.postDetail.value.isBlind!,
        postId: _postDetailX.postDetail.value.postId!,
      );
    }

    return SizedBox(
        width: contentsWidth.w,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                    width: contentsWidth.w,
                    height: contentsHeight.h,
                    color: Colors.white10,
                    padding: EdgeInsets.only(bottom: 45),
                    child: Obx(() => ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _postDetailX.boardComment.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            int commentInt = index - 1;
                            if (index == 0) {
                              /// 게시판 상세 페이지 POST UI
                              return Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    /// 게시판 상세 페이지 작성 정보
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 16.h,
                                          left: contentsPadding.w,
                                          right: contentsPadding.w,
                                          bottom: 8.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Obx(() => AuthorForm(
                                                image: _postDetailX.postDetail
                                                    .value.authorProfileImg,
                                                nickName: _postDetailX
                                                    .postDetail
                                                    .value
                                                    .authorNickname,
                                                major: _postDetailX.postDetail
                                                    .value.authorMajor,
                                                shape: Shape.posting,
                                                isMaster: false,
                                              )),
                                          Obx(() => Text(
                                              _postDetailX.postDetail.value
                                                  .postCreatedAt!,
                                              style: CommonText.BodyEngGray)),
                                        ],
                                      ),
                                    ),

                                    /// 게시판 상세 페이지 내용
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 7.h,
                                          left: 24.w,
                                          right: 24.w,
                                          bottom: 7.h),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(() => Text(
                                                _postDetailX.postDetail.value
                                                    .postTitle!,
                                                style: CommonText.BodyL)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Obx(() => Text(
                                                _postDetailX
                                                    .postDetail.value.postDesc!,
                                                style: CommonText.BodyM)),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),

                                    /// 게시판 상세 페이지 이미지리스트
                                    Obx(() => Container(
                                          height: _postDetailX.postDetail.value
                                                  .postImages!.isEmpty
                                              ? 0
                                              : imageBoxSize,
                                          padding: EdgeInsets.only(
                                              left: contentsPadding.w),
                                          child: PostDifferentList(
                                            widgetList: [
                                              for (var i = 0;
                                                  i <
                                                      _postDetailX
                                                          .postDetail
                                                          .value
                                                          .postImages!
                                                          .length;
                                                  i++)
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: _postDetailX
                                                              .postDetail
                                                              .value
                                                              .postImages!
                                                              .isEmpty
                                                          ? 0
                                                          : imageBoxSize,
                                                      height: _postDetailX
                                                              .postDetail
                                                              .value
                                                              .postImages!
                                                              .isEmpty
                                                          ? 0
                                                          : imageBoxSize,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  _postDetailX
                                                                      .postDetail
                                                                      .value
                                                                      .postImages![i]),
                                                              fit: BoxFit.cover)),
                                                    ),
                                                    SizedBox(
                                                        width: i ==
                                                                _postDetailX
                                                                        .postDetail
                                                                        .value
                                                                        .postImages!
                                                                        .length -
                                                                    1
                                                            ? contentsPadding.w
                                                            : 6.w)
                                                  ],
                                                )
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10.w,
                                    ),

                                    /// 게시판 상세 페이지 버튼 리스트
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: contentsPadding.w,
                                          right: contentsPadding.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Obx(() => DetailBtn(
                                                    name: '좋아요',
                                                    svg:
                                                        'assets/icons/sentiment.svg',
                                                    onTap: onLikedByMe,
                                                    active: _postDetailX
                                                        .postDetail
                                                        .value
                                                        .isLikedByMe!,
                                                  )),
                                            ],
                                          ),
                                          Obx(() => CommentSide(
                                                imgCnt: _postDetailX.postDetail
                                                    .value.postImages!.length,
                                                likeCnt: _postDetailX.postDetail
                                                    .value.postLikeCnt!,
                                                commentCnt: _postDetailX
                                                    .postDetail
                                                    .value
                                                    .postCommentCnt!,
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              /// 게시판 상세 페이지 COMMENT UI
                              return Column(
                                children: [
                                  Obx(() => CommentBox(
                                      authorId: _postDetailX
                                          .boardComment[commentInt].authorId!,
                                      authorMajor: _postDetailX
                                          .boardComment[commentInt]
                                          .authorMajor!,
                                      authorNickname: _postDetailX
                                          .boardComment[commentInt]
                                          .authorNickname!,
                                      authorProfileImg: _postDetailX
                                          .boardComment[commentInt]
                                          .authorProfileImg!,
                                      isBlind: _postDetailX
                                          .boardComment[commentInt].isBlind!,
                                      commentId: _postDetailX
                                          .boardComment[commentInt].commentId!,
                                      commentCreatedAt: _postDetailX
                                          .boardComment[commentInt]
                                          .commentCreatedAt!,
                                      commentLikeCnt: _postDetailX
                                          .boardComment[commentInt]
                                          .commentLikeCnt!,
                                      commentDesc: _postDetailX
                                          .boardComment[commentInt]
                                          .commentDesc!,
                                      isLikedByMe: _postDetailX
                                          .boardComment[commentInt]
                                          .isLikedByMe!,
                                      shape: CommentShape.top,
                                      postingAuthorId: _postDetailX
                                          .postDetail.value.authorId!)),
                                  Obx(() => Column(
                                        children: [
                                          for (var i = 0;
                                              i <
                                                  _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies!
                                                      .length;
                                              i++)
                                            Obx(() => CommentBox(
                                                  authorId: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .authorId!,
                                                  authorMajor: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .authorMajor!,
                                                  authorNickname: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .authorNickname!,
                                                  authorProfileImg: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .authorProfileImg!,
                                                  isBlind: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .isBlind!,
                                                  commentId: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .replyId!,
                                                  commentCreatedAt: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .replyCreatedAt!,
                                                  commentLikeCnt: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .replyLikeCnt!,
                                                  commentDesc: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .replyDesc!,
                                                  isLikedByMe: _postDetailX
                                                      .boardComment[commentInt]
                                                      .replies![i]
                                                      .isLikedByMe!,
                                                  shape: CommentShape.bottom,
                                                  postingAuthorId: _postDetailX
                                                      .postDetail
                                                      .value
                                                      .authorId!,
                                                ))
                                        ],
                                      ))
                                ],
                              );
                            }
                          },
                        ))),
              ),

              /// 게시판 상세 페이지 Textarea UI
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: PostDetailTextarea(
                    postId: _postDetailX.postDetail.value.postId,
                  )),
            ],
          ),
        ]));
  }
}

/// 댓글 Textarea
class PostDetailTextarea extends StatelessWidget {
  /// 댓글 값 컨트롤러 */
  final _comment = TextEditingController();
  final postId;
  PostDetailTextarea({Key? key, @required this.postId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final PostDetailController _postDetailX = Get.put(PostDetailController());

    /// 게시판 상세페이지 댓글 업데이트 이벤트
    void onCommentUpdate() {
      if (_comment.text != "") {
        if (_postDetailX.selectCommentEvent.value.checkEvent!) {
          _postDetailX.postBoardCommentReply(
              commentDesc: _comment.text,
              commentId: _postDetailX.selectCommentEvent.value.commentId!);
          _postDetailX.selectCommentReplyOff();
        } else {
          _postDetailX.postBoardComment(
              commentDesc: _comment.text, postId: postId);
        }
        _comment.clear();
      }
    }

    return Container(
      width: 360.w,
      height: 75.h,
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 284.w,
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: Color(0xFFE8E8E8)),
              color: Color(0xFFF8F8F8),
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_postDetailX.selectCommentEvent.value.checkEvent!)
                      Obx(
                        () => SizedBox(
                            width: 54,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: StrutStyle(fontSize: 16.0),
                              text: TextSpan(
                                text:
                                    "@ ${_postDetailX.selectCommentEvent.value.name}",
                                style: CommonText.BodyMediumGray,
                              ),
                            )),
                      ),
                    if (_postDetailX.selectCommentEvent.value.checkEvent!)
                      SizedBox(width: 10.w),
                    SizedBox(
                      width: _postDetailX.selectCommentEvent.value.checkEvent!
                          ? 200.w
                          : 260.w,
                      height: 36.h,
                      child: CustomTextFormField(
                        onChanged: onCommentUpdate,
                        controller: _comment,
                        hint: "",
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            width: 8.w,
          ),
          GestureDetector(
            onTap: onCommentUpdate,
            child: Container(
                width: 36.w,
                height: 36.h,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Color(0xFFE8E8E8)),
                  color: Palette.main,
                ),
                child: SvgPicture.asset(
                  'assets/icons/btn_comment.svg',
                  fit: BoxFit.scaleDown,
                  width: 36.w,
                  height: 36.w,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}

/// 게시판 상세 페이지 버튼
class DetailBtn extends StatelessWidget {
  final String name;
  final String svg;
  final void Function()? onTap;
  final bool active;
  const DetailBtn(
      {Key? key,
      required this.name,
      required this.svg,
      required this.onTap,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: active ? Palette.main : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.5,
          color: active ? Palette.main : Palette.lightGray,
        ),
      ),
      child: GestureDetector(
          onTap: onTap,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  svg,
                  fit: BoxFit.scaleDown,
                  width: 16,
                  height: 16,
                  color: active ? Palette.lightGray : Palette.main,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  name,
                  style:
                      active ? CommonText.BodyEngWhite : CommonText.BodyEngMain,
                )
              ])),
    );
  }
}
