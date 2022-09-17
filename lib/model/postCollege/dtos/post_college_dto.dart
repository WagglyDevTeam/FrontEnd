import '../../post/dtos/waggly_response_dto.dart';

class PostListData {
  String majorName;
  String postTitle;
  int postId;

  PostListData(
      {required this.majorName, required this.postTitle, required this.postId});

  factory PostListData.fromJson(Map<String, dynamic> json) => PostListData(
        majorName: json["majorName"],
        postTitle: json["postTitle"],
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "majorName": majorName,
        "postTitle": postTitle,
        "postId": postId,
      };

  static fromMap(Map<String, Object> map) {}
}

class PostCollegeData {
  List<PostListData> posts;
  String collegeType;
  String collegeTypeName;

  PostCollegeData({
    required this.posts,
    required this.collegeType,
    required this.collegeTypeName,
  });

  factory PostCollegeData.fromJson(Map<String, dynamic> json) =>
      PostCollegeData(
        posts: List<PostListData>.from(
            json["posts"].map((x) => PostListData.fromJson(x))),
        collegeType: json["collegeType"],
        collegeTypeName: json["collegeTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "collegeType": collegeType,
        "collegeTypeName": collegeTypeName,
      };
}

class PostSpecificData {
  String postDesc;
  int postImageCnt;
  int postLikeCnt;
  int postCommentCnt;
  bool isLikedByMe;
  bool isBlind;
  String authorMajor;
  String postTitle;
  String postCreatedAt;
  int postId;

  PostSpecificData(
      {required this.postDesc,
      required this.postImageCnt,
      required this.postLikeCnt,
      required this.postCommentCnt,
      required this.isLikedByMe,
      required this.isBlind,
      required this.authorMajor,
      required this.postTitle,
      required this.postCreatedAt,
      required this.postId});
}
