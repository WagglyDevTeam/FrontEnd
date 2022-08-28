import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';

const host = "http://54.180.108.210:8080";
// const host = "http://192.168.10.16:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjA5MjA3NTksImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0M0B3YWdnbHkuY29tIn0.tcVf4IoqNlJ5H7jgvA-fg8UaUM-NiySbA-nACJA1p6c";

final SignInController signInController = Get.put(SignInController());
final token = signInController.getToken();

class PostProvider extends GetConnect {
  final Map<String, String> authHeaders = token != null ? {"Authorization": token!} : {};

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
