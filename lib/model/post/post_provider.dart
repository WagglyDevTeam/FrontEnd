import 'package:get/get.dart';

const host = "http://192.168.199.158:8080"; // 집
const host2 = "http://192.168.10.60:8080"; // 회사

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NTk5NTkyNjYsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0M0B3YWdnbHkuY29tIn0.-ycGoipWtuU14kIcml1gdCmwTAf4pU5_ZcXJTRkZdM8";

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
