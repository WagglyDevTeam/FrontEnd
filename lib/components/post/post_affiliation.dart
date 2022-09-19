import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_common.dart';
import '../../controller/post/post_home.dart';
import '../../model/postCollege/dtos/post_college_dto.dart';
import '../../utils/colors.dart';
import '../../utils/text_frame.dart';
import './post_app_bar.dart';

class PostAffiliation extends StatefulWidget {
  const PostAffiliation({Key? key}) : super(key: key);

  @override
  _PostAffiliation createState() => _PostAffiliation();
}

class _PostAffiliation extends State<PostAffiliation> {
  _PostAffiliation({Key? key});
  final String postName = Get.parameters['collegeName'] ?? "";
  final PostHomeController _postDetailX = Get.put(PostHomeController());
  final dto =
      PostCollegeDto(college: Get.parameters['collegeId'], page: 0, size: 0);
  @override
  initState() {
    _postDetailX.getBoardCollege(dto);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var page = Status.home;
    return Scaffold(
      appBar: PostAppbar(postName: postName, page: page),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _postDetailX.postCollegeData.value.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              /**인기 글*/
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '인기글',
                          style: CommonText.BodyL,
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.auto_awesome,
                          color: Palette.main,
                          size: 17,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 14, bottom: 14, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: Palette.light,
                              style: BorderStyle.solid,
                              width: 1)),
                      child: PostContext(
                        postId: _postDetailX.bestPostCollegeData.value.postId,
                        postTitle:
                            _postDetailX.bestPostCollegeData.value.postTitle,
                        postDesc:
                            _postDetailX.bestPostCollegeData.value.postDesc,
                        postCreatedAt: _postDetailX
                            .bestPostCollegeData.value.postCreatedAt,
                        authorMajor:
                            _postDetailX.bestPostCollegeData.value.authorMajor,
                        postImageCnt:
                            _postDetailX.bestPostCollegeData.value.postImageCnt,
                        postLikeCnt:
                            _postDetailX.bestPostCollegeData.value.postLikeCnt,
                        postCommentCnt: _postDetailX
                            .bestPostCollegeData.value.postCommentCnt,
                        isLikedByMe:
                            _postDetailX.bestPostCollegeData.value.isLikedByMe,
                        isBlind: _postDetailX.bestPostCollegeData.value.isBlind,
                        postName: postName,
                      ),
                    )
                  ],
                ),
              );
            } else {
              /**일반 글*/
              return Container(
                padding:
                    EdgeInsets.only(top: 16, bottom: 16, left: 26, right: 26),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                          color: Palette.paper,
                          style: BorderStyle.solid,
                          width: 1),
                    )),
                child: PostContext(
                  postId: _postDetailX.postCollegeData.value[index].postId,
                  postTitle:
                      _postDetailX.postCollegeData.value[index].postTitle,
                  postDesc: _postDetailX.postCollegeData.value[index].postDesc,
                  postCreatedAt:
                      _postDetailX.postCollegeData.value[index].postCreatedAt,
                  authorMajor:
                      _postDetailX.postCollegeData.value[index].authorMajor,
                  postImageCnt:
                      _postDetailX.postCollegeData.value[index].postImageCnt,
                  postLikeCnt:
                      _postDetailX.postCollegeData.value[index].postLikeCnt,
                  postCommentCnt:
                      _postDetailX.postCollegeData.value[index].postCommentCnt,
                  isLikedByMe:
                      _postDetailX.postCollegeData.value[index].isLikedByMe,
                  isBlind: _postDetailX.postCollegeData.value[index].isBlind,
                  postName: postName,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class PostContext extends StatelessWidget {
  final postId;
  final postTitle;
  final postDesc;
  final postCreatedAt;
  final authorMajor;
  final postImageCnt;
  final postLikeCnt;
  final postCommentCnt;
  final isLikedByMe;
  final isBlind;
  final postName;

  const PostContext({
    Key? key,
    @required this.postId,
    @required this.postTitle,
    @required this.postDesc,
    @required this.postCreatedAt,
    @required this.authorMajor,
    @required this.postImageCnt,
    @required this.postLikeCnt,
    @required this.postCommentCnt,
    @required this.isLikedByMe,
    @required this.isBlind,
    @required this.postName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/postDetail/$postId"),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(postTitle, style: CommonText.BodyL),
              Text(postCreatedAt, style: CommonText.BodyEngGray),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            child: Text(postDesc, style: CommonText.BodyS),
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(authorMajor, style: CommonText.BodyEngGray),
              CommentSide(
                commentCnt: postCommentCnt,
                likeCnt: postLikeCnt,
                imgCnt: postImageCnt,
              )
            ],
          )
        ],
      ),
    );
  }
}
