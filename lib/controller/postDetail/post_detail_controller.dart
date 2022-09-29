import 'dart:math';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:waggly/model/post/dtos/post_detail_dto.dart';
import '../../model/hive/user.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../model/post/post_repository.dart';

class PostDetailController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final postDetail = PostDetailData().obs;
  final boardComment = [CommentData()].obs;
  final selectCommentEvent = SelectComment(
    commentId: 0,
    name: '',
    checkEvent: false,
  ).obs;

  @override
  void onInit() async {
    super.onInit();
  }

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
    ListCommentData boardCommentMap =
        ListCommentData.fromJson({"comments": commentsJson});
    postDetail.value = postDetailMap;
    boardComment.value = boardCommentMap.comments!;
  }

  /// 게시판 상세 페이지 좋아요 업데이트
  Future<void> updateDetailBoardLike(
      {required bool isLikedByMe,
      required int postLikeCnt,
      required int postId}) async {
    print("$isLikedByMe, $postLikeCnt , $postId");
    likeDetailRequestDto data =
        likeDetailRequestDto(postLikeCnt: postLikeCnt, likedByMe: isLikedByMe);

    WagglyResponseDto result =
        await _postRepository.likeDetailPost(postId, data);
    postDetail.value.isLikedByMe = isLikedByMe;
    postDetail.value.postLikeCnt = postLikeCnt;
    update();
    postDetail.refresh();
  }

  /// 게시판 상세 페이지 즐겨찾기 업데이트
  Future<void> updateDetailBoardBookmark(
      {required bool isBlind, required int postId}) async {
    print("$isBlind, $postId");
    postDetail.value.isBlind = isBlind;
    update();
    postDetail.refresh();
  }

  /// 게시판 상세 페이지 댓글 작성
  Future<void> postBoardComment(
      {required String commentDesc,
      String? postId,
      required bool anonymous}) async {
    print("-----------");
    print(anonymous);
    print(postId);
    print("-----------");

    CommentRequestDto data =
        CommentRequestDto(commentDesc: commentDesc, anonymous: anonymous);
    WagglyResponseDto result = await _postRepository.postComment(postId, data);
    final box = Hive.box<User>('user');
    var authorId = box.get('user')?.id;
    var authorNickname = box.get('user')?.nickName;
    var authorMajor = box.get('user')?.major;
    var authorProfileImg = box.get('user')?.profileImg;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.Md().add_jm();
    final String formatted = formatter.format(now);
    var rng = Random();

    // / 서버에서 수신된 응답 JSON 데이터를 Map 형태로 치환
    final commentMap = CommentData.fromJson({
      "commentId": 123123123,
      "commentCreatedAt": formatted,
      "commentLikeCnt": 0,
      "commentDesc": commentDesc,
      "isLikedByMe": false,
      "authorId": authorId,
      "authorMajor": authorMajor,
      "authorNickname": anonymous ? "익명" : authorNickname,
      "authorProfileImg": anonymous
          ? "https://cdn.pixabay.com/photo/2016/03/31/21/58/face-1296761_960_720.png"
          : authorProfileImg,
      "isBlind": false,
      "replies": [],
    });
    boardComment.insert(0, commentMap);
    update();
    boardComment.refresh();
  }

  /// 게시판 상세 페이지 대댓글 작성
  Future<void> postBoardCommentReply(
      {required String commentDesc,
      required int commentId,
      required bool anonymous}) async {
    ReCommentRequestDto data =
        ReCommentRequestDto(replyDesc: commentDesc, anonymous: anonymous);
    WagglyResponseDto result =
        await _postRepository.postReComment(commentId, data);

    final box = Hive.box<User>('user');
    var authorId = box.get('user')?.id;
    var authorNickname = box.get('user')?.nickName;
    var authorMajor = box.get('user')?.major;
    var authorProfileImg = box.get('user')?.profileImg;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.Md().add_jm();
    final String formatted = formatter.format(now);

    print(authorId);

    /// 서버에서 수신된 응답 JSON 데이터를 Map 형태로 치환
    final commentMap = ReCommentData.fromJson({
      "replyId": 2,
      "replyCreatedAt": formatted,
      "replyLikeCnt": 0,
      "replyDesc": commentDesc,
      "isLikedByMe": false,
      "authorId": authorId,
      "authorMajor": authorMajor,
      "authorNickname": anonymous ? "익명" : authorNickname,
      "authorProfileImg": anonymous
          ? "https://cdn.pixabay.com/photo/2016/03/31/21/58/face-1296761_960_720.png"
          : authorProfileImg,
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

  Future<void> postDelete({required int postId}) async {
    WagglyResponseDto result = await _postRepository.PostDelete(postId);
    if (result.code == 200) {
      Get.toNamed("/post");
    }
  }

  /// 게시판 상세 페이지 댓글 좋아요
  Future<void> updateLikeBoardComment({required int commentId}) async {
    print("$commentId comment");
    for (var i = 0; i < boardComment.length; i++) {
      if (boardComment[i].commentId == commentId) {
        boardComment[i].commentLikeCnt! + 1;
        update();
        boardComment.refresh();
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
    selectCommentEvent.value =
        SelectComment(name: '', commentId: 0, checkEvent: false);
  }

  /// 게시판 상세 페이지 대댓글 이벤트 on
  Future<void> selectCommentReplyOn(
      {required int commentId, required String name}) async {
    selectCommentEvent.value =
        SelectComment(name: name, checkEvent: true, commentId: commentId);
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
}
