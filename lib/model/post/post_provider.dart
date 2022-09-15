import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';

final SignInController _signInController = Get.put(SignInController());
final _token = _signInController.getToken();

class PostProvider extends GetConnect {
  final Map<String, String> authHeaders = _token != null ? {"Authorization": _token!} : {};

  Future<Response> getBoard() => get(
        "${dotenv.get('BASE_URL')}/board?college=social",
        headers: authHeaders,
      );

  Future<Response> writeBoard(FormData data) => post(
        "${dotenv.get('BASE_URL')}/board",
        data,
        headers: authHeaders,
      );

  Future<Response> getHome() => get(
        "${dotenv.get('BASE_URL')}/home",
        headers: authHeaders,
      );
}
