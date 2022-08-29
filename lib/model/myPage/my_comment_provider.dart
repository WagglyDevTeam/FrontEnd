import 'package:get/get.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';

const host = "http://54.180.108.210:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjA2MjcyOTIsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.tp1maiIyDA_XlQyOEi-NXGO_t1DaKPlOtmEEcO9Lp6I";

final SignInController signInController = Get.put(SignInController());
final token = signInController.getToken();

class MyCommentsListProvider extends GetConnect {
  final Map<String, String> authHeaders =
      token != null ? {"Authorization": token!} : {};

  final page = 0;
  final size = 10;
  Future<Response> getMyComments() => get(
        "$host/user/comment?page=${page}&size=${size}",
        headers: authHeaders,
      );
}
