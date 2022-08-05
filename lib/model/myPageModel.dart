import 'dart:convert';

List<MyPostListModel> myPostListModelFromJson(String str) =>
    List<MyPostListModel>.from(
        json.decode(str).map((x) => MyPostListModel.fromJson(x)));

String myPostListModelToJson(List<MyPostListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyPostListModel {
  MyPostListModel({
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

  factory MyPostListModel.fromJson(Map<String, dynamic> json) =>
      MyPostListModel(
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
