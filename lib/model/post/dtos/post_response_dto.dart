import 'package:intl/intl.dart';

class PostResponseDto {
  final int? postId;
  final String? postTitle;
  final String? postDesc;
  final String? postCreatedAt;
  final String? authorMajor;
  final int? postImageCnt;
  final int? postLikeCnt;
  final int? postCommentCnt;
  final bool? isLikedByMe;
  final bool? isBlind;
  final bool? isAnonymous;

  PostResponseDto(
      {this.postId,
      this.postTitle,
      this.postDesc,
      this.postCreatedAt,
      this.authorMajor,
      this.postImageCnt,
      this.postLikeCnt,
      this.postCommentCnt,
      this.isLikedByMe,
      this.isBlind,
      this.isAnonymous});

  factory PostResponseDto.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('MM/dd HH:mm');

    return PostResponseDto(
      postId: json["postId"],
      postTitle: json["postTitle"],
      postDesc: json["postDesc"],
      postCreatedAt: formatter.format(DateTime.parse(json['postCreatedAt'])),
      authorMajor: json["authorMajor"],
      postImageCnt: json["postImageCnt"],
      postLikeCnt: json["postLikeCnt"],
      postCommentCnt: json["postCommentCnt"],
      isLikedByMe: json["isLikedByMe"],
      isBlind: json["isBlind"],
      isAnonymous: json["isAnonymous"],
    );
  }
}
