import 'package:get/get.dart';

const host = "http://54.180.108.210:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjA2MjcyOTIsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.tp1maiIyDA_XlQyOEi-NXGO_t1DaKPlOtmEEcO9Lp6I";

class MyProfileProvider extends GetConnect {
  Future<Response> modifyProfile(FormData data) => put(
        "$host/user/profile",
        data,
        headers: {"Authorization": jwtToken},
      );
}
