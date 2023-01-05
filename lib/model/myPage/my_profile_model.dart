import 'dart:convert';

import 'package:get/get.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.code,
    required this.success,
    required this.datas,
  });

  int code;
  bool success;
  ProfileData datas;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        code: json["code"],
        success: json["success"],
        datas: ProfileData.fromJson(json["datas"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "datas": datas.toJson(),
      };
}

class ProfileData {
  ProfileData({
    required this.nickname,
  });

  String nickname;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
      };
}
