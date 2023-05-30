
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  RxInt rootPageIndex = 0.obs;
  GlobalKey<NavigatorState> navigatorKeyFilter = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKeyPost = GlobalKey<NavigatorState>();
  RxBool isCategoryPageOpen = false.obs;

  void changeRootPageIndex(int index) {
    rootPageIndex(index);
  }

  Future<bool> onWillPop() async {
    setCategoryPage(false);
    return !await navigatorKeyFilter.currentState!.maybePop();
  }

  void setCategoryPage(bool ck) {
    isCategoryPageOpen(ck);
  }

  void back() {
    setCategoryPage(false);
    onWillPop();
  }
}