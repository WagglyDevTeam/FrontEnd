import 'package:get/get.dart';

const host = "http://192.168.199.158:8080"; // 집
const host2 = "http://192.168.10.60:8080"; // 회사

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NTk4NDU0ODQsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.uRao3MHA2Ha-tRGt1J3BCo4msrYmG2fxzEgqs5vLLSk";

class PostProvider extends GetConnect {
  Future<Response> getBoard() => get(
        "$host2/board?college=social",
        headers: {"Authorization": jwtToken},
      );
  //
  // Future<Response> findById(int? id) => get(
  //       "$host/post/$id",
  //       headers: {"Authorization": jwtToken ?? ""},
  //     );
  //
  // Future<Response> deleteById(int? id) => delete(
  //       "$host/post/$id",
  //       headers: {"Authorization": jwtToken ?? ""},
  //     );
}
