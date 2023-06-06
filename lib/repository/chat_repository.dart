
import 'dart:ffi';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/provider/chat_provider.dart';

class ChatRepository{
  final ChatProvider _chatProvider = ChatProvider();

  Future<WagglyResponseDto> getChatMessage(int roomId) async{
    Response response = await _chatProvider.getChatMessage(roomId);
    dynamic body = response.body;
    print('body___$body');

    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }

}