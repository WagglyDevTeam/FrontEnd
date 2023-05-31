import 'dart:ffi';

import 'package:get/get.dart';
import 'package:waggly/model/chat/chat_image_dto.dart';
import 'package:waggly/model/chat/chat_message_dto.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/repository/chat_repository.dart';

class ChatController extends GetxController{
  final ChatRepository _chatRepository = ChatRepository();



Future<void> getChat(int roomId) async{
  WagglyResponseDto result = await _chatRepository.getChatMessage(roomId);
  List<dynamic> chatImageJson = result.datas['imageList'];
  List<dynamic> chatMessageJson = result.datas['messageList'];
  List<ChatMessageDto> convertMessageDtos = chatMessageJson.map((e) => ChatMessageDto.fromJson(e)).toList();
  List<ChatImageDto> convertImageMessageDtos = chatImageJson.map((e) => ChatImageDto.fromJson(e)).toList();
  print(result.status);
}


}
