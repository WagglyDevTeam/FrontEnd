import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';

import '../hive/user.dart';

final SignInController _signInController = Get.put(SignInController());
final _token = _signInController.getToken();

class PostProvider extends GetConnect {
  final Map<String, String> authHeaders = _token != null ? {"Authorization": _token!} : {};

  Future<Response> getBoard() => get(
        "${dotenv.get('BASE_URL')}/board?college=social",
        headers: authHeaders,
      );

  Future<Response> writeBoard(FormData data){
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return post(
      "${dotenv.get('BASE_URL')}/board",
      data,
      headers: {"Authorization": token!},
    );
  }

  Future<Response> getHome() => get(
        "${dotenv.get('BASE_URL')}/home",
        headers: authHeaders,
      );
  Future<Response> getBoardHome() => get(
    "${dotenv.get('BASE_URL')}/board/home",
    headers: authHeaders,
  );

  Future<Response> editBoard(FormData data){
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    print("여기임");
    print(authHeaders);
    return put(
      "${dotenv.get('BASE_URL')}/board/4",
      data,
      headers: {"Authorization": token!},
    );
  }
}
