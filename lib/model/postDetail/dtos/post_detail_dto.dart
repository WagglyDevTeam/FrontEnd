import 'package:waggly/components/myPage/active/request_list.dart';

class PostDetailData {
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;
  String? postDesc;
  List<String>? postImages;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  int? authorId;
  String? authorNickname;
  String? authorProfileImg;
  PostDetailData({
    this.postImages,
    this.postDesc,
    this.postLikeCnt,
    this.postCommentCnt,
    this.isLikedByMe,
    this.isBlind,
    this.authorNickname,
    this.authorId,
    this.authorProfileImg,
    this.authorMajor,
    this.postTitle,
    this.postCreatedAt,
    this.postId,
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
  Map<String, dynamic> toJson() => {
        "postImages": postImages,
        "postDesc": postDesc,
        "postLikeCnt": postLikeCnt,
        "postCommentCnt": postCommentCnt,
        "isLikedByMe": isLikedByMe,
        "isBlind": isBlind,
        "authorNickname": authorNickname,
        "authorId": authorId,
        "authorProfileImg": authorProfileImg,
        "authorMajor": authorMajor,
        "postTitle": postTitle,
        "postCreatedAt": postCreatedAt,
        "postId": postId
      };
}

class ReCommentData {
  int? replyId;
  String? replyCreatedAt;
  late int? replyLikeCnt;
  String? replyDesc;
  bool? isLikedByMe;
  int? authorId;
  String? authorMajor;
  String? authorNickname;
  String? authorProfileImg;
  bool? isBlind;

  ReCommentData({
    this.replyId,
    this.replyCreatedAt,
    this.replyLikeCnt,
    this.replyDesc,
    this.isLikedByMe,
    this.authorId,
    this.authorMajor,
    this.authorNickname,
    this.authorProfileImg,
    this.isBlind,
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
  int? commentId;
  String? commentCreatedAt;
  late int? commentLikeCnt;
  String? commentDesc;
  bool? isLikedByMe;
  int? authorId;
  String? authorMajor;
  String? authorNickname;
  String? authorProfileImg;
  bool? isBlind;
  List<ReCommentData>? replies;

  CommentData({
    this.commentId,
    this.commentCreatedAt,
    this.commentLikeCnt,
    this.commentDesc,
    this.isLikedByMe,
    this.replies,
    this.authorId,
    this.authorMajor,
    this.authorNickname,
    this.authorProfileImg,
    this.isBlind,
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
  List<CommentData>? comments;
  ListCommentData({
    this.comments,
  });

  factory ListCommentData.fromJson(Map<String, dynamic> json) =>
      ListCommentData(
          comments: List<CommentData>.from(
              json['comments'].map((x) => CommentData.fromJson(x))));
}

class SelectComment {
  String? name;
  int? commentId;
  bool? checkEvent;
  SelectComment({this.name, this.commentId, this.checkEvent});
  factory SelectComment.fromJson(Map<String, dynamic> json) => SelectComment(
        name: json['name'] as String,
        commentId: json['commentId'] as int,
        checkEvent: json['checkEvent'] as bool,
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "commentId": commentId,
        "checkEvent": checkEvent,
      };
}
