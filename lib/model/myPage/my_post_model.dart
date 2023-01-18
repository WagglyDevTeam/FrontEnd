import 'dart:convert';

MyPostModel myPostModelFromJson(String str) =>
    MyPostModel.fromJson(json.decode(str));

String myPostModelToJson(MyPostModel data) => json.encode(data.toJson());

class MyPostDto{
  MyPostDto({
    required this.page,
    required this.size,
});

  final int page;
  final int size;

  factory MyPostDto.fromJson(Map<String, dynamic> json) => MyPostDto(
    page: json["page"], size: json['size']);
  Map<String, dynamic> toJson() => { "page" : page, "size": size};
}

class MyPostModel {
  MyPostModel({
    required this.code,
    required this.message,
    required this.status,
    required this.datas,
  });

  final int code;
  final String message;
  final String status;
  final Datas datas;

  factory MyPostModel.fromJson(Map<String, dynamic> json) => MyPostModel(
        code: json["code"],
        message: json["message"],
        status: json["status"],
        datas: Datas.fromJson(json["datas"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "status": status,
        "datas": datas.toJson(),
      };
}

class Datas {
  Datas({
    required this.myPosts,
  });

  List<MyPost> myPosts;

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        myPosts:
            List<MyPost>.from(json["myPosts"].map((x) => MyPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "myPosts": List<dynamic>.from(myPosts.map((x) => x.toJson())),
      };
}

class MyPost {
  MyPost({
    required this.postId,
    required this.postTitle,
    required this.postDesc,
    required this.postCreatedAt,
    required this.authorMajor,
    this.postImageCnt,
    this.postLikeCnt,
    this.postCommentCnt,
    this.isBlind,
    required this.isLikedByMe,
    this.isAnonymous,
  });

  int postId;
  String postTitle;
  String postDesc;
  DateTime postCreatedAt;
  String authorMajor;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  bool? isAnonymous;

  factory MyPost.fromJson(Map<String, dynamic> json) => MyPost(
        postId: json["postId"],
        postTitle: json["postTitle"],
        postDesc: json["postDesc"],
        postCreatedAt: DateTime.parse(json["postCreatedAt"]),
        authorMajor: json["authorMajor"],
        postImageCnt: json["postImageCnt"],
        postLikeCnt: json["postLikeCnt"],
        postCommentCnt: json["postCommentCnt"],
        isLikedByMe: json["isLikedByMe"],
        isBlind: json["isBlind"],
        isAnonymous: json["isAnonymous"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "postTitle": postTitle,
        "postDesc": postDesc,
        "postCreatedAt": postCreatedAt.toIso8601String(),
        "authorMajor": authorMajor,
        "postImageCnt": postImageCnt,
        "postLikeCnt": postLikeCnt,
        "postCommentCnt": postCommentCnt,
        "isLikedByMe": isLikedByMe,
        "isBlind": isBlind,
        "isAnonymous":isAnonymous,
      };
}
//
// enum AuthorMajor { EMPTY }
//
// final authorMajorValues = EnumValues({"인류학과": AuthorMajor.EMPTY});
//
// class EnumValues<T> {
//   late Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
