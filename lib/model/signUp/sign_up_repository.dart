import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/signUp/dtos/sign_up_request_dto.dart';
import 'package:waggly/model/signUp/sign_up_provider.dart';

import '../post/dtos/waggly_response_dto.dart';

class SignUpRepository {
  final SignUpProvider _signUpProvider = SignUpProvider();

  Future<void> signUp(SignUpRequestDto data) async {
    Response response = await _signUpProvider.signUp(data.toJson());
    dynamic body = response.body;
    print(body);
  }
}
