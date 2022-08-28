import 'package:get/get.dart';

class PostResponseDto {
  final int? postId;
  final String? postTitle;
  final String? postDesc;
  final String? postCreatedAt;
  final int? postImageCnt;
  final int? postLikeCnt;
  final bool? isLikedByMe;
  final bool? isBlind;
  final bool? isAnonymous;

  PostResponseDto({this.postId, this.postTitle, this.postDesc, this.postCreatedAt, this.postImageCnt, this.postLikeCnt, this.isLikedByMe, this.isBlind,
      this.isAnonymous});

  factory PostResponseDto.fromJson(Map<String, dynamic> json) {
    return PostResponseDto(
      postId: json["postId"],
      postTitle: json["postTitle"],
      postDesc: json["postDesc"],
      postCreatedAt: json["postCreatedAt"],
      postImageCnt: json["postImageCnt"],
      postLikeCnt: json["postLikeCnt"],
      isLikedByMe: json["isLikedByMe"],
      isBlind: json["isBlind"],
      isAnonymous: json["isAnonymous"],
    );
  }
}
