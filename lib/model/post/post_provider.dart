import 'package:get/get.dart';

const host = "http://54.180.108.210:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjA0NjczNDIsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.ZfTM0EU3u8TqNvuxofAOdt63lisSQXcKeX6dfMBP2Tc";

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
