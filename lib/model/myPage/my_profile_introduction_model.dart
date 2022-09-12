import 'dart:convert';

IntroductionModel introductionModelFromJson(String str) =>
    IntroductionModel.fromJson(json.decode(str));

String introductionModelToJson(IntroductionModel data) =>
    json.encode(data.toJson());

class IntroductionModel {
  IntroductionModel({
    required this.code,
    required this.success,
    required this.datas,
  });

  int code;
  bool success;
  Bio datas;

  factory IntroductionModel.fromJson(Map<String, dynamic> json) =>
      IntroductionModel(
        code: json["code"],
        success: json["success"],
        datas: Bio.fromJson(json["datas"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "datas": datas.toJson(),
      };
}

class Bio {
  Bio({
    required this.userIntroduction,
  });
  String userIntroduction;

  factory Bio.fromJson(Map<String, dynamic> json) => Bio(
        userIntroduction: json["userIntroduction"],
      );

  Map<String, dynamic> toJson() => {
        "userIntroduction": userIntroduction,
      };
}
