import 'dart:convert';
import 'package:get/get.dart';

List<WagglyImg> wagglyImgFromJson(String str) =>
    List<WagglyImg>.from(json.decode(str).map((x) => WagglyImg.fromJson(x)));

String wagglyImgToJson(List<WagglyImg> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WagglyImg {
  WagglyImg({
    required this.id,
    required this.img,
  });

  int id;
  String img;

  var selected = false.obs;

  factory WagglyImg.fromJson(Map<String, dynamic> json) => WagglyImg(
        id: json["id"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
      };
}

class WagglyImgModel {
  int id;
  String img;
  bool value;

  WagglyImgModel({this.value = false, required this.id, required this.img});
}

class ProfileImgModel {
  String img;

  ProfileImgModel({required this.img});
}
