import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:waggly/model/major/major.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signUp/dtos/sign_up_request_dto.dart';
import 'package:waggly/model/signUp/dtos/verify_email_request_dto.dart';
import 'package:waggly/model/signUp/sign_up_provider.dart';
import 'package:waggly/model/signUp/sign_up_repository.dart';

class SignUpController extends GetxController {
  final _signUpRepository = SignUpRepository();

  final count = (60 * 1).obs;
  late FocusNode focus;

  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  bool isStart = false;
  bool emailVerified = false;
  Major selectedMajor = Major();
  String tempToken = '';

  RxBool emailInputEmpty = true.obs;
  RxBool certiNumberInputEmpty = true.obs;
  RxBool universityInputEmpty = true.obs;
  RxBool majorInputEmpty = true.obs;
  RxBool classNumberInputEmpty = true.obs;
  RxBool passwordInputEmpty = true.obs;
  RxBool passwordConfirmInputEmpty = true.obs;
  RxBool nicknameInputEmpty = true.obs;

  RxBool emailValidateSuccess = true.obs;
  RxBool certiNumValidateSuccess = true.obs;
  RxBool classNumberValidateSuccess = true.obs;
  RxBool passwordValidateSuccess = true.obs;
  RxBool passwordConfirmValidateSuccess = true.obs;
  RxBool nicknameValidateSuccess = true.obs;
  RxBool nicknameDuplicateCheckSuccess = true.obs;

  RxString passwordInputValue = ''.obs;
  RxString passwordConfirmInputValue = ''.obs;
  RxBool signUpSuccess = false.obs;
  String confirmedUniversityName = '';

  void startTimer() {
    if (isStart) {
      _timer.cancel();
    }
    isStart = true;
    count.value = (60 * 1);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      count.value--;
      if (count <= 0) {
        _timer.cancel();
        isStart = false;
      }
    });
  }

  Future<WagglyResponseDto> signUp(SignUpRequestDto dto) async {
    return await _signUpRepository.signUp(dto);
  }

  Future<void> sendEmailForVerify(String email) async {
    await _signUpRepository.sendEmailForVerify(email);
  }

  Future<WagglyResponseDto> verifyEmail(VerifyEmailReqeustDto dto) async {
    final WagglyResponseDto verifyResult = await _signUpRepository.verifyEmail(dto);
    // print(verifyResult.datas);
    if (verifyResult.code == 200) {
      emailVerified = true;
      confirmedUniversityName = verifyResult.datas['university'];
    } else {
      emailVerified = false;
    }

    return verifyResult;
  }

  Future<WagglyResponseDto> checkDuplicateEmail(String email) async {
    final WagglyResponseDto result = await _signUpRepository.checkDuplicateEmail(email);

    return result;
  }

  Future<WagglyResponseDto> checkDuplicateNickname(String nickname) async {
    final WagglyResponseDto result = await _signUpRepository.checkDuplicateNickname(nickname);
    if (result.code == 200) {
      nicknameDuplicateCheckSuccess.value = true;
    } else {
      nicknameDuplicateCheckSuccess.value = false;
    }
    // print(result);
    return result;
  }

  Future<WagglyResponseDto> resetPassword(String token, String newPassword) async {
    WagglyResponseDto result = await _signUpRepository.resetPassword(token, newPassword);
    return result;
  }
}

// waggly_test@korea.ac.kr
// R6d9Ke
