import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/model/myPage/notification_model.dart';
import 'package:waggly/model/myPage/notification_provider.dart';

class NotificationController extends GetxController {
  final NotificationProvider _notificationProvider = NotificationProvider();
  final notifications = <NotificationModel>[].obs;
  final notificationData = <Data>[].obs;
  final isEdit = false.obs;
  final isAllChecked = false.obs;
  final isChecked = false.obs;
  final isCheckedId = [].obs;

  get item => null;

  //선택된 알림 id 값을 배열에 넣어주는 것
  void addCheckedId(value) {
    isCheckedId.add(value);
  }

  //선택된 알림 id 값을 배열에서 빼는 것
  void removeCheckedId(value) {
    isCheckedId.remove(value);
  }

  //전체선택시, 전체데이터의 id값을 다 넣어주는 것
  void changeIsAllChecked(value, item) {
    isAllChecked.value = value;
    print(value);
    if (value) {
      for (var i = 0; i < item; i++) {
        addCheckedId(i);
      }
      print(isCheckedId);
    } else {
      for (var i = 0; i < item; i++) {
        removeCheckedId(i);
      }
    }
  }

  //single 선택시에 값을 넣어주는 것
  void changeIsChecked(value, item) {
    isChecked.value = value;
    if (value) {
      addCheckedId(item);
    } else {
      removeCheckedId(item);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getNotification();
  }

  Future<void> getNotification() async {
    Response response = await _notificationProvider.getNotification();
    dynamic body = response.body;
    List<dynamic> notificationJson = body['datas'];
    List<Data> convertNotifications =
        notificationJson.map((e) => Data.fromJson(e)).toList();
    notificationData.value = convertNotifications;
  }
}
