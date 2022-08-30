import 'package:get/get.dart';

// const host = "http://54.180.108.210:8080";
const host = "http://192.168.10.16:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjIwOTA0MDksImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.q7Yi3WX1_ZhSoAan42ud94uHjGtC9rIxxK-eWyZ1qN4";

class MajorProvider extends GetConnect {
  Future<Response> getMajorListByUniversityName(String universityName) => get(
    "$host/major?university=$universityName",
    headers: {"Authorization": jwtToken},
  );
}
