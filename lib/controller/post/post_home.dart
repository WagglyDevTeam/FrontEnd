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
  final bestPostCollegeData = PostSpecificData().obs;
  final postCollegeData = [PostSpecificData()].obs;
  final dto =
      PostCollegeDto(college: Get.parameters['collegeId'], page: 0, size: 0);
  @override
  void onInit() async {
    super.onInit();
    await getHomeBoard();
  }

  /// 게시판 홈 post data get d
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

  /// 게시판 특정학과 페이지 post data get
  Future<void> getBoardCollege(PostCollegeDto college) async {
    String result = await _postRepository.getBoardCollege(college);
    // print(result);
    // dynamic bestJson = result.datas["bestPost"];
    // dynamic postJson = result.datas["posts"];
    //
    // PostSpecificData bestPostData = PostSpecificData.fromJson(bestJson);
    // List<PostSpecificData> postData = List<PostSpecificData>.from(
    //     postJson.map((x) => PostSpecificData.fromJson(x)).toList());
    // bestPostCollegeData.value = bestPostData;
    // postCollegeData.value = postData;
  }
}
