import 'package:get/get.dart';

// const host = "http://192.168.199.158:8080"; // 집
const host = "http://192.168.199.135:8080"; // 회사
// const host = "http://54.180.108.210:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjAyMTkzNDMsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.5ykvpoj1NKAhQ90dej2wVQldSRTHKupW2Y0p3G2nQxM";

class PostProvider extends GetConnect {
  Future<Response> getBoard() => get(
        "$host/board?college=social",
        headers: {"Authorization": jwtToken},
      );

  Future<Response> writeBoard(FormData data) => post(
        "$host/board",
        data,
        headers: {"Authorization": jwtToken},
      );
}
