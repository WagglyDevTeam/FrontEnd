import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/major/major_provider.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';

class MajorRepository {
  final MajorProvider _majorProvider = MajorProvider();

  Future<dynamic> getMajorListByUniversityName(String universityName) async {
    Response response = await _majorProvider.getMajorListByUniversityName(universityName);
    if (response.bodyString == null) {
      return null;
    }

    dynamic body = response.body;
    print(body);
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
    }
  }


