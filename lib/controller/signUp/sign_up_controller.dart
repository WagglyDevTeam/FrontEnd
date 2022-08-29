import 'dart:async';

import 'package:get/get.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signUp/dtos/sign_up_request_dto.dart';
import 'package:waggly/model/signUp/dtos/verify_email_request_dto.dart';
import 'package:waggly/model/signUp/sign_up_provider.dart';
import 'package:waggly/model/signUp/sign_up_repository.dart';

class SignUpController extends GetxController {
  final _signUpRepository = SignUpRepository();
  final count = (10 * 1).obs;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  bool isStart = false;
  bool emailVerified = false;

  RxBool emailInputEmpty = true.obs;

  void startTimer() {
    if (isStart) {
      _timer.cancel();
    }
    isStart = true;
    count.value = (10 * 1);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      count.value--;
      if (count <= 0) {
        _timer.cancel();
        isStart = false;
      }
    });
  }

  Future<void> signUp(SignUpRequestDto dto) async {
    await _signUpRepository.signUp(dto);
  }

  Future<void> sendEmailForVerify(String email) async {
    await _signUpRepository.sendEmailForVerify(email);
  }

  Future<WagglyResponseDto> verifyEmail(VerifyEmailReqeustDto dto) async {
    final WagglyResponseDto verifyResult = await _signUpRepository.verifyEmail(dto);
    if (verifyResult.code == 200) {
      emailVerified = true;
    } else {
      emailVerified = false;
    }

    return verifyResult;
  }
}

// waggle04@waggly.com
// test1234!
// 창원대학교
// 컴퓨터공학과
