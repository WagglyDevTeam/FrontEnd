import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';
import 'package:waggly/model/signIn/sign_in_repository.dart';
import '../../model/signIn/sign_in_provider.dart';

class SignInController extends GetxController {
  final SignInProvider _signInProvider = SignInProvider();
  String tempToken = '';
  final box = Hive.box<User>('user');
  final user = User().obs;
  RxBool isLoggedIn = false.obs;
  RxBool emailInputEmpty = true.obs;
  RxBool passwordInputEmpty = true.obs;

  Future<WagglyResponseDto> signIn(SignInRequestDto signInRequestDto) async {
    Response response = await _signInProvider.signIn(signInRequestDto);
    dynamic body = response.body;

    if (body.runtimeType == String) {
      WagglyResponseDto wagglyResponseDto =
          WagglyResponseDto(code: 401, message: "비밀번호를 확인해주세요.", status: 401, datas: null);
      return wagglyResponseDto;
    } else {
      WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);

      User user = User.fromDto(wagglyResponseDto);
      user.jwtToken = response.headers!["authorization"];
      box.put('user', user);

      return wagglyResponseDto;
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
      WidgetsBinding.instance.addPostFrameCallback((_) => isLoggedIn.value = false);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => isLoggedIn.value = true);
    }
    return isLoggedIn;
  }

  String? getToken() {
    String? token;
    WidgetsBinding.instance.addPostFrameCallback((_) async => token = box.get('user')?.jwtToken);

    return token;
  }
}
