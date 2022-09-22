import 'dart:convert';

import 'package:get/get.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../model/post/post_repository.dart';
import '../../model/post/dtos/post_college_dto.dart';

class PostHomeController extends GetxController {
  final PostRepository _postRepository = PostRepository();

  /// 메인 홈 내 계열 상태데이터
  final userCollegeData =
      PostCollegeData(collegeTypeName: '', collegeType: '', posts: []).obs;

  /// 메인 홈 다른 계열 인기글 상태데이터
  final otherCollegeData =
      [PostCollegeData(collegeTypeName: '', collegeType: '', posts: [])].obs;

  ///  특정학부 페이지 인기글 상테데이터
  final bestPostCollegeData = PostSpecificData().obs;

  /// 특정학부 페이지 인기글 로드 상태데이터
  final bestPostOn = false.obs;

  /// 특정학부 페이지 게시물 상태데이터
  final postCollegeData = [PostSpecificData()].obs;

  /// 특정학부 페이지 인기글 로드 상태데이터
  final normalPostOn = false.obs;

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
    WagglyResponseDto result = await _postRepository.getBoardCollege(college);
    dynamic bestJson = result.datas["bestPost"];
    dynamic postJson = result.datas["posts"];
    if (bestJson != null) {
      PostSpecificData bestPostData = PostSpecificData.fromJson(bestJson);
      bestPostCollegeData.value = bestPostData;
      bestPostOn.value = true;
      print('best OK');
    } else {
      bestPostOn.value = false;
      print('best no');
    }
    if (postJson != []) {
      List<PostSpecificData> postData = List<PostSpecificData>.from(
          postJson.map((x) => PostSpecificData.fromJson(x)).toList());
      postCollegeData.value = postData;
      normalPostOn.value = true;
      print("post OK");
    } else {
      normalPostOn.value = false;
      print('post No');
    }
  }
}
