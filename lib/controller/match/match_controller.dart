
import 'package:get/get.dart';

class MatchFilterController extends GetxController{
  final reFilter = false.obs;
  final state = 0.obs;
  final questionOne = 1.obs;
  final questionTwo = 2.obs;

  final answerOne = 0.obs;
  final answerTwo = 0.obs;
  final answerThree = 0.obs;
  final selectedThemeList = [].obs;
  final isSameSex = false.obs;
  final completedBtn = false.obs;



  @override
  void onInit() async{
    super.onInit();
  }


  void changeIsSameSex(value){
    isSameSex.value = value;
  }

  void addThemeList(value){
    //더했을 때 이미 들어와있으면 사라지게하기
    if(selectedThemeList.contains(value)){
      selectedThemeList.remove(value);
    }else{
      if(selectedThemeList.length == 3){
        completedBtn.value = true;
        selectedThemeList.remove(selectedThemeList[0]);
        }else{
        completedBtn.value = false;
      }
      selectedThemeList.add(value);
      print(selectedThemeList);
    }
  }

  bool findTheme(value){
   return selectedThemeList.contains(value);
  }


}