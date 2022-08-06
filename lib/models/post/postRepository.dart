import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:wagly/models/post/postProvider.dart';

import '../dtos/wagglyResponseDto.dart';

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
    print(body);

    // WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    // print(wagglyResponseDto);

    // return wagglyResponseDto;
  }
}
