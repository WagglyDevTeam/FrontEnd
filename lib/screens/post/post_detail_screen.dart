import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/components/post/post_modal.dart';
import 'package:waggly/controller/post/post_home_controller.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/screens/post/post_home.dart';
import 'package:waggly/components/post/post_common.dart';
import 'package:waggly/controller/postDetail/post_detail_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/imageIndicator/index.dart';
import 'package:waggly/widgets/textFormField/custom_text_form_field.dart';
import '../../widgets/checkBox/custom_check_box.dart';

const double contentsHeight = 665.0;
const double contentsWidth = 360.0;
const double imageBoxSize = 100.0;
const double contentsPadding = 18.0;

/// 게시판 상세 페이지 레이아웃
class PostDetail extends StatelessWidget {
  PostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String _pageTitle = "${Get.parameters['collegeName']}";

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PageAppbar(page: _page, pageTitle: _pageTitle),
      appBar: TopAppBar(),
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

class DetailContext extends StatefulWidget {
  const DetailContext({Key? key}) : super(key: key);

  @override
  _DetailContext createState() => _DetailContext();
}

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(68.h);

  @override
  Widget build(BuildContext context) {
    late String _pageTitle = "${Get.parameters['collegeName']}";

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
                onTap: () {
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
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text(_pageTitle, style: CommonText.BodyL))
            ],
          ),
          actions: [DetailHiddenBtn(pageContext: context)],
        ),
      ],
    );
  }
}

class DetailHiddenBtn extends StatefulWidget {
  BuildContext pageContext;
  DetailHiddenBtn({Key? key, required this.pageContext}) : super(key: key);

  @override
  State<DetailHiddenBtn> createState() => _DetailHiddenBtnState();
}

class _DetailHiddenBtnState extends State<DetailHiddenBtn> {
  final PostDetailController _postDetailX = Get.put(PostDetailController());
  String postId = "${Get.parameters['postId']}";
  final int? loginUserId = Hive.box<User>('user').get('user')?.id;

  void waitForData() async {
    await _postDetailX.getDetailBoard(postId);
    setState(() {});
  }

  @override
  void initState() {
    waitForData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double modalHeight = _postDetailX.postDetail.value.authorId == loginUserId ? 150.h : 120.h;
    String title = '글 메뉴';
    void postDelete() {
      Navigator.pop(context);
    }

    void postFix() {
      Navigator.pop(context);
    }

    PostModal modalOn = PostModal(context: context, contents: buttons(context, widget.pageContext, loginUserId), height: modalHeight, title: title);
    return GestureDetector(
      onTap: () => {modalOn.ModalOn()},
      child: Container(
          margin: EdgeInsets.only(right: 16.w),
          child: SvgPicture.asset(
            'assets/icons/top_modal_dot.svg',
            fit: BoxFit.contain,
            width: 36.w,
            height: 36.h,
          )),
    );
  }

  buttons(BuildContext context, BuildContext pageContext, int? loginUserId) {
    final PostHomeController _postX = Get.put(PostHomeController());
    return Column(
      children: [
        if (_postDetailX.postDetail.value.authorId == loginUserId)
          ModalButton(
              title: '삭제하기',
              event: () {
                Get.offAll(PostScreen());
                _postX.deleteBoard(_postDetailX.postDetail.value.postId ?? 0);
              }),
        if (_postDetailX.postDetail.value.authorId == loginUserId)
          ModalButton(
              title: '수정하기',
              event: () {
                Get.toNamed("/editPage");
              }),
        if (_postDetailX.postDetail.value.authorId != loginUserId)
          ModalButton(
              title: '신고하기',
              event: () {
                Get.toNamed("/editPage");
              }),
      ],
    );
  }
}

/// 게시판 상세 페이지 ui
class _DetailContext extends State<DetailContext> {
  _DetailContext();

  /// 게시판 상세 페이지 GetX 데이터
  final PostDetailController _postDetailX = Get.put(PostDetailController());
  late String postId = "${Get.parameters['postId']}";
  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _postDetailX.updatePostId(postId);
    _postDetailX.getDetailBoard(postId);
  }

  @override
  Widget build(BuildContext context) {
    /// 게시판 상세 페이지 GetX 좋아요 이벤트
    onLikedByMe() {
      _postDetailX.updateDetailBoardLike(
        isLikedByMe: _postDetailX.postDetail.value.isLikedByMe == true ? false : true,
        postLikeCnt: _postDetailX.postDetail.value.isLikedByMe ?? false ? _postDetailX.postDetail.value.postLikeCnt ?? 0 - 1 : _postDetailX.postDetail.value.postLikeCnt ?? 0 + 1,
        postId: _postDetailX.postDetail.value.postId ?? 0,
      );
    }

    ///게시판 상세 페이지 GetX 즐겨찾기 이벤트
    onBookMarkByMe() {
      _postDetailX.updateDetailBoardBookmark(
        isBlind: _postDetailX.postDetail.value.isBlind ?? false,
        postId: _postDetailX.postDetail.value.postId ?? 0,
      );
    }

    return SizedBox(
        width: contentsWidth.w,
        child: FutureBuilder(
            future: _postDetailX.getDetailBoard(postId),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 200.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIndicator(),
                    ],
                  ),
                );
              } else {
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Container(
                            width: contentsWidth.w,
                            height: contentsHeight.h,
                            color: Colors.white10,
                            padding: EdgeInsets.only(bottom: 95.h),
                            child: Obx(() => ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  controller: _scrollController,
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
                                              padding: EdgeInsets.only(top: 16.h, left: contentsPadding.w, right: contentsPadding.w, bottom: 8.h),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Obx(() => AuthorForm(
                                                        image: _postDetailX.postDetail.value.authorProfileImg ?? '',
                                                        nickName: _postDetailX.postDetail.value.authorNickname ?? '',
                                                        major: _postDetailX.postDetail.value.authorMajor ?? '',
                                                        shape: Shape.posting,
                                                        isMaster: false,
                                                      )),
                                                  Obx(() => Text(_postDetailX.postDetail.value.postCreatedAt ?? '', style: CommonText.BodyEngGray)),
                                                ],
                                              ),
                                            ),

                                            /// 게시판 상세 페이지 내용
                                            Container(
                                              color: Colors.white,
                                              width: double.infinity,
                                              padding: EdgeInsets.only(top: 7.h, left: 24.w, right: 24.w, bottom: 7.h),
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                Obx(() => Text(_postDetailX.postDetail.value.postTitle ?? '', style: CommonText.BodyL)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Obx(() => Text(_postDetailX.postDetail.value.postDesc ?? '', style: CommonText.BodyM)),
                                              ]),
                                            ),
                                            SizedBox(
                                              height: 10.w,
                                            ),

                                            /// 게시판 상세 페이지 이미지리스트
                                            Obx(() => Container(
                                                  height: _postDetailX.postDetail.value.postImages?.isEmpty ?? false ? 0 : imageBoxSize,
                                                  padding: EdgeInsets.only(left: contentsPadding.w),
                                                  child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: _postDetailX.postDetail.value.postImages?.length ?? 0,
                                                      itemBuilder: (BuildContext context, int imgIndex) {
                                                        return Row(children: [
                                                          GestureDetector(
                                                            onTap: () => {
                                                              showImageViewer(
                                                                context,
                                                                Image.network(_postDetailX.postDetail.value.postImages?[imgIndex]).image,
                                                                swipeDismissible: true,
                                                                doubleTapZoomable: true,
                                                              )
                                                            },
                                                            child: Container(
                                                              width: imageBoxSize,
                                                              height: imageBoxSize,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  image: DecorationImage(image: NetworkImage(_postDetailX.postDetail.value.postImages?[imgIndex] ?? ''), fit: BoxFit.cover)),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6.w)
                                                        ]);
                                                      }),
                                                )),
                                            SizedBox(
                                              height: 10.w,
                                            ),

                                            /// 게시판 상세 페이지 버튼 리스트
                                            Container(
                                              padding: EdgeInsets.only(left: contentsPadding.w, right: contentsPadding.w),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Obx(() => DetailBtn(
                                                            name: '좋아요',
                                                            svg: 'assets/icons/sentiment.svg',
                                                            onTap: onLikedByMe,
                                                            active: _postDetailX.postDetail.value.isLikedByMe ?? false,
                                                          )),
                                                    ],
                                                  ),
                                                  Obx(() => CommentSide(
                                                        imgCnt: _postDetailX.postDetail.value.postImages?.length ?? 0,
                                                        likeCnt: _postDetailX.postDetail.value.postLikeCnt ?? 0,
                                                        commentCnt: _postDetailX.postDetail.value.postCommentCnt ?? 0,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 15,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                // POINT
                                                color: Palette.paper,
                                                width: 1.0,
                                              ))),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      /// 게시판 상세 페이지 COMMENT UI
                                      return Column(
                                        children: [
                                          Obx(() => CommentBox(
                                                authorId: _postDetailX.boardComment[commentInt].authorId ?? 0,
                                                authorMajor: _postDetailX.boardComment[commentInt].authorMajor ?? '',
                                                authorNickname: _postDetailX.boardComment[commentInt].authorNickname ?? '',
                                                authorProfileImg: _postDetailX.boardComment[commentInt].authorProfileImg ?? '',
                                                isBlind: _postDetailX.boardComment[commentInt].isBlind ?? false,
                                                commentId: _postDetailX.boardComment[commentInt].commentId ?? 0,
                                                commentCreatedAt: _postDetailX.boardComment[commentInt].commentCreatedAt ?? '',
                                                commentLikeCnt: _postDetailX.boardComment[commentInt].commentLikeCnt ?? 0,
                                                commentDesc: _postDetailX.boardComment[commentInt].commentDesc ?? '',
                                                isLikedByMe: _postDetailX.boardComment[commentInt].isLikedByMe ?? false,
                                                shape: CommentShape.top,
                                                PostAuthorId: _postDetailX.postDetail.value.authorId ?? 0,
                                              )),
                                          Obx(
                                            () => ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: _postDetailX.boardComment[commentInt].replies?.length ?? 0,
                                                itemBuilder: (BuildContext context, int repliesInt) {
                                                  return Obx(() => CommentBox(
                                                        authorId: _postDetailX.boardComment[commentInt].replies?[repliesInt].authorId ?? 0,
                                                        authorMajor: _postDetailX.boardComment[commentInt].replies?[repliesInt].authorMajor ?? '',
                                                        authorNickname: _postDetailX.boardComment[commentInt].replies?[repliesInt].authorNickname ?? '',
                                                        authorProfileImg: _postDetailX.boardComment[commentInt].replies?[repliesInt].authorProfileImg ?? '',
                                                        isBlind: _postDetailX.boardComment[commentInt].replies?[repliesInt].isBlind ?? false,
                                                        commentId: _postDetailX.boardComment[commentInt].replies?[repliesInt].replyId ?? 0,
                                                        commentCreatedAt: _postDetailX.boardComment[commentInt].replies?[repliesInt].replyCreatedAt ?? '',
                                                        commentLikeCnt: _postDetailX.boardComment[commentInt].replies?[repliesInt].replyLikeCnt ?? 0,
                                                        commentDesc: _postDetailX.boardComment[commentInt].replies?[repliesInt].replyDesc ?? '',
                                                        isLikedByMe: _postDetailX.boardComment[commentInt].replies?[repliesInt].isLikedByMe ?? false,
                                                        shape: CommentShape.bottom,
                                                        PostAuthorId: _postDetailX.postDetail.value.authorId ?? 0,
                                                      ));
                                                }),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ))),
                      ),

                      /// 게시판 상세 페이지 Textarea UI
                      Positioned(bottom: 0, left: 0, child: PostDetailTextarea(scrollController: _scrollController)),
                    ],
                  ),
                ]);
              }
            }));
  }
}

class PostDetailTextarea extends StatefulWidget {
  PostDetailTextarea({Key? key, required this.scrollController}) : super(key: key);
  final ScrollController scrollController;

  @override
  _PostDetailTextarea createState() => _PostDetailTextarea();
}

/// 댓글 Textarea
class _PostDetailTextarea extends State<PostDetailTextarea> {
  /// 댓글 값 컨트롤러 */
  final _comment = TextEditingController();
  final postId = Get.parameters['postId'];
  bool _isChecked = false;
  bool reCommentChecked = false;

  _PostDetailTextarea();

  @override
  Widget build(BuildContext context) {
    final PostDetailController _postDetailX = Get.find();

    /// 게시판 상세페이지 댓글 업데이트 이벤트
    void onCommentUpdate() {
      if (_comment.text != "") {
        if (_postDetailX.selectCommentEvent.value.checkEvent!) {
          _postDetailX.postBoardCommentReply(
            commentDesc: _comment.text,
            commentId: _postDetailX.selectCommentEvent.value.commentId!,
            anonymous: _isChecked,
          );
          _postDetailX.selectCommentReplyOff();
          _comment.clear();
          _postDetailX.getDetailBoard(postId!);
        } else {
          _postDetailX.postBoardComment(
            commentDesc: _comment.text,
            postId: postId,
            anonymous: _isChecked,
          );
          _comment.clear();
          final position = widget.scrollController.position.maxScrollExtent;
          widget.scrollController.animateTo(
            position,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      }
    }

    int boxHeight = 120;
    int boxPadding = 16;
    int inputHeight = 36;
    int inputWidthOn = 190;
    int inputWidthOff = 250;

    return Container(
      width: 360.w,
      height: boxHeight.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: boxPadding.h, horizontal: boxPadding.w),
      child: Column(
        children: [
          CustomCheck(
            size: 12,
            label: "익명",
            selectedColor: Palette.main,
            borderColor: Palette.main,
            iconSize: 10,
            checkIcon: Icon(
              Icons.check,
            ),
            isChecked: _isChecked,
            onChange: (value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Container(
                  width: 284.w,
                  height: inputHeight.h,
                  padding: EdgeInsets.symmetric(horizontal: boxPadding.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1, color: Color(0xFFE8E8E8)),
                    color: Color(0xFFF8F8F8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_isChecked)
                        SizedBox(
                            width: 40.w,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: StrutStyle(fontSize: 16.0),
                              text: TextSpan(
                                text: "@ 익명",
                                style: CommonText.BodyMediumGray,
                              ),
                            )),
                      if (_isChecked) SizedBox(width: 5.w),

                      ///여기에 대댓글일때 변경될 ui 작업쓰기
                      SizedBox(
                        width: _isChecked ? inputWidthOn.w : inputWidthOff.w,
                        height: 36.h,
                        child: CustomTextFormField(
                          focus: _isChecked ? true : false,
                          onEditingComplete: onCommentUpdate,
                          controller: _comment,
                          hint: _postDetailX.reCommentInputOn.value && _isChecked == false ? "대댓글 작성하기" : "",
                        ),
                      )
                    ],
                  )),
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

  const DetailBtn({Key? key, required this.name, required this.svg, required this.onTap, required this.active}) : super(key: key);

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
          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
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
              style: active ? CommonText.BodyEngWhite : CommonText.BodyEngMain,
            )
          ])),
    );
  }
}
