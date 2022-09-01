import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/model/hive/user.dart';

const host = "http://54.180.108.210:8080";

class MyProfileProvider extends GetConnect {
  final token = Hive.box<User>('user').get('user')?.jwtToken;

  Future<Response> modifyProfile(FormData data) => put(
        "$host/user/profile",
        data,
        headers: {"Authorization": token!},
      );

  Future<Response> putIntroduction(data) => put(
        "$host/user/introduction",
        data,
        headers: {"Authorization": token!},
      );
}
