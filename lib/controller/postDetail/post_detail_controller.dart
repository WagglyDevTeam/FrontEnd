import 'dart:math';

import 'package:get/get.dart';
import 'package:waggly/model/postDetail/dtos/post_detail_dto.dart';
import '../../model/hive/user.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../model/post/post_repository.dart';

final PostDetailData resetData = PostDetailData(
    authorId: 0,
    authorMajor: '',
    authorNickname: '',
    authorProfileImg: '',
    isBlind: false,
    isLikedByMe: false,
    postCommentCnt: 0,
    postCreatedAt: '',
    postDesc: '',
    postId: 0,
    postImages: [''],
    postLikeCnt: 0,
    postTitle: '');

final List<CommentData> resetcommentData = [
  CommentData(
      commentId: 0,
      commentCreatedAt: "",
      commentLikeCnt: 0,
      commentDesc: "",
      isLikedByMe: false,
      authorId: 0,
      authorMajor: "",
      authorNickname: "",
      authorProfileImg: "",
      isBlind: false,
      replies: [
        ReCommentData(
            replyId: 0,
            replyCreatedAt: "",
            replyLikeCnt: 0,
            replyDesc: "",
            isLikedByMe: true,
            authorId: 0,
            authorMajor: "",
            authorNickname: "",
            authorProfileImg: "",
            isBlind: false)
      ])
];

class PostDetailController extends GetxController {
  final _postRepository = PostRepository();
  final postDetail = resetData.obs;
  final boardComment = resetcommentData.obs;
  final selectCommentEvent = SelectComment(
    commentId: 0,
    name:'',
    checkEvent: false,
  ).obs;


  @override
  void onInit() async {
    super.onInit();
    await getDetailBoard();
  }

  @override
  void onClose() {
    super.onClose();
    resetDetailBoard();
  }
  ///  게시판 상세 페이지 데이터 불러오기
  Future<void> getDetailBoard() async {
    PostDetailData postDetailJson = PostDetailData.fromJson({
      "postId": 12,
      "postTitle": "교수님 기절바람",
      "postDesc": "얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어 얘들아 오늘 날씨가 너무 좋은데 난 과제를 하고 있어 교수님이 3일만 기절했다 일어나시면 좋겠어",
      "postCreatedAt": "02/18 19:50",
      "postImages": [
        'https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_960_720.jpg',
        'https://cdn.pixabay.com/photo/2017/07/25/01/22/cat-2536662_960_720.jpg',
        'https://cdn.pixabay.com/photo/2017/12/11/15/34/lion-3012515__340.jpg',
        "https://cdn.pixabay.com/photo/2013/01/25/13/03/cat-76116_960_720.jpg","https://cdn.pixabay.com/photo/2013/01/25/13/03/cat-76116_960_720.jpg",
      ],
      "postLikeCnt": 6,
      "postCommentCnt": 4,
      "isLikedByMe": true,
      "authorId": 6,
      "authorMajor": "시각디자인학과",
      "authorNickname": "포스팅라이트",
      "authorProfileImg":
      'https://cdn.pixabay.com/photo/2022/05/28/06/39/cat-7226671_960_720.jpg',
      "isBlind": false
    });

    ListCommentData boardCommentJson = ListCommentData.fromJson({
      "comments": [
        {
          "commentId": 2,
          "commentCreatedAt": "02.18 19:50",
          "commentLikeCnt": 4,
          "commentDesc": "ㅋㅋㅋㅋㅋㅋㅋ완전 웃겨ㅋ 사실 안웃겨",
          "isLikedByMe": true,
          "authorId": 4,
          "authorMajor": "시각디자인학과",
          "authorNickname": "익명",
          "authorProfileImg":
          "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
          "isBlind": false,
          "replies": [
            {
              "replyId": 232,
              "replyCreatedAt": "02.18 19:50",
              "replyLikeCnt": 4,
              "replyDesc": "어 나도 탑승할게 어 나도 탑승할게 어 나도 탑승할게 어 나도 탑승할게 어 나도 탑승할게 어 나도 탑승할게",
              "isLikedByMe": true,
              "authorId": 4,
              "authorMajor": "시각디자인학과",
              "authorNickname": "익명",
              "authorProfileImg":
              "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
              "isBlind": false
            },
            {
              "replyId": 63,
              "replyCreatedAt": "02.18 19:50",
              "replyLikeCnt": 4,
              "replyDesc": "너도..? 나두...",
              "isLikedByMe": true,
              "authorId": 6,
              "authorMajor": "시각디자인학과",
              "authorNickname": "포스팅라이트",
              "authorProfileImg":
              "https://cdn.pixabay.com/photo/2022/05/28/06/39/cat-7226671_960_720.jpg",
              "isBlind": false
            },
            {
              "replyId": 37,
              "replyCreatedAt": "02.18 19:50",
              "replyLikeCnt": 4,
              "replyDesc": "너도..? 나두...",
              "isLikedByMe": true,
              "authorId": 3,
              "authorMajor": "시각디자인학과",
              "authorNickname": "탈퇴자",
              "authorProfileImg":
              "https://cdn.pixabay.com/photo/2022/05/28/06/39/cat-7226671_960_720.jpg",
              "isBlind": false
            },
          ]
        },
        {
          "commentId": 33,
          "commentCreatedAt": "02.18 19:50",
          "commentLikeCnt": 4,
          "commentDesc": "ㅋㅋㅋㅋㅋㅋㅋ완전 웃겨ㅋ 사실 안웃겨",
          "isLikedByMe": true,
          "authorId": 4,
          "authorMajor": "시각디자인학과",
          "authorNickname": "익명",
          "authorProfileImg":
          "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
          "isBlind": false,
          "replies":[{
            "replyId": 3,
            "replyCreatedAt": "02.18 19:50",
            "replyLikeCnt": 4,
            "replyDesc": "너도..? 나두...",
            "isLikedByMe": true,
            "authorId": 3,
            "authorMajor": "시각디자인학과",
            "authorNickname": "탈퇴자",
            "authorProfileImg":
            "https://cdn.pixabay.com/photo/2022/05/28/06/39/cat-7226671_960_720.jpg",
            "isBlind": false
          }],
        },
        {
          "commentId": 332,
          "commentCreatedAt": "02.18 19:50",
          "commentLikeCnt": 4,
          "commentDesc": "ㅋㅋㅋㅋㅋㅋㅋ완전 웃겨ㅋ 사실 안웃겨",
          "isLikedByMe": true,
          "authorId": 4,
          "authorMajor": "시각디자인학과",
          "authorNickname": "장군이이이이",
          "authorProfileImg":
          "https://cdn.pixabay.com/photo/2017/09/25/13/12/cocker-spaniel-2785074_960_720.jpg",
          "isBlind": false,
          "replies":[],
        },
      ]
    });

    postDetail.value = postDetailJson;
    boardComment.value = boardCommentJson.comments;
  }
  /// 게시판 상세 페이지 좋아요 업데이트
  Future<void> updateDetailBoardLike({required bool isLikedByMe,required int postLikeCnt , required int postId} ) async{
    print("$isLikedByMe, $postLikeCnt , $postId");
    postDetail.value.isLikedByMe = isLikedByMe;
    postDetail.value.postLikeCnt = postLikeCnt;
    update();
    postDetail.refresh();
  }
  /// 게시판 상세 페이지 즐겨찾기 업데이트
  Future<void> updateDetailBoardBookmark({required bool isBlind , required int postId} ) async{
    print("$isBlind, $postId");
    postDetail.value.isBlind = isBlind;
    update();
    postDetail.refresh();
  }
  /// 게시판 상세 페이지 댓글 작성
  Future<void> postBoardComment({required String commentDesc , required int postId} ) async{
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
    boardComment.insert(0 , commentMap);
    update();
    boardComment.refresh();
  }
  /// 게시판 상세 페이지 대댓글 작성
  Future<void> postBoardCommentReply ({required String commentDesc ,required int commentId })async{
    print(commentId);

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

    for (var i = 0  ; i < boardComment.length  ; i++) {
      if(boardComment[i].commentId == commentId){
        boardComment[i].replies.add(commentMap);
        update();
        boardComment.refresh();
      }
    }

  }
  /// 게시판 상세 페이지 댓글 좋아요
  Future<void> updateLikeBoardComment({required int commentId })async{
    print("$commentId comment");
    for (var i = 0  ; i < boardComment.length  ; i++) {
      if(boardComment[i].commentId == commentId){
        boardComment[i].commentLikeCnt+1;
        update();
        boardComment.refresh();
      }
    }
  }
  /// 게시판 상세 페이지 대댓글 좋아요
  Future<void> updateLikeBoardCommentReply({required int commentId})async{
    print("$commentId reply");
  }
  /// 게시판 상세 페이지 댓글 삭제
  Future<void> delectBoardComment({required int commnetId })async{
      print("$commnetId comment");
  }
  /// 게시판 상세 페이지 대댓글 삭제
  Future<void> delectBoardCommentReply({required int replycommnetId })async{
    print("$replycommnetId reply");
  }
  /// 게시판 상세 페이지 대댓글 이벤트 off
  Future<void> selectCommentReplyOff()async{
    selectCommentEvent.value = SelectComment(
      name: '',
      commentId: 0,
      checkEvent: false
    );
  }
  /// 게시판 상세 페이지 대댓글 이벤트 on
  Future<void> selectCommentReplyOn({required int commentId ,required String name })async {
    selectCommentEvent.value = SelectComment(
      name: name, checkEvent: true ,commentId:commentId
    );
  }



  ///  게시판 상세 페이지 데이터 Getx 초기화
  void resetDetailBoard() {
    postDetail.value = resetData;
    boardComment.value = resetcommentData;
    selectCommentEvent.value = SelectComment(
      commentId: 0,
      name:'',
      checkEvent: false,
    );
  }
}
