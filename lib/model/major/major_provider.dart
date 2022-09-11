import 'package:get/get.dart';

// const host = "http://54.180.108.210:8080";
const host = "http://172.30.1.94:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjIzNTAzMjQsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.Y-NbklEJnMIB-JRoz8NbAq5V97PD9jT8TdnEUmjah_4";

class MajorProvider extends GetConnect {
  Future<Response> getMajorListByUniversityName(String universityName) => get(
        "$host/major?university=$universityName",
        headers: {"Authorization": jwtToken},
      );
}
