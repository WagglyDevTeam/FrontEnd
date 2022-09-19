import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';

class SignInProvider extends GetConnect {
  Future<Response> signIn(SignInRequestDto data) => post(
        "${dotenv.get('BASE_URL')}/user/login",
        data.toJson(),
      );
}
