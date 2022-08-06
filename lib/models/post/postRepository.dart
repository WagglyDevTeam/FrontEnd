import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:waggly/models/post/postProvider.dart';

import '../dtos/wagglyResponseDto.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<WagglyResponseDto> getBoard() async {
    Response response = await _postProvider.getBoard();
    dynamic body = response.body;
    // Map<String, dynamic> map = json.decode(response.body)["datas"];

    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    // wagglyResponseDto.datas["posts"] = map["posts"];
    // wagglyResponseDto.datas["bestPost"] = map["bestPost"];
    return wagglyResponseDto;
  }
}
