import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/hive/user.dart';

class MyProfileProvider extends GetConnect {
  final token = Hive.box<User>('user').get('user')?.jwtToken;

  Future<Response> modifyNickname(FormData data) => put(
        "${dotenv.get('BASE_URL')}/user/profile/nickname",
        data,
        headers: {"Authorization": token!},
      );

  Future<Response> uploadProfileImg(FormData data) => put(
        "${dotenv.get('BASE_URL')}/user/profile/img",
        data,
        headers: {"Authorization": token!},
      );

  Future<Response> putIntroduction(data) => put(
        "${dotenv.get('BASE_URL')}/user/introduction",
        data,
        headers: {"Authorization": token!},
      );
}
