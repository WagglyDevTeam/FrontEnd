import 'package:waggly/components/myPage/active/request_list.dart';

class PostDetailData  {
  String authorMajor;
  String postTitle;
  String postCreatedAt;
  int postId;
  String postDesc;
  List<String> postImages;
  int postLikeCnt;
  int postCommentCnt;
  bool isLikedByMe;
  bool isBlind;
  int authorId;
  String authorNickname;
  String authorProfileImg;
  PostDetailData({
    required this.postImages,
    required this.postDesc,
    required this.postLikeCnt,
    required this.postCommentCnt,
    required this.isLikedByMe,
    required this.isBlind,
    required this.authorNickname,
    required this.authorId,
    required this.authorProfileImg,
    required this.authorMajor,
    required this.postTitle,
    required this.postCreatedAt,
    required this.postId,
  }) : super();

  factory PostDetailData.fromJson(Map<String, dynamic> json) => PostDetailData(
      postImages: json["postImages"] as List<String>,
      postDesc: json["postDesc"] as String,
      postLikeCnt: json["postLikeCnt"] as int,
      postCommentCnt: json["postCommentCnt"] as int,
      isLikedByMe: json["isLikedByMe"] as bool,
      isBlind: json["isBlind"] as bool,
      authorNickname: json["authorNickname"] as String,
      authorId: json["authorId"] as int,
      authorProfileImg: json["authorProfileImg"] as String,
      authorMajor: json["authorMajor"] as String,
      postTitle: json["postTitle"] as String,
      postCreatedAt: json["postCreatedAt"] as String,
      postId: json["postId"] as int);

  @override
  Map<String, dynamic> toJson()=> {
    "postImages": postImages,
    "postDesc":postDesc ,
    "postLikeCnt" : postLikeCnt,
    "postCommentCnt" : postCommentCnt,
    "isLikedByMe" : isLikedByMe,
    "isBlind" : isBlind ,
    "authorNickname" : authorNickname,
    "authorId" :  authorId,
    "authorProfileImg" : authorProfileImg,
    "authorMajor" : authorMajor,
    "postTitle": postTitle,
    "postCreatedAt": postCreatedAt ,
    "postId": postId
  };
}

class ReCommentData {
  final int replyId;
  final String replyCreatedAt;
  final int replyLikeCnt;
  final String replyDesc;
  final bool isLikedByMe;
  final int authorId;
  final String authorMajor;
  final String authorNickname;
  final String authorProfileImg;
  final bool isBlind;

  ReCommentData({
    required this.replyId,
    required this.replyCreatedAt,
    required this.replyLikeCnt,
    required this.replyDesc,
    required this.isLikedByMe,
    required this.authorId,
    required this.authorMajor,
    required this.authorNickname,
    required this.authorProfileImg,
    required this.isBlind,
  });

  factory ReCommentData.fromJson(Map<String, dynamic> json) => ReCommentData(
      replyId: json["replyId"] as int,
      replyCreatedAt: json["replyCreatedAt"] as String,
      replyLikeCnt: json["replyLikeCnt"] as int,
      replyDesc: json["replyDesc"] as String,
      isLikedByMe: json["isLikedByMe"] as bool,
      authorId: json["authorId"] as int,
      authorMajor: json["authorMajor"] as String,
      authorNickname: json["authorNickname"] as String,
      authorProfileImg: json["authorProfileImg"] as String,
      isBlind: json["isBlind"] as bool);
}

class CommentData {
  final int commentId;
  final String commentCreatedAt;
  final int commentLikeCnt;
  final String  commentDesc;
  final bool isLikedByMe;
  final int authorId;
  final String authorMajor;
  final String authorNickname;
  final String authorProfileImg;
  final bool isBlind;
  final List<ReCommentData> replies;

  CommentData({
    required this.commentId,
    required this.commentCreatedAt,
    required this.commentLikeCnt,
    required this.commentDesc,
    required this.isLikedByMe,
    required this.replies,
    required this.authorId,
    required  this.authorMajor,
    required  this.authorNickname,
    required  this.authorProfileImg,
    required  this.isBlind,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
      commentId: json["commentId"] as int,
      commentCreatedAt: json["commentCreatedAt"] as String,
      commentLikeCnt: json["commentLikeCnt"] as int,
      commentDesc: json["commentDesc"] as String,
      isLikedByMe: json["isLikedByMe"] as bool,
      authorId: json["authorId"] as int,
      authorMajor: json["authorMajor"] as String,
      authorNickname: json["authorNickname"] as String,
      authorProfileImg: json["authorProfileImg"] as String,
      isBlind: json["isBlind"] as bool,
      replies: List<ReCommentData>.from(
          json["replies"].map((x) => ReCommentData.fromJson(x))));
}

class ListCommentData {
  List<CommentData> comments;
  ListCommentData({
    required this.comments,
  });

  factory ListCommentData.fromJson(Map<String, dynamic> json) =>
      ListCommentData(
          comments: List<CommentData>.from(
              json['comments'].map((x) => CommentData.fromJson(x))));
}

class SelectComment {
  String name;
  int commentId;
  bool checkEvent;
  SelectComment({required this.name,required this.commentId, required this.checkEvent});
  factory SelectComment.fromJson(Map<String , dynamic> json) => SelectComment(
      name:json['name'] as String,
      commentId : json['commentId'] as int,
      checkEvent : json['checkEvent'] as bool,
  );
  Map<String, dynamic> toJson()=> {
    "name": name,
    "commentId" : commentId,
    "checkEvent" : checkEvent,
  };
}