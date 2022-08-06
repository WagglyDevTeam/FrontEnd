import 'dart:convert';
import 'package:get/get.dart';

class CheckBoxModal {
  String content;
  String name;
  bool value;
  String time;
  String purpose;

  CheckBoxModal(
      {this.value = false,
      required this.name,
      required this.content,
      required this.time,
      required this.purpose});
}
