import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/signUp/dtos/sign_up_request_dto.dart';
import 'package:waggly/model/signUp/dtos/verify_email_request_dto.dart';
import 'package:waggly/model/signUp/sign_up_provider.dart';

import '../post/dtos/waggly_response_dto.dart';

class SignUpRepository {
  final SignUpProvider _signUpProvider = SignUpProvider();

  Future<void> signUp(SignUpRequestDto data) async {
    Response response = await _signUpProvider.signUp(data.toJson());
    dynamic body = response.body;
    print(body);
  }

  Future<void> sendEmailForVerify(String email) async {
    await _signUpProvider.sendEmailForVerify({"email": email});
  }

  Future<WagglyResponseDto> verifyEmail(VerifyEmailReqeustDto dto) async {
    Response response = await _signUpProvider.verifyEmail(dto.toJson());
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }

  Future<WagglyResponseDto> checkDuplicateNickname(String nickname) async {
    Response response = await _signUpProvider.checkDuplicateNickname({"nickname": nickname});
    dynamic body = response.body;
    WagglyResponseDto wagglyResponseDto = WagglyResponseDto.fromJson(body);
    return wagglyResponseDto;
  }
}
