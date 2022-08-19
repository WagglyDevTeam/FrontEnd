import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpController extends GetxController{
  final count = (60*1).obs;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  bool isStart = false;

  void startTimer() {
    if(isStart){
      _timer.cancel();
    }
    isStart = true;
    count.value = (60*1);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      count.value--;
      if(count <= 0){
        _timer.cancel();
        isStart = false;
      }
    });


  }
}