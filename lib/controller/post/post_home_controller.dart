import 'package:get/get.dart';
import 'package:waggly/model/post/dtos/waggly_response_pagination_dto.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../repository/post_repository.dart';
import '../../model/post/dtos/post_college_dto.dart';

class PostHomeController extends GetxController {
  final PostRepository _postRepository = PostRepository();

  /// 메인 홈 내 계열 상태데이터
  final userCollegeData = PostCollegeData(collegeTypeName: '', collegeType: '', posts: []).obs;

  /// 메인 홈 다른 계열 인기글 상태데이터
  final otherCollegeData = [PostCollegeData(collegeTypeName: '', collegeType: '', posts: [])].obs;

  ///  특정학부 페이지 인기글 상테데이터
  final bestPostCollegeData = PostSpecificData().obs;

  /// 특정학부 페이지 인기글 로드 상태데이터
  final bestPostOn = false.obs;

  /// 특정 학부 페이징
  final postPage = 0.obs;

  /// 토탈페이지
  final totalPage = 0.obs;

  /// 특정학부 페이지 게시물 상태데이터
  final postCollegeData = [PostSpecificData()].obs;

  /// 특정학부 페이지 인기글 로드 상태데이터
  final normalPostOn = false.obs;

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
    List<PostCollegeData> otherCollegeMap = List<PostCollegeData>.from(otherCollegeJson.map((x) => PostCollegeData.fromJson(x)).toList());
    otherCollegeData.value = otherCollegeMap;
    userCollegeData.value = userCollegeMap;
  }

  /// 게시판 특정학과 페이지 post data get
  Future<void> getBoardCollege(String? collegeId) async {
    PostCollegeDto college = PostCollegeDto(college: collegeId, page: postPage.value, size: 10);
    WagglyResponsePaginationDto result = await _postRepository.getBoardCollege(college);
    dynamic bestJson = result.datas["bestPost"];
    dynamic postJson = result.datas["posts"];
    if (result.status == '200') {
      totalPage.value = result.totalPage ?? 0;
      if (result.totalPage != postPage.value) {
        PostSpecificData bestPostData = PostSpecificData.fromJson(bestJson);
        List<PostSpecificData> postData = List<PostSpecificData>.from(postJson.map((x) => PostSpecificData.fromJson(x)).toList());
        bestPostCollegeData.value = bestPostData;
        postCollegeData.value = postData;
        postPage.value++;
        bestPostOn.value = true;
      }
    } else {
      bestPostOn.value = false;
    }
    // if (postJson != []) {
    //   List<PostSpecificData> postData = List<PostSpecificData>.from(postJson.map((x) => PostSpecificData.fromJson(x)).toList());
    //   postCollegeData.value = postData;
    //   postCollegeData.refresh();
    //   normalPostOn.value = true;
    // } else {
    //   normalPostOn.value = false;
    // }
  }

  /// 게시판 페이징 get
  Future<void> getBoardPaging(String? collegeId) async {
    //total page 어케알지?
    if (totalPage.value >= postPage.value) {
      PostCollegeDto college = PostCollegeDto(college: collegeId, page: postPage.value, size: 10);
      WagglyResponsePaginationDto result = await _postRepository.getBoardCollege(college);
      dynamic postJson = result.datas["posts"];
      print('postLength = ${postJson.length}');
      if (postJson != []) {
        List<PostSpecificData> postData = List<PostSpecificData>.from(postJson.map((x) => PostSpecificData.fromJson(x)).toList());
        postCollegeData.addAll(postData);
        postCollegeData.refresh();
        normalPostOn.value = true;
      } else {
        normalPostOn.value = false;
      }
      postPage.value++;
    }
  }

  /// 게시물 삭제
  Future<void> deleteBoard(int postId) async {
    WagglyResponseDto result = await _postRepository.PostDelete(postId);
    for (var i = 0; i < postCollegeData.length; i++) {
      if (postCollegeData[i].postId == postId) {
        postCollegeData.remove(postCollegeData[i]);
        update();
        postCollegeData.refresh();
        return;
      }
    }
  }

  /// 게시물 리스트 상태값 초기화
  Future<void> postListReset() async {
    postPage.value = 0;
    bestPostCollegeData.value = PostSpecificData();
    bestPostOn.value = false;
    postCollegeData.value = [PostSpecificData()];
    normalPostOn.value = false;
  }

  /// 게시물 홈 상태값 초기화
  Future<void> postHomeReset() async {
    userCollegeData.value = PostCollegeData(collegeTypeName: '', collegeType: '', posts: []);
    otherCollegeData.value = [PostCollegeData(collegeTypeName: '', collegeType: '', posts: [])];
  }
}
