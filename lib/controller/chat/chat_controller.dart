import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waggly/model/chat/chat.dart';
import 'package:waggly/model/chat/chat_image_dto.dart';
import 'package:waggly/model/chat/chat_message_dto.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/repository/chat_repository.dart';

class ChatController extends GetxController{
  final ChatRepository _chatRepository = ChatRepository();
  var scrollController = ScrollController().obs;
  var hasMore = false.obs;
  final myChat = [].obs;
  final picker = ImagePicker();
  final uploadImg = "".obs;
  final roomId = 1;
  //File? pickedImage;

  @override
  void onInit() async{
    print('chat controller start');
    await getChat(1);


    //나중에 데이터 사이즈 컨트롤할거 미리 적어본것
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        getChat(1);
      }

    //   final direction = scrollController.value.position.userScrollDirection;
    //   if (direction == ScrollDirection.forward) {
    //     isShow.value = true;
    //   } else {
    //     isShow.value = false;
    //   }
     });

    super.onInit();

  }

  //일단 스크롤 제일 마지막으로 위치 보내기
  // void moveToScroll(){
  //   scrollController.value.animateTo(scrollController.value.position.maxScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.ease);
  // }

Future<void> getChat(int roomId) async{
  WagglyResponseDto result = await _chatRepository.getChatMessage(roomId);
  List<dynamic> chatImageJson = result.datas['imageList'];
  List<dynamic> chatMessageJson = result.datas['messageList'];
  List<ChatMessageDto> convertMessageDtos = chatMessageJson.map((e) => ChatMessageDto.fromJson(e)).toList();
  List<ChatImageDto> convertImageMessageDtos = chatImageJson.map((e) => ChatImageDto.fromJson(e)).toList();
  print('getChat $chatMessageJson');
  myChat.value =  convertMessageDtos;
}


 void getRealTimeChat(int roomId, int senderId, String body, DateTime createAt, String type){
  myChat.add(ChatMessageDto(roomId: roomId, senderId: senderId, body: body, createAt: createAt, type: type));
}


Future pickedImage(int roomId, int senderId, DateTime createAt, String type) async{
    try{

      final pickedImg = await picker.pickImage(source: ImageSource.gallery,  imageQuality: 50,maxHeight: 150);
      if(pickedImg == null) return;

      uploadImg.value = pickedImg.path;
      myChat.add(ChatMessageDto(roomId: roomId, senderId: senderId, body: uploadImg.value, createAt: createAt, type: type));

      print(pickedImg);
      print(pickedImg.path);
      // final FormData formData = FormData({'image': MultipartFile(File(uploadImg.value), filename: pickedImg.name)});
      // print('formData $formData');

     Response response = await _chatRepository.postChatImage(roomId, uploadImg.value);
     print(response);

    } on PlatformException catch(e) {
      print('failed to Pick image: $e');
    }
}

}
