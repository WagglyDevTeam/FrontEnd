import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/post/post_provider.dart';

import 'dtos/waggly_response_dto.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<WagglyResponseDto> getBoard() async {
    Response response = await _postProvider.getBoard();
    dynamic body = response.body;

    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }

  Future<void> writeBoard(FormData data) async {
    Response response = await _postProvider.writeBoard(data);
    dynamic body = response.body;
  }

  Future<WagglyResponseDto> getHome() async {
    Response response = await _postProvider.getHome();
    dynamic body = response.body;

    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }
}
