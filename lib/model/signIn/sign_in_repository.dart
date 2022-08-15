import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';
import 'package:waggly/model/signIn/sign_in_provider.dart';

import '../post/dtos/waggly_response_dto.dart';

class SignInRepository{
  final SignInProvider _signInProvider = SignInProvider();

  Future<void> signIn(SignInRequestDto data) async{
    Response response = await _signInProvider.signIn(data);
    print(response.statusCode);
    print(response.headers);
  }
}