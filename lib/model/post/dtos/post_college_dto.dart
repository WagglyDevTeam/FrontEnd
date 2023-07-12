import 'package:intl/intl.dart';
import 'package:waggly/model/post/dtos/post_detail_dto.dart';

class PostListData {
  String majorName;
  String postTitle;
  int postId;
  DateTime? postCreatedAt;

  PostListData({required this.majorName, required this.postTitle, required this.postId, required this.postCreatedAt});

  factory PostListData.fromJson(Map<String, dynamic> json) {
    return PostListData(
      majorName: json["majorName"],
      postTitle: json["postTitle"],
      postId: json["postId"],
      postCreatedAt: DateTime.parse(json["postCreatedAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "majorName": majorName,
        "postTitle": postTitle,
        "postId": postId,
        "postCreatedAt": postCreatedAt,
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

  factory PostCollegeData.fromJson(Map<String, dynamic> json) => PostCollegeData(
        posts: List<PostListData>.from(json["posts"].map((x) => PostListData.fromJson(x))),
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
  String? postDesc;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  bool? isAnonymous;
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;

  PostSpecificData({
    this.postDesc,
    this.postImageCnt,
    this.postLikeCnt,
    this.postCommentCnt,
    this.isLikedByMe,
    this.isBlind,
    this.isAnonymous,
    this.authorMajor,
    this.postTitle,
    this.postCreatedAt,
    this.postId,
  });

  factory PostSpecificData.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('MM/dd HH:mm');

    return PostSpecificData(
        postDesc: json["postDesc"],
        postImageCnt: json["postImageCnt"],
        postLikeCnt: json["postLikeCnt"],
        postCommentCnt: json["postCommentCnt"],
        isLikedByMe: json["isLikedByMe"],
        isBlind: json["isBlind"],
        isAnonymous: json["isAnonymous"],
        authorMajor: json["authorMajor"],
        postTitle: json["postTitle"],
        postCreatedAt: formatter.format(DateTime.parse(json["postCreatedAt"])),
        postId: json["postId"]);
  }

  factory PostSpecificData.fromPostDetailData(PostDetailData postDetailData){
    final DateFormat formatter = DateFormat('MM/dd HH:mm');
    return PostSpecificData(
        postDesc: postDetailData.postDesc,
        postImageCnt: postDetailData.postImages!.length,
        postLikeCnt: postDetailData.postLikeCnt,
        postCommentCnt: postDetailData.postCommentCnt,
        isLikedByMe: postDetailData.isLikedByMe,
        isBlind: postDetailData.isBlind,
        isAnonymous: postDetailData.isAnonymous,
        authorMajor: postDetailData.authorMajor,
        postTitle: postDetailData.postTitle,
        postCreatedAt: postDetailData.postCreatedAt!,
        postId: postDetailData.postId);
  }
}

class PostCollegeDto {
  String? college;
  int? page;
  int? size;
  PostCollegeDto({this.college, this.page, this.size});
  factory PostCollegeDto.fromJson(Map<String, dynamic> json) => PostCollegeDto(
        college: json["college"],
        page: json["page"],
        size: json["size"],
      );
  Map<String, dynamic> toJson() => {
        "college": college,
        "page": page,
        "size": size,
      };
}
