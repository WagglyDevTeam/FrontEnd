import 'package:get/get.dart';
import 'package:waggly/model/major/major.dart';
import 'package:waggly/model/major/major_repository.dart';
import '../../model/post/dtos/waggly_response_dto.dart';

class MajorController extends GetxController {
  final _majorRepository = MajorRepository();
  final majorList = <Major>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<List<Major>> getMajorListByUniversityName(String universityName) async {
    WagglyResponseDto result = await _majorRepository.getMajorListByUniversityName(universityName);
    List<dynamic> majorListJson = result.datas;
    List<Major> convertedMajorList = majorListJson.map((e) => Major.fromJson(e)).toList();
    majorList.value = convertedMajorList;

    return majorList;
  }

  Future<List<Major>> getMajorSearchResultList(String universityName, String keyword) async {
    WagglyResponseDto result = await _majorRepository.getMajorListByUniversityName(universityName);
    List<dynamic> majorListJson = result.datas;
    List<Major> convertedMajorList = majorListJson
        .map((e) => Major.fromJson(e))
        .toList()
        .where((element) => element.majorName!.contains(keyword))
        .toList();
    majorList.value = convertedMajorList;

    return majorList;
  }

  bool checkMajorExist(String majorName) {
    bool isExist = false;
    if (majorList.isNotEmpty == true) {
      for (final major in majorList) {
        if (major.majorName == majorName) {
          isExist = true;
        }
      }
    }
    return isExist;
  }
}
