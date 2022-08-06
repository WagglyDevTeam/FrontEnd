import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
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
}
