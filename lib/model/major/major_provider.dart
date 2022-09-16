import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjIzNTAzMjQsImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.Y-NbklEJnMIB-JRoz8NbAq5V97PD9jT8TdnEUmjah_4";

class MajorProvider extends GetConnect {
  Future<Response> getMajorListByUniversityName(String universityName) => get(
        "${dotenv.get('BASE_URL')}/major?university=$universityName",
        headers: {"Authorization": jwtToken},
      );
}
