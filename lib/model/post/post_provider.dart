import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';

// const host = "http://54.180.108.210:8080";
const host = "http://172.30.1.94:8080";

final SignInController _signInController = Get.put(SignInController());
final _token = _signInController.getToken();

class PostProvider extends GetConnect {
  final Map<String, String> authHeaders = _token != null ? {"Authorization": _token!} : {};

  Future<Response> getBoard() => get(
        "$host/board?college=social",
        headers: authHeaders,
      );

  Future<Response> writeBoard(FormData data) => post(
        "$host/board",
        data,
        headers: authHeaders,
      );

  Future<Response> getHome() => get(
        "$host/home",
        headers: authHeaders,
      );
}
