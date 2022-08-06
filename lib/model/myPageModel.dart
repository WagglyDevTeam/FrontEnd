import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<MyCommentListModel> myCommentListModelFromJson(String str) =>
    List<MyCommentListModel>.from(
        json.decode(str).map((x) => MyCommentListModel.fromJson(x)));

String myCommentModelToJson(List<MyCommentListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyCommentListModel {
  MyCommentListModel({
    required this.commentId,
    required this.commentCreatedAt,
    required this.commentDesc,
    required this.postId,
    required this.postTitle,
    required this.boardType,
  });

  int commentId;
  String commentCreatedAt;
  String commentDesc;
  int postId;
  String postTitle;
  String boardType;

  factory MyCommentListModel.fromJson(Map<String, dynamic> json) =>
      MyCommentListModel(
        commentId: json["commentId"],
        commentCreatedAt: json["commentCreatedAt"],
        commentDesc: json["commentDesc"],
        postId: json["postId"],
        postTitle: json["postTitle"],
        boardType: json["boardType"],
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentCreatedAt": commentCreatedAt,
        "commentDesc": commentDesc,
        "postId": postId,
        "postTitle": postTitle,
        "boardType": boardType,
      };
}

//내가 작성한 글 리스트
MyPostListModel myPostListModelFromJson(String str) =>
    MyPostListModel.fromJson(json.decode(str));

String myPostListModelToJson(MyPostListModel data) =>
    json.encode(data.toJson());

class MyPostListModel {
  MyPostListModel({
    required this.code,
    required this.success,
    required this.datas,
  });

  int code;
  bool success;
  List<Data> datas;

  factory MyPostListModel.fromJson(Map<String, dynamic> json) =>
      MyPostListModel(
        code: json["code"],
        success: json["success"],
        datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.postId,
    required this.postTitle,
    required this.postDesc,
    required this.postCreatedAt,
    required this.authorMajor,
    required this.postImageCnt,
    required this.postLikeCnt,
    required this.postCommentCnt,
    required this.isLikedByMe,
  });

  int postId;
  String postTitle;
  String postDesc;
  String postCreatedAt;
  String authorMajor;
  int postImageCnt;
  int postLikeCnt;
  int postCommentCnt;
  bool isLikedByMe;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postId: json["postId"],
        postTitle: json["postTitle"],
        postDesc: json["postDesc"],
        postCreatedAt: json["postCreatedAt"],
        authorMajor: json["authorMajor"],
        postImageCnt: json["postImageCnt"],
        postLikeCnt: json["postLikeCnt"],
        postCommentCnt: json["postCommentCnt"],
        isLikedByMe: json["isLikedByMe"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "postTitle": postTitle,
        "postDesc": postDesc,
        "postCreatedAt": postCreatedAt,
        "authorMajor": authorMajor,
        "postImageCnt": postImageCnt,
        "postLikeCnt": postLikeCnt,
        "postCommentCnt": postCommentCnt,
        "isLikedByMe": isLikedByMe,
      };
}
