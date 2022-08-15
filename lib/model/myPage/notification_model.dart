import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.code,
    required this.success,
    required this.datas,
  });

  int code;
  bool success;
  List<Data> datas;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
    required this.alarmId,
    required this.alarmType,
    required this.alarmMsg,
    required this.pageDataId,
    required this.isReading,
    required this.time,
  });

  int alarmId;
  String alarmType;
  String alarmMsg;
  int pageDataId;
  bool isReading;
  String time;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        alarmId: json["alarmId"],
        alarmType: json["alarmType"],
        alarmMsg: json["alarmMsg"],
        pageDataId: json["pageDataId"],
        isReading: json["isReading"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "alarmId": alarmId,
        "alarmType": alarmType,
        "alarmMsg": alarmMsg,
        "pageDataId": pageDataId,
        "isReading": isReading,
        "time": time,
      };
}
