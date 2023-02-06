import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:waggly/controller/post/post_home_controller.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/model/post/dtos/post_detail_dto.dart';
import '../../model/post/dtos/post_edit_request_dto.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../repository/post_repository.dart';

class PostDetailController extends GetxController {
  final PostHomeController postHome = PostHomeController();
  final PostRepository _postRepository = PostRepository();
  final postDetail = PostDetailData().obs;
  final postId = "".obs;
  final boardComment = [CommentData()].obs;
  final selectCommentEvent = SelectComment(
    commentId: 0,
    name: '',
    checkEvent: false,
  ).obs;

  @override
  void onClose() {
    super.onClose();
    resetDetailBoard();
  }

  ///  게시판 상세 페이지 데이터 불러오기
  Future<void> getDetailBoard(String postId) async {
    WagglyResponseDto result = await _postRepository.getDetailBoard(postId);
    dynamic postJson = result.datas["post"];
    dynamic commentsJson = result.datas["comments"];
    PostDetailData postDetailMap = PostDetailData.fromJson(postJson);
    ListCommentData boardCommentMap = ListCommentData.fromJson({"comments": commentsJson});
    postDetail.value = postDetailMap;
    boardComment.value = boardCommentMap.comments!;
    print(jsonEncode(postDetail.value));
  }

  /// 게시판 상세 페이지 좋아요 업데이트
  Future<void> updateDetailBoardLike({required bool isLikedByMe, required int postLikeCnt, required int postId}) async {
    print("$isLikedByMe, $postLikeCnt , $postId");
    likeDetailRequestDto data = likeDetailRequestDto(postLikeCnt: postLikeCnt, likedByMe: isLikedByMe);

    WagglyResponseDto result = await _postRepository.likeDetailPost(postId, data);
    postDetail.value.isLikedByMe = result.datas['isLikedByMe'];
    postDetail.value.postLikeCnt = result.datas['postLikeCnt'];
    update();
    postDetail.refresh();
  }

  /// 게시판 상세 페이지 즐겨찾기 업데이트
  Future<void> updateDetailBoardBookmark({required bool isBlind, required int postId}) async {
    print("$isBlind, $postId");
    postDetail.value.isBlind = isBlind;
    update();
    postDetail.refresh();
  }

  /// 게시판 상세 페이지 댓글 작성
  Future<void> postBoardComment({required String commentDesc, String? postId, required bool anonymous}) async {
    CommentRequestDto data = CommentRequestDto(commentDesc: commentDesc, anonymous: anonymous);
    WagglyResponseDto result = await _postRepository.postComment(postId, data);
    final box = Hive.box<User>('user');
    var authorId = box.get('user')?.id;
    var authorNickname = box.get('user')?.nickName;
    var authorMajor = box.get('user')?.major;
    var authorProfileImg = box.get('user')?.profileImg;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd HH:mm');
    final formatted = formatter.format(now);

    var rng = Random();

    dynamic resCommentId = result.datas["commentId"];
    // / 서버에서 수신된 응답 JSON 데이터를 Map 형태로 치환
    final commentMap = CommentData(
      commentId: resCommentId,
      commentCreatedAt: formatted,
      commentLikeCnt: 0,
      commentDesc: commentDesc,
      isLikedByMe: false,
      authorId: authorId,
      authorMajor: authorMajor,
      authorNickname: anonymous ? "익명" : authorNickname,
      authorProfileImg: anonymous ? "https://cdn.pixabay.com/photo/2016/03/31/21/58/face-1296761_960_720.png" : authorProfileImg,
      isBlind: false,
      replies: [],
    );

    for (CommentData comment in boardComment.value) {
      print(comment.commentDesc);
    }
    boardComment.add(commentMap);
    update();
    boardComment.refresh();
  }

  /// 게시판 상세 페이지 대댓글 작성
  Future<void> postBoardCommentReply({required String commentDesc, required int commentId, required bool anonymous}) async {
    ReCommentRequestDto data = ReCommentRequestDto(replyDesc: commentDesc, anonymous: anonymous);
    WagglyResponseDto result = await _postRepository.postReComment(commentId, data);

    final box = Hive.box<User>('user');
    var authorId = box.get('user')?.id;
    var authorNickname = box.get('user')?.nickName;
    var authorMajor = box.get('user')?.major;
    var authorProfileImg = box.get('user')?.profileImg;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.Md().add_jm();
    final String formatted = formatter.format(now);
    dynamic resReplyId = result.datas["replyId"];
    print(authorId);

    /// 서버에서 수신된 응답 JSON 데이터를 Map 형태로 치환
    final commentMap = ReCommentData.fromJson({
      "replyId": resReplyId,
      "replyCreatedAt": formatted,
      "replyLikeCnt": 0,
      "replyDesc": commentDesc,
      "isLikedByMe": false,
      "authorId": authorId,
      "authorMajor": authorMajor,
      "authorNickname": anonymous ? "익명" : authorNickname,
      "authorProfileImg": anonymous ? "https://cdn.pixabay.com/photo/2016/03/31/21/58/face-1296761_960_720.png" : authorProfileImg,
      "isBlind": false
    });

    for (var i = 0; i < boardComment.length; i++) {
      if (boardComment[i].commentId == commentId) {
        boardComment[i].replies?.add(commentMap);
        update();
        boardComment.refresh();
      }
    }
  }

  /// 게시판 상세 페이지 댓글 좋아요
  Future<void> updateLikeBoardComment({required int commentId, required bool isLikedByMe, required int commentLikeCnt}) async {
    CommentLikeRequestDto data = CommentLikeRequestDto(commentLikeCnt: commentLikeCnt, isLikedByMe: isLikedByMe);
    WagglyResponseDto result = await _postRepository.putCommentLike(commentId, data);
    dynamic likedMeJson = result.datas["isLikedByMe"];
    dynamic cntJson = result.datas["commentLikeCnt"];

    for (var i = 0; i < boardComment.length; i++) {
      if (boardComment[i].commentId == commentId) {
        if (boardComment[i].commentLikeCnt != null) {
          boardComment[i].commentLikeCnt = cntJson;
          boardComment[i].isLikedByMe = likedMeJson;
          update();
          boardComment.refresh();
        }
      }
    }
  }

  /// 게시판 상세 페이지 대댓글 좋아요
  Future<void> updateLikeBoardCommentReply({required int commentId}) async {
    print("$commentId reply");
  }

  /// 게시판 상세 페이지 댓글 삭제
  Future<void> delectBoardComment({required int commnetId}) async {
    print("$commnetId comment");
  }

  /// 게시판 상세 페이지 대댓글 삭제
  Future<void> delectBoardCommentReply({required int replycommnetId}) async {
    print("$replycommnetId reply");
  }

  /// 게시판 상세 페이지 대댓글 이벤트 off
  Future<void> selectCommentReplyOff() async {
    selectCommentEvent.value = SelectComment(name: '', commentId: 0, checkEvent: false);
  }

  /// 게시판 상세 페이지 대댓글 이벤트 on
  Future<void> selectCommentReplyOn({required int commentId, required String name}) async {
    selectCommentEvent.value = SelectComment(name: name, checkEvent: true, commentId: commentId);
  }

  ///  게시판 상세 페이지 데이터 Getx 초기화
  void resetDetailBoard() {
    postDetail.value = PostDetailData();
    boardComment.value = [CommentData()];
    selectCommentEvent.value = SelectComment(
      commentId: 0,
      name: '',
      checkEvent: false,
    );
  }

  PostDetailData getPostDetailData() {
    return postDetail.value;
  }

  void updatePostId(value) {
    postId.value = value;
  }

  Future<void> editBoard(PostEditRequestDto postEditRequestDto) async {
    FormData form = FormData(postEditRequestDto.toJson());
    await _postRepository.editBoard(form, postId);
  }
}
