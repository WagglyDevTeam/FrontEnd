import 'package:get/get.dart';
import 'package:waggly/controller/post/post_home_controller.dart';
import 'package:waggly/model/post/dtos/post_detail_dto.dart';
import '../../model/post/dtos/post_edit_request_dto.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../repository/post_repository.dart';

class PostDetailController extends GetxController {
  final PostHomeController postHome = PostHomeController();
  final PostRepository _postRepository = PostRepository();
  final postDetail = PostDetailData().obs;
  final postId = "".obs;
  var authorId = -1;
  final boardComment = [CommentData()].obs;
  final selectCommentEvent = SelectComment(
    commentId: 0,
    name: '',
    checkEvent: false,
  ).obs;
  final reCommentInputOn = false.obs;

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
    authorId = postDetailMap.authorId!;
  }

  /// 게시판 상세 페이지 좋아요 업데이트
  Future<void> updateDetailBoardLike({required bool isLikedByMe, required int postLikeCnt, required int postId}) async {
    likeDetailRequestDto data = likeDetailRequestDto(postLikeCnt: postLikeCnt, likedByMe: isLikedByMe);

    WagglyResponseDto result = await _postRepository.likeDetailPost(postId, data);
    postDetail.value.isLikedByMe = result.datas['isLikedByMe'];
    postDetail.value.postLikeCnt = result.datas['postLikeCnt'];
    update();
    postDetail.refresh();
  }

  /// 게시판 상세 페이지 즐겨찾기 업데이트
  Future<void> updateDetailBoardBookmark({required bool isBlind, required int postId}) async {
    postDetail.value.isBlind = isBlind;
    update();
    postDetail.refresh();
  }

  /// 게시판 상세 페이지 댓글 작성
  Future<void> postBoardComment({required String commentDesc, String? postId, required bool anonymous}) async {
    CommentRequestDto data = CommentRequestDto(commentDesc: commentDesc, anonymous: anonymous);
    await _postRepository.postComment(postId, data);
    await getDetailBoard(postId!);
  }

  /// 게시판 상세 페이지 대댓글 작성
  Future<void> postBoardCommentReply({required String commentDesc, required int commentId, required bool anonymous}) async {
    ReCommentRequestDto data = ReCommentRequestDto(replyDesc: commentDesc, anonymous: anonymous);
    await _postRepository.postReComment(commentId, data);
    await getDetailBoard(postId.value);
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
  Future<void> delectBoardComment({required int commentId}) async {
    await _postRepository.deleteComment(commentId);
    await getDetailBoard(postId.value);
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

  Future<WagglyResponseDto> editBoard(PostEditRequestDto postEditRequestDto) async {
    FormData form = FormData(postEditRequestDto.toJson());
    WagglyResponseDto response = await _postRepository.editBoard(form, postId);
    PostDetailData postDetailMap = PostDetailData.fromJson(response.datas);
    postDetail.value = postDetailMap;
    update();
    postDetail.refresh();
    return response;
  }
}
