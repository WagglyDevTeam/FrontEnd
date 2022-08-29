import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';
import 'package:waggly/model/signIn/sign_in_repository.dart';
import '../../model/signIn/sign_in_provider.dart';

class SignInController extends GetxController {
  final SignInProvider _signInProvider = SignInProvider();
  final box = Hive.box<User>('user');
  final user = User().obs;
  RxBool isLoggedIn = false.obs;

  Future<bool> signIn(SignInRequestDto signInRequestDto) async {
    Response response = await _signInProvider.signIn(signInRequestDto);

    if (response.statusCode == 200) {
      dynamic body = response.body;

      WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
      User user = User.fromDto(wagglyResponseDto);
      user.jwtToken = response.headers!["authorization"];
      box.put('user', user);
      print(box.get('user')?.jwtToken);

      return true;
    } else {
      return false;
    }
  }

  void logout() {
    user.value = User();
    box.delete('user');
    isLoggedIn.value = false;
  }

  RxBool checkLoggedIn() {
    String? token = box.get('user')?.jwtToken;

    if (token == null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => isLoggedIn.value = false);
    } else {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => isLoggedIn.value = true);
    }
    return isLoggedIn;
  }

  String? getToken() {
    String? token;
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => token = box.get('user')?.jwtToken);

    return token;
  }
}
