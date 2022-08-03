import 'package:get/get.dart';

const host = "http://192.168.199.158:8080";
const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NTk3OTU0OTcsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0M0B3YWdnbHkuY29tIn0.9D1Lu6zMk4uNtITFuRezcRZXZmEnZfi0q1NMSfs4lYw";

class PostProvider extends GetConnect {
  Future<Response> getBoard() => get(
        "$host/board?college=social",
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
