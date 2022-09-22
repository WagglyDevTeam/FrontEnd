import 'dart:math';

import 'package:get/get.dart';
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
    print("sss $postId");
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
      {required String commentDesc, required int postId}) async {
    /// 서버에서 수신된 응답 JSON 데이터를 Map 형태로 치환
    final commentMap = CommentData.fromJson({
      "commentId": 22,
      "commentCreatedAt": "02.18 19:50",
      "commentLikeCnt": 4,
      "commentDesc": commentDesc,
      "isLikedByMe": false,
      "authorId": 0,
      "authorMajor": "시각디자인학과",
      "authorNickname": "익명",
      "authorProfileImg":
          "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
      "isBlind": false,
      "replies": [],
    });
    boardComment.insert(0, commentMap);
    update();
    boardComment.refresh();
  }

  /// 게시판 상세 페이지 대댓글 작성
  Future<void> postBoardCommentReply(
      {required String commentDesc, required int commentId}) async {
    /// 서버에서 수신된 응답 JSON 데이터를 Map 형태로 치환
    final commentMap = ReCommentData.fromJson({
      "replyId": 2,
      "replyCreatedAt": "02.18 19:50",
      "replyLikeCnt": 0,
      "replyDesc": commentDesc,
      "isLikedByMe": false,
      "authorId": 4,
      "authorMajor": "시각디자인학과",
      "authorNickname": "익명",
      "authorProfileImg":
          "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
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
}
