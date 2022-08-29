import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/myPage/my_post_provider.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';

class MyPostsListRepository {
  final MyPostsListProvider _myPostsListProvider = MyPostsListProvider();

  Future<WagglyResponseDto> getMyPosts() async {
    print('2');
    Response response = await _myPostsListProvider.getMyPosts();
    print(response);
    dynamic body = response.body;
    print(response);
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }
}
