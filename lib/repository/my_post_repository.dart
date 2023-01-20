import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/provider/my_post_provider.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';

class MyPostsListRepository {
  final MyPostsListProvider _myPostsListProvider = MyPostsListProvider();

  Future<WagglyResponseDto> getMyPosts(props) async {
    Response response = await _myPostsListProvider.getMyPosts(props.page!, props.size!);
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }
}
