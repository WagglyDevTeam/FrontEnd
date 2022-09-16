import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';

const host = "http://54.180.108.210:8080";
// const host = "http://192.168.0.6:8080";

class SignInProvider extends GetConnect {
  Future<Response> signIn(SignInRequestDto data) => post(
        "${dotenv.get('BASE_URL')}/user/login",
        data.toJson(),
      );
}
