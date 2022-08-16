import 'package:get/get.dart';

const host = "http://54.180.108.210:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjA5MjA3NTksImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0M0B3YWdnbHkuY29tIn0.tcVf4IoqNlJ5H7jgvA-fg8UaUM-NiySbA-nACJA1p6c";

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
