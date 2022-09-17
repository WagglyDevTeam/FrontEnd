import 'dart:convert';

import 'package:get/get.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../model/post/post_repository.dart';
import '../../model/postCollege/dtos/post_college_dto.dart';

class PostHomeController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final userCollegeData =
      PostCollegeData(collegeTypeName: '', collegeType: '', posts: []).obs;
  final otherCollegeData =
      [PostCollegeData(collegeTypeName: '', collegeType: '', posts: [])].obs;

  @override
  void onInit() async {
    super.onInit();
    await getHomeBoard();
  }

  /// 게시판 홈 post data get
  Future<void> getHomeBoard() async {
    WagglyResponseDto result = await _postRepository.getBoardHome();
    dynamic userCollegeJson = result.datas["userCollegePosts"];
    PostCollegeData userCollegeMap = PostCollegeData.fromJson(userCollegeJson);
    dynamic otherCollegeJson = result.datas["otherCollegePosts"];
    List<PostCollegeData> otherCollegeMap = List<PostCollegeData>.from(
        otherCollegeJson.map((x) => PostCollegeData.fromJson(x)).toList());
    otherCollegeData.value = otherCollegeMap;
    userCollegeData.value = userCollegeMap;
  }
}
