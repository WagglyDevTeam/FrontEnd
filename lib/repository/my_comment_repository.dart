import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/provider/my_comment_provider.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';

class MyCommentsListRepository {
  final MyCommentsListProvider _myCommentsListProvider = MyCommentsListProvider();

  Future<WagglyResponseDto> getMyComments(props) async {
    Response response = await _myCommentsListProvider.getMyComments(props.page!, props.size!);
    dynamic body = response.body;
    print(body);
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }
}
