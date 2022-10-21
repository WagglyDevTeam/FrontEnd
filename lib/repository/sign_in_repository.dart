import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';
import 'package:waggly/provider/sign_in_provider.dart';

import '../model/post/dtos/waggly_response_dto.dart';

class SignInRepository {
  final SignInProvider _signInProvider = SignInProvider();

  Future<void> signIn(SignInRequestDto data) async {}
}
