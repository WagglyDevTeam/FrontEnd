class Post {
  final int? postId;
  final String? postTitle;
  final String? postDesc;
  final DateTime? postCreatedAt;
  final String? authorMajor;
  final int? postImageCnt;
  final int? postLikeCnt;
  final int? postCommentCnt;
  final bool? isLikedByMe;
  final bool? isBlind;

  Post({
    this.postId,
    this.postTitle,
    this.postDesc,
    this.postCreatedAt,
    this.authorMajor,
    this.postImageCnt,
    this.postLikeCnt,
    this.postCommentCnt,
    this.isLikedByMe,
    this.isBlind,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      postTitle: json['postTitle'],
      postDesc: json['postDesc'],
      postCreatedAt: DateTime.parse(json['postCreatedAt']),
      authorMajor: json['authorMajor'],
      postImageCnt: json['postImageCnt'],
      postLikeCnt: json['postLikeCnt'],
      postCommentCnt: json['postCommentCnt'],
      isLikedByMe: json['isLikedByMe'],
      isBlind: json['isBlind'],
    );
  }
}
