import 'dart:convert';

import 'package:flutter/cupertino.dart';

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
  Datas datas;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        code: json["code"],
        success: json["success"],
        datas: Datas.fromJson(json["datas"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "datas": datas.toJson(),
      };
}

class Datas {
  Datas({
    required this.profileImg,
    required this.nickname,
  });

  String profileImg;
  String nickname;

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        profileImg: json["profileImg"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "profileImg": profileImg,
        "nickname": nickname,
      };
}
