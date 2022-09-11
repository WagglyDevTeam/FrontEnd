import 'dart:async';

import 'package:get/get.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/signUp/dtos/sign_up_request_dto.dart';
import 'package:waggly/model/signUp/dtos/verify_email_request_dto.dart';
import 'package:waggly/model/signUp/sign_up_provider.dart';
import 'package:waggly/model/signUp/sign_up_repository.dart';

class SignUpController extends GetxController {
  final _signUpRepository = SignUpRepository();

  final count = (60 * 1).obs;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  bool isStart = false;
  bool emailVerified = false;

  RxBool emailInputEmpty = true.obs;
  RxBool certiNumberInputEmpty = true.obs;
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
  RxBool nicknameDuplicateCheckSuccess = false.obs;

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

  Future<void> signUp(SignUpRequestDto dto) async {
    await _signUpRepository.signUp(dto);
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

  Future<void> checkDuplicateNickname(String nickname) async {
    final WagglyResponseDto result = await _signUpRepository.checkDuplicateNickname(nickname);
    print(result);
    if (result.code == 200) {
      nicknameDuplicateCheckSuccess.value = true;
    } else {
      emailVerified = false;
    }
  }
}

// waggle04@waggly.com
// test1234!
// 창원대학교
// 컴퓨터공학과
