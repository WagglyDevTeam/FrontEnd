import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class SignUpProvider extends GetConnect {
  Future<Response> signUp(Map<String, dynamic> data) => post(
        "${dotenv.get('BASE_URL')}/user/signup",
        data,
      );

  Future<Response> sendEmailForVerify(Map<String, dynamic> data) => post(
        "${dotenv.get('BASE_URL')}/user/email",
        data,
      );

  Future<Response> verifyEmail(Map<String, dynamic> data) => post(
        "${dotenv.get('BASE_URL')}/user/email/certification",
        data,
      );

  Future<Response> checkDuplicateEmail(Map<String, dynamic> data) => post(
    "${dotenv.get('BASE_URL')}/user/check/email",
    data,
  );

  Future<Response> checkDuplicateNickname(Map<String, dynamic> data) => post(
        "${dotenv.get('BASE_URL')}/user/nickname",
        data,
      );

  Future<Response> resetPassword(String token, String newPassword) => put(
        "${dotenv.get('BASE_URL')}/user/reset/password",
        {"password": newPassword},
        headers: {"Authorization": 'Bearer $token'},
      );
}
