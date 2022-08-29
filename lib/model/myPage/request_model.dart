import 'dart:convert';

RequestModel requestModelFromJson(String str) =>
    RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  RequestModel({
    required this.code,
    required this.success,
    required this.datas,
  });

  int code;
  bool success;
  List<Data> datas;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        code: json["code"],
        success: json["success"],
        datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.requestId,
    required this.requestPurpose,
    required this.requestCreatedAt,
    required this.requestUser,
  });

  int requestId;
  String requestPurpose;
  String requestCreatedAt;
  RequestUser requestUser;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestId: json["requestId"],
        requestPurpose: json["requestPurpose"],
        requestCreatedAt: json["requestCreatedAt"],
        requestUser: RequestUser.fromJson(json["requestUser"]),
      );

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "requestPurpose": requestPurpose,
        "requestCreatedAt": requestCreatedAt,
        "requestUser": requestUser.toJson(),
      };
}

class RequestUser {
  RequestUser({
    this.userId,
    this.nickname,
    this.gender,
    this.major,
  });

  final int? userId;
  final String? nickname;
  final String? gender;
  final String? major;

  factory RequestUser.fromJson(Map<String, dynamic> json) => RequestUser(
        userId: json["userId"],
        nickname: json["nickname"],
        gender: json["gender"],
        major: json["major"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "nickname": nickname,
        "gender": gender,
        "major": major,
      };
}
