import 'dart:ffi';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/hive/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/http/src/response/response.dart';

final token = Hive.box<User>('user').get('user')?.jwtToken;


class ChatProvider extends GetConnect{
  final Map<String, dynamic> headers = token != null ? {"Authorization": token!} : {};

  Future<Response> getChatMessage(int roomId) => get(
    "${dotenv.get('BASE_URL')}/chat/room/$roomId",
    headers: {"Authorization": token!},
  );

  Future<Response> getMyChatList() => get(
    "${dotenv.get('BASE_URL')}/chat/myList",
    headers: {"Authorization": token!},
  );

  Future<Response> getChat(int roomId, int page) => get(
    "${dotenv.get('BASE_URL')}/chat/room?roomId=$roomId?pageCount=$page",
    headers: {"Authorization": token!},
  );

  Future<Response> postImageChat(int roomId, String image) => post(
    "${dotenv.get('BASE_URL')}/chat/image",
    {'roomId': roomId, 'image': image},
    headers: {"Authorization": token!},
  );
}