import 'package:waggly/model/chat/chat_image_dto.dart';
import 'package:waggly/model/chat/chat_message_dto.dart';

class ChatDto{
  final List<ChatMessageDto> chatMessageDto;
  final List<ChatImageDto> chatImageDto;

  ChatDto({
    required this.chatImageDto,
    required this.chatMessageDto,
});

}