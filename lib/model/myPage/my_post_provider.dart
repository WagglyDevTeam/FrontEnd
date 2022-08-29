import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/hive/user.dart';

const host = "http://54.180.108.210:8080";

class MyPostsListProvider extends GetConnect {
  final token = Hive.box<User>('user').get('user')?.jwtToken;

  Future<Response> getMyPosts() => get(
        "$host/user/post?page=0&size=10",
        headers: {"Authorization": token!},
      );
}
