import 'dart:convert';

MyPostModel myPostModelFromJson(String str) =>
    MyPostModel.fromJson(json.decode(str));

String myPostModelToJson(MyPostModel data) => json.encode(data.toJson());

class MyPostModel {
  MyPostModel({
    required this.code,
    required this.success,
    required this.datas,
  });

  int code;
  bool success;
  List<Data> datas;

  factory MyPostModel.fromJson(Map<String, dynamic> json) => MyPostModel(
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
  int postId;
  String postTitle;
  String postDesc;
  DateTime postCreatedAt;
  String authorMajor;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool isLikedByMe;

  Data({
    required this.postId,
    required this.postTitle,
    required this.postDesc,
    required this.postCreatedAt,
    required this.authorMajor,
    this.postImageCnt,
    this.postLikeCnt,
    this.postCommentCnt,
    required this.isLikedByMe,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postId: json["postId"],
        postTitle: json["postTitle"],
        postDesc: json["postDesc"],
        postCreatedAt: DateTime.parse(json['postCreatedAt']),
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
