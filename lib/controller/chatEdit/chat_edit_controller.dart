import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatEditController extends GetxController{
  final stepNumber = 1.obs;
  final stepLineWidth = 80.0.obs;
  final stepOneOption = "".obs;
  final stepTwoOption = "".obs;
  final isSameSex = false.obs;

  void changeStepNumber(step){
    stepNumber.value = step;
  }
  void changeStepLineWidth(step){
    stepLineWidth.value = step;
  }
  void changeStepOneOption(value){
    stepOneOption.value = value;
  }

  void changeStepTwoOption(value){
    stepTwoOption.value = value;
  }

  void changeIsSameSex(value){
    isSameSex.value = value;
  }
  void pr(){
    print(stepNumber);
  }
}