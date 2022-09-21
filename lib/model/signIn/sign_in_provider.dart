import 'package:get/get.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';

const host = "http://15.164.94.209:8080";
//const host = "http://172.30.1.94:8080";

class SignInProvider extends GetConnect {
  Future<Response> signIn(SignInRequestDto data) => post(
        "$host/user/login",
        data.toJson(),
      );
}
