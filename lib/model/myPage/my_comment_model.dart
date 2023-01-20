import 'dart:convert';

MyCommentModel myCommentModelFromJson(String str) =>
    MyCommentModel.fromJson(json.decode(str));

String myCommentModelToJson(MyCommentModel data) => json.encode(data.toJson());

class MyCommentDto{
  MyCommentDto({
    required this.page,
    required this.size,
  });

  final int page;
  final int size;

  factory MyCommentDto.fromJson(Map<String, dynamic> json) => MyCommentDto(
      page: json["page"], size: json['size']);
  Map<String, dynamic> toJson() => { "page" : page, "size": size};
}

class MyCommentModel {
  MyCommentModel({
    required this.code,
    required this.message,
    required this.status,
    required this.datas,
  });

  final int? code;
  final String? message;
  final String? status;
  final Data datas;

  factory MyCommentModel.fromJson(Map<String, dynamic> json) => MyCommentModel(
    code: json["code"],
    message: json["message"],
    status: json["status"],
    datas: Data.fromJson(json["datas"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "status": status,
    "datas": datas.toJson(),
  };
}

class Data{
  Data({
    required this.myComments,
  });

  List<MyComment> myComments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    myComments:
    List<MyComment>.from(json["myComments"].map((x) => MyComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "myComments": List<dynamic>.from(myComments.map((x) => x.toJson())),
  };
}

class MyComment {
  MyComment({
    required this.commentId,
    required this.commentCreatedAt,
    required this.commentDesc,
    required this.postId,
    required this.postTitle,
    required this.boardType,
  });

  final int commentId;
  final DateTime commentCreatedAt;
  final String commentDesc;
  final int postId;
  final String postTitle;
  final String boardType;

  factory MyComment.fromJson(Map<String, dynamic> json) => MyComment(
        commentId: json["commentId"],
        commentCreatedAt: DateTime.parse(json["commentCreatedAt"]),
        commentDesc: json["commentDesc"],
        postId: json["postId"],
        postTitle: json["postTitle"],
        boardType: json["boardType"],
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentCreatedAt": commentCreatedAt.toIso8601String(),
        "commentDesc": commentDesc,
        "postId": postId,
        "postTitle": postTitle,
        "boardType": boardType,
      };
}
