

import 'package:intl/intl.dart';
import 'package:waggly/model/post/dtos/post_detail_dto.dart';

class PostSearchRequestDto{
  String? keyword;
  int? page;
  int? size;

  PostSearchRequestDto({this.keyword, this.page, this.size});
  factory PostSearchRequestDto.fromJson(Map<String, dynamic> json) => PostSearchRequestDto(
    keyword: json["keyword"],
    page: json["page"],
    size: json["size"],
  );
  Map<String, dynamic> toJson() => {
    "keyword": keyword,
    "page" : page,
    "size" : size,
  };
}

class PostSearchData {
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

  PostSearchData({
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

  factory PostSearchData.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('MM/dd HH:mm');

    return PostSearchData(
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

  factory PostSearchData.fromPostDetailData(PostDetailData postDetailData){
    final DateFormat formatter = DateFormat('MM/dd HH:mm');
    return PostSearchData(
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