import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';
import '../../model/signIn/sign_in_provider.dart';

class SignInController extends GetxController {
  final SignInProvider _signInProvider = SignInProvider();
  String tempToken = '';
  final box = Hive.box<User>('user');
  final user = User().obs;
  RxBool isLoggedIn = false.obs;
  RxBool emailValidateSuccess = true.obs;
  RxBool passwordValidateSuccess = true.obs;

  RxBool emailInputEmpty = true.obs;
  RxBool passwordInputEmpty = true.obs;

  Future<WagglyResponseDto> signIn(SignInRequestDto signInRequestDto) async {
    Response response = await _signInProvider.signIn(signInRequestDto);
    dynamic body = response.body;
    if (response.hasError) {
      if (body.runtimeType == String && body.contains('Invalid password')) {
        WagglyResponseDto wagglyResponseDto =
            WagglyResponseDto(code: 401, message: "비밀번호를 확인해주세요.", status: 401, datas: null);
        return wagglyResponseDto;
      } else if (body.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>") {
        WagglyResponseDto wagglyResponseDto =
            WagglyResponseDto(code: 403, message: "해당 유저를 찾을 수 없습니다.", status: 403, datas: null);
        return wagglyResponseDto;
      } else {
        WagglyResponseDto wagglyResponseDto =
            WagglyResponseDto(code: 500, message: "알 수 없는 오류가 발생했습니다.", status: 500, datas: null);
        return wagglyResponseDto;
      }
    } else {
      WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
      User user = User.fromDto(wagglyResponseDto);
      user.jwtToken = response.headers!["authorization"];
      this.user.value = user;
      box.put('user', user);
      // print(this.user.value);
      // print(this.user.value.id);

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
