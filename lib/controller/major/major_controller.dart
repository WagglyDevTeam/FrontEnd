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

  Future<void> getMajorListByUniversityName(String universityName) async {
    WagglyResponseDto result = await _majorRepository.getMajorListByUniversityName(universityName);
    List<dynamic> majorListJson = result.datas;
    List<Major> convertedMajorList = majorListJson.map((e) => Major.fromJson(e)).toList();
    majorList.value = convertedMajorList;
  }
}
