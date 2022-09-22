import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/post/post_provider.dart';

import 'dtos/waggly_response_dto.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<dynamic> getBoard() async {
    Response response = await _postProvider.getBoard();
    if (response.bodyString == null) {
      return null;
    }

    dynamic body = response.body;

    if (body.runtimeType == Map<String, dynamic>) {
      WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
      return wagglyResponseDto;
    } else {
      return body;
    }
  }

  Future<void> writeBoard(FormData data) async {
    Response response = await _postProvider.writeBoard(data);
    dynamic body = response.body;
    print(body);
  }

  Future<WagglyResponseDto> getHome() async {
    Response response = await _postProvider.getHome();
    dynamic body = response.body;

    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }

  Future<WagglyResponseDto> getBoardHome() async {
    Response response = await _postProvider.getBoardHome();
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }

  Future<void> editBoard(FormData data) async {
    Response response = await _postProvider.editBoard(data);
    dynamic body = response.body;
    print(body);
    // WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    // print(jsonEncode(wagglyResponseDto));
    // return wagglyResponseDto;
  }
}
