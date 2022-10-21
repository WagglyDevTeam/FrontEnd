import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/provider/home_provider.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';

class HomeRepository {
  final HomeProvider _homeProvider = HomeProvider();

  Future<WagglyResponseDto> getHome() async {
    Response response = await _homeProvider.getHome();
    dynamic body = response.body;

    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }
}
