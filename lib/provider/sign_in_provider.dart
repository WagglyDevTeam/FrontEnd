import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:waggly/model/signIn/dtos/device_token_request_dto.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';

class SignInProvider extends GetConnect {
  Future<Response> signIn(SignInRequestDto data) => post(
        "${dotenv.get('BASE_URL')}/user/login",
        data.toJson(),
      );

  Future<Response> getDeviceToken(int userId) => get(
        "${dotenv.get('BASE_URL')}/user/$userId/device-token",
      );

  Future<Response> putDeviceToken(DeviceTokenRequestDto data, int userId, String token) => put(
        "${dotenv.get('BASE_URL')}/user/$userId/device-token",
        data.toJson(),
        headers: {"Authorization": token},
      );
}
