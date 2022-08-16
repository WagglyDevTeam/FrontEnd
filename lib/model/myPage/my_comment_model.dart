import 'dart:convert';

MyCommentModel myCommentModelFromJson(String str) =>
    MyCommentModel.fromJson(json.decode(str));

String myCommentModelToJson(MyCommentModel data) => json.encode(data.toJson());

class MyCommentModel {
  MyCommentModel({
    required this.code,
    required this.success,
    required this.datas,
  });

  int code;
  bool success;
  List<Data> datas;

  factory MyCommentModel.fromJson(Map<String, dynamic> json) => MyCommentModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
