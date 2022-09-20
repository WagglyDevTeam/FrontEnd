import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/post/post_provider.dart';

import '../postCollege/dtos/post_college_dto.dart';
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

  Future<WagglyResponseDto> getBoardCollege(PostCollegeDto props) async {
    Response response = await _postProvider.getBoardCollege(
        props.college!, props.page!, props.size!);
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

    return wagglyResponseDto;
  }

  Future<WagglyResponseDto> getDetailBoard(String boardId) async {
    Response response = await _postProvider.getDetailBoard(boardId);
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

    return wagglyResponseDto;
  }
}
