import 'package:flutter/material.dart';

import 'waggly_response_dto.dart';

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
  String? postDesc;
  int? postImageCnt;
  int? postLikeCnt;
  int? postCommentCnt;
  bool? isLikedByMe;
  bool? isBlind;
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;

  PostSpecificData(
      {this.postDesc,
      this.postImageCnt,
      this.postLikeCnt,
      this.postCommentCnt,
      this.isLikedByMe,
      this.isBlind,
      this.authorMajor,
      this.postTitle,
      this.postCreatedAt,
      this.postId});

  factory PostSpecificData.fromJson(Map<String, dynamic> json) =>
      PostSpecificData(
          postDesc: json["postDesc"],
          postImageCnt: json["postImageCnt"],
          postLikeCnt: json["postLikeCnt"],
          postCommentCnt: json["postCommentCnt"],
          isLikedByMe: json["isLikedByMe"],
          isBlind: json["isBlind"],
          authorMajor: json["authorMajor"],
          postTitle: json["postTitle"],
          postCreatedAt: json["postCreatedAt"],
          postId: json["postId"]);
}

class PostCollegeDto {
  String? college;
  int? page;
  int? size;
  PostCollegeDto({this.college, this.page, this.size});
  factory PostCollegeDto.fromJson(Map<String, dynamic> json) => PostCollegeDto(
      college: json["college"], page: json["page"], size: json["size"]);
  Map<String, dynamic> toJson() =>
      {"college": college, "page": page, "size": size};
}
