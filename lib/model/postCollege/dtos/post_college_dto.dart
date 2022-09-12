class PostListData {
  String authorMajor;
  String postTitle;
  String postCreatedAt;
  int postId;

  PostListData(
      {required this.authorMajor,
        required this.postTitle,
        required this.postCreatedAt,
        required this.postId});

  factory PostListData.fromJson(Map<String, dynamic> json) => PostListData(
    authorMajor: json["authorMajor"],
    postTitle: json["postTitle"],
    postCreatedAt: json["postCreatedAt"],
    postId: json["postId"],
  );

  Map<String, dynamic> toJson() => {
    "authorMajor": authorMajor,
    "postTitle": postTitle,
    "postCreatedAt": postCreatedAt,
    "postId": postId,
  };

  static fromMap(Map<String, Object> map) {}
}

class PostCollegeData {
  List<PostListData> postList;
  String postCollegeName;
  String postColoegeId;

  PostCollegeData({
    required this.postList,
    required this.postCollegeName,
    required this.postColoegeId,
  });

  factory PostCollegeData.fromJson(Map<String, dynamic> json) =>
      PostCollegeData(
        postList: List<PostListData>.from(
            json["postList"].map((x) => PostListData.fromJson(x))),
        postCollegeName: json["postCollegeName"],
        postColoegeId: json["postColoegeId"],
      );

  Map<String, dynamic> toJson() => {
    "postList": List<dynamic>.from(postList.map((x) => x.toJson())),
    "postCollegeName": postCollegeName,
    "postColoegeId": postColoegeId,
  };
}

class PostSpecificData extends PostListData {
  String postDesc;
  int postImageCnt;
  int postLikeCnt;
  int postCommentCnt;
  bool isLikedByMe;
  bool isBlind;

  PostSpecificData(
      {required this.postDesc,
        required this.postImageCnt,
        required this.postLikeCnt,
        required this.postCommentCnt,
        required this.isLikedByMe,
        required this.isBlind,
        required String authorMajor,
        required String postTitle,
        required String postCreatedAt,
        required int postId})
      : super(
      authorMajor: authorMajor,
      postTitle: postTitle,
      postCreatedAt: postCreatedAt,
      postId: postId);
}