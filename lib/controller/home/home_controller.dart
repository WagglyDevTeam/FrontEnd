import 'package:get/get.dart';
import 'package:waggly/model/home/home_repository.dart';
import 'package:waggly/model/post/dtos/post_response_dto.dart';

import '../../model/post/dtos/post_request_dto.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../model/post/post.dart';
import '../../model/post/post_repository.dart';

enum CollegeType {
  artsports("ARTSPORTS", "예술체육계열"),
  nature("NATURE", "자연계열"),
  undefined("undefined", "");

  const CollegeType(this.key, this.displayName);
  final String key;
  final String displayName;

  factory CollegeType.getByKey(String key) {
    return CollegeType.values.firstWhere((value) => value.key == key,
    orElse: () => CollegeType.undefined);
  }
}

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final college = "".obs;
  final othersBestPost = PostResponseDto().obs;
  final collegeBestPost = PostResponseDto().obs;

  @override
  void onInit() async {
    super.onInit();
    await getHome();
  }

  Future<void> getHome() async {
    WagglyResponseDto result = await _homeRepository.getHome();
    final collegeBestData = result.datas["bestPostWithCollegeType"];
    final othersBestData = result.datas["randomBestPostSummary"];

    final collegeName = CollegeType.getByKey(collegeBestData['first']);
    print(collegeName.displayName);

    collegeBestPost.value = PostResponseDto.fromJson(collegeBestData["second"]);
    othersBestPost.value = PostResponseDto.fromJson(othersBestData);

    print(collegeBestPost.value.postTitle);
    print(othersBestPost.value.postTitle);
  }
}
