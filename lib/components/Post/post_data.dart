class PostListData {
  String? authorMajor;
  String? postTitle;
  String? postCreatedAt;
  int? postId;

  PostListData(
      {required this.authorMajor,
      required this.postTitle,
      required this.postCreatedAt,
      required this.postId});

  PostListData.fromMap(Map<String, dynamic> map)
      : authorMajor = map['authorMajor'],
        postTitle = map['postTitle'],
        postCreatedAt = map['postCreatedAt'],
        postId = map['postId'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorMajor'] = authorMajor;
    data['postTitle'] = postTitle;
    data['postCreatedAt'] = postCreatedAt;
    data['postId'] = postId;
    return data;
  }
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
      required String? authorMajor,
      required String? postTitle,
      required String? postCreatedAt,
      required int? postId})
      : super(
            authorMajor: authorMajor,
            postTitle: postTitle,
            postCreatedAt: postCreatedAt,
            postId: postId);
}

class PostDetailData extends PostListData {
  String postDesc;
  List<String> postImages;
  int postLikeCnt;
  int postCommentCnt;
  bool isLikedByMe;
  bool isBlind;
  int authorId;
  String authorNickname;
  String authorProfileImg;
  PostDetailData({
    required this.postImages,
    required this.postDesc,
    required this.postLikeCnt,
    required this.postCommentCnt,
    required this.isLikedByMe,
    required this.isBlind,
    required this.authorNickname,
    required this.authorId,
    required this.authorProfileImg,
    required String? authorMajor,
    required String? postTitle,
    required String? postCreatedAt,
    required int postId,
  }) : super(
          authorMajor: authorMajor,
          postTitle: postTitle,
          postCreatedAt: postCreatedAt,
          postId: postId,
        );
}

// ignore: empty_constructor_bodies
class AuthorData {
  final int authorId;
  final String authorMajor;
  final String authorNickname;
  final String authorProfileImg;
  final bool isBlind;

  AuthorData({
    required this.authorId,
    required this.authorMajor,
    required this.authorNickname,
    required this.authorProfileImg,
    required this.isBlind,
  });

  AuthorData.fromMap(Map<String, dynamic> map)
      : authorId = map['authorId'],
        authorMajor = map['authorMajor'],
        authorNickname = map['authorNickname'],
        authorProfileImg = map['authorProfileImg'],
        isBlind = map['isBlind'];
}

class ReCommentData extends AuthorData {
  final int replyId;
  final String replyCreatedAt;
  final int replyLikeCnt;
  final String replyDesc;
  final bool isLikedByMe;

  ReCommentData({
    required this.replyId,
    required this.replyCreatedAt,
    required this.replyLikeCnt,
    required this.replyDesc,
    required this.isLikedByMe,
    required int authorId,
    required String authorMajor,
    required String authorNickname,
    required String authorProfileImg,
    required bool isBlind,
  }) : super(
          authorId: authorId,
          authorMajor: authorMajor,
          authorNickname: authorNickname,
          authorProfileImg: authorProfileImg,
          isBlind: isBlind,
        );
}

class CommentData extends AuthorData {
  final int commentId;
  final String commentCreatedAt;
  final int commentLikeCnt;
  final String commentDesc;
  final bool isLikedByMe;
  final List<ReCommentData> replies;

  CommentData({
    required this.commentId,
    required this.commentCreatedAt,
    required this.commentLikeCnt,
    required this.commentDesc,
    required this.isLikedByMe,
    required this.replies,
    required int authorId,
    required String authorMajor,
    required String authorNickname,
    required String authorProfileImg,
    required bool isBlind,
  }) : super(
          authorId: authorId,
          authorMajor: authorMajor,
          authorNickname: authorNickname,
          authorProfileImg: authorProfileImg,
          isBlind: isBlind,
        );
}
