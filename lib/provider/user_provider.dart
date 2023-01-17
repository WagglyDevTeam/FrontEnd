import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect.dart';
import 'package:waggly/model/signIn/dtos/device_token_request_dto.dart';

class UserProvider extends GetConnect {
  Future<Response> getDeviceToken(int userId) => get(
        "${dotenv.get('BASE_URL')}/user/$userId/device-token",
      );

  Future<Response> putDeviceToken(DeviceTokenRequestDto data, int userId, String token) => put(
        "${dotenv.get('BASE_URL')}/user/$userId/device-token",
        data.toJson(),
        headers: {"Authorization": token},
      );
}
