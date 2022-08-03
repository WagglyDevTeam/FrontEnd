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

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'],
      postTitle: map['postTitle'],
      postDesc: map['postDesc'],
      postCreatedAt: DateTime.parse(map['postCreatedAt']),
      authorMajor: map['authorMajor'],
      postImageCnt: map['postImageCnt'],
      postLikeCnt: map['postLikeCnt'],
      postCommentCnt: map['postCommentCnt'],
      isLikedByMe: map['isLikedByMe'],
      isBlind: map['isBlind'],
    );
  }
}
