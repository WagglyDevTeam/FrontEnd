import 'package:get/get.dart';

// const host = "http://54.180.108.210:8080";
const host = "http://192.168.199.158:8080";

class SignUpProvider extends GetConnect {
  Future<Response> signUp(Map<String, dynamic> data) => post(
        "$host/user/signup",
        data,
      );

  Future<Response> sendEmailForVerify(Map<String, dynamic> data) => post(
        "$host/user/email",
        data,
      );

  Future<Response> verifyEmail(Map<String, dynamic> data) => post(
        "$host/user/email/certification",
        data,
      );
}
