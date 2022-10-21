import 'package:waggly/components/myPage/active/request_list.dart';

class PostDetailData {
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;
  String? postDesc;
  List<dynamic>? postImages;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  int? authorId;
  String? authorNickname;
  bool? isAnonymous;
  String? authorProfileImg;

  PostDetailData(
      {this.postId,
      this.postTitle,
      this.postDesc,
      this.postCreatedAt,
      this.postImages,
      this.postLikeCnt,
      this.postCommentCnt,
      this.isLikedByMe,
      this.authorId,
      this.authorMajor,
      this.authorNickname,
      this.isBlind,
      this.isAnonymous,
      this.authorProfileImg})
      : super();

  factory PostDetailData.fromJson(Map<String, dynamic> json) => PostDetailData(
      postId: json["postId"] as int,
      postTitle: json["postTitle"] as String,
      postDesc: json["postDesc"] as String,
      postCreatedAt: json["postCreatedAt"] as String,
      postImages: json["postImages"] as List<dynamic>,
      postLikeCnt: json["postLikeCnt"] as int,
      postCommentCnt: json["postCommentCnt"] as int,
      isLikedByMe: json["isLikedByMe"] as bool,
      authorId: json["authorId"] as int,
      authorMajor: json["authorMajor"] as String,
      authorNickname: json["authorNickname"] as String,
      isBlind: json["isBlind"] as bool,
      isAnonymous: json["isAnonymous"] as bool,
      authorProfileImg: json['authorProfileImg'] as String);

  factory PostDetailData.fromClass(PostDetailData postDetailData) =>
      PostDetailData(
          postImages: postDetailData.postImages,
          postDesc: postDetailData.postDesc,
          postLikeCnt: postDetailData.postLikeCnt,
          postCommentCnt: postDetailData.postCommentCnt,
          isLikedByMe: postDetailData.isLikedByMe,
          isBlind: postDetailData.isBlind,
          authorNickname: postDetailData.authorNickname,
          authorId: postDetailData.authorId,
          authorProfileImg: postDetailData.authorProfileImg,
          authorMajor: postDetailData.authorMajor,
          postTitle: postDetailData.postTitle,
          postCreatedAt: postDetailData.postCreatedAt,
          postId: postDetailData.postId);

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
        "isAnonymous": isAnonymous,
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

class CommentRequestDto {
  String? commentDesc;
  bool? anonymous;
  CommentRequestDto({this.commentDesc, this.anonymous});
  factory CommentRequestDto.fromJson(Map<String, dynamic> json) =>
      CommentRequestDto(
        commentDesc: json['commentDesc'] as String,
        anonymous: json['anonymous'] as bool,
      );
  Map<String, dynamic> toJson() => {
        "commentDesc": commentDesc,
        "anonymous": anonymous,
      };
}

class CommentLikeRequestDto {
  int? commentLikeCnt;
  bool? isLikedByMe;
  CommentLikeRequestDto({this.commentLikeCnt, this.isLikedByMe});
  factory CommentLikeRequestDto.fromJson(Map<String, dynamic> json) =>
      CommentLikeRequestDto(
        commentLikeCnt: json['commentLikeCnt'] as int,
        isLikedByMe: json['isLikedByMe'] as bool,
      );
  Map<String, dynamic> toJson() => {
        "commentLikeCnt": commentLikeCnt,
        "isLikedByMe": isLikedByMe,
      };
}

class ReCommentRequestDto {
  String? replyDesc;
  bool? anonymous;
  ReCommentRequestDto({this.replyDesc, this.anonymous});
  factory ReCommentRequestDto.fromJson(Map<String, dynamic> json) =>
      ReCommentRequestDto(
        replyDesc: json['replyDesc'] as String,
        anonymous: json['anonymous'] as bool,
      );
  Map<String, dynamic> toJson() => {
        "replyDesc": replyDesc,
        "anonymous": anonymous,
      };
}

class likeDetailRequestDto {
  int? postLikeCnt;
  bool? likedByMe;
  likeDetailRequestDto({this.postLikeCnt, this.likedByMe});
  factory likeDetailRequestDto.fromJson(Map<String, dynamic> json) =>
      likeDetailRequestDto(
        postLikeCnt: json['postLikeCnt'] as int,
        likedByMe: json['likedByMe'] as bool,
      );
  Map<String, dynamic> toJson() => {
        "postLikeCnt": postLikeCnt,
        "likedByMe": likedByMe,
      };
}
