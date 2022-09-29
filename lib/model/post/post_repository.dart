import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/post/dtos/post_detail_dto.dart';
import 'package:waggly/model/post/post_provider.dart';

import 'dtos/post_college_dto.dart';
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

  /// 메인 홈 Response
  Future<void> writeBoard(FormData data) async {
    Response response = await _postProvider.writeBoard(data);
    dynamic body = response.body;
    print(body);
  }

  /// 메인 홈 Response
  Future<WagglyResponseDto> getHome() async {
    Response response = await _postProvider.getHome();
    dynamic body = response.body;

    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }

  /// 게시판 홈 Response
  Future<WagglyResponseDto> getBoardHome() async {
    Response response = await _postProvider.getBoardHome();
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }

  /// 특정학부 Response
  Future<WagglyResponseDto> getBoardCollege(PostCollegeDto props) async {
    Response response = await _postProvider.getBoardCollege(
        props.college!, props.page!, props.size!);
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

    return wagglyResponseDto;
  }

  /// 게시판 상세페이지 Response
  Future<WagglyResponseDto> getDetailBoard(String boardId) async {
    Response response = await _postProvider.getDetailBoard(boardId);
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

    return wagglyResponseDto;
  }

  Future<WagglyResponseDto> postComment(
      String? postId, CommentRequestDto data) async {
    Response response = await _postProvider.postComment(postId, data);
    dynamic body = response.body;
    print(body);
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

    return wagglyResponseDto;
  }

  Future<WagglyResponseDto> postReComment(
      int commentId, ReCommentRequestDto data) async {
    Response response = await _postProvider.postReComment(commentId, data);
    dynamic body = response.body;
    print(body);
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

    return wagglyResponseDto;
  }

  Future<WagglyResponseDto> likeDetailPost(
      int postId, likeDetailRequestDto data) async {
    Response response = await _postProvider.likeDetailPost(postId, data);
    dynamic body = response.body;
    print(body);
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

    return wagglyResponseDto;
  }

  Future<WagglyResponseDto> PostDelete(int postId) async {
    Response response = await _postProvider.PostDelete(postId);
    dynamic body = response.body;
    print(body);
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
