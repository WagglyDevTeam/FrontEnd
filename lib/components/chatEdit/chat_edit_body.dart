import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/chatEdit/chat_edit_controller.dart';
import '../../utils/colors.dart';

List<String> step1 = <String>["필터 설정을 통해 소통을 도와드릴게요!","어떤 친구를 찾으세요?"];
List<String> step2 = <String>["어떤 친구와 소통하고 싶나요?",""];

class ChatEditBody extends StatelessWidget{
  const ChatEditBody({Key? key, this.stepNumber}) : super(key: key);
  final stepNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        if(stepNumber == 1)
          ChatEditBodyItem(itemList: step1)
        else if(stepNumber == 2 || stepNumber == 3)
          ChatEditBodyItem(itemList: step2)
        ,
        Container(
          width: 324.w,
          height: 15.h,
          alignment: Alignment.centerRight,
          child: Text("$stepNumber/3",style: TextStyle(
              fontFamily: "NotoSansKR_Md",
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(182, 182, 182, 1))),
        ),
        SizedBox(height: 5.h,),
        StepLiner(),
        SizedBox(height: 48.h,),
        if(stepNumber == 1)
          StepOneOption(stepNumber: stepNumber,)
        else if(stepNumber == 2)
          StepTwoOption(stepNumber: stepNumber)
      ],
    );
  }
}

class ChatEditBodyItem extends StatelessWidget{

  const ChatEditBodyItem({Key? key, this.itemList}) : super(key: key);
  final itemList;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 48.h,
      width: 324.w,
      child: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (BuildContext context, int index){
            return SizedBox(
                height: 24.h,
                width: 324.w,
                child: Text(itemList[index],style: TextStyle(
                    fontFamily: "NotoSansKR_Md",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)));
          }
      ),
    );
  }
  
}

class StepLiner extends StatelessWidget{
  const StepLiner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatEditController controller = Get.put(ChatEditController());
    return Obx(() => Stack(
      children:<Widget>[
        Container(
          width: 324.w,
          height: 1.5,
          color: Color.fromRGBO(232, 232, 232, 1),
        ),
        AnimatedContainer(
          width: controller.stepLineWidth.value.w,
          height: 1.5,
          decoration: BoxDecoration(
              color: Palette.main,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        ),
      ],
    ));
  }
}

class StepOneOption extends StatelessWidget{
  const StepOneOption({Key? key, this.stepNumber}) : super(key: key);
  final stepNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepOptionItem(optionString:"편하게 소통 할 수 있는 친구",optionValue: "friend",stepNumber: stepNumber,),
        SizedBox(height: 8.h,),
        StepOptionItem(optionString:"학교 생활에 관련해 도움을 구할 수 있는 친구",optionValue: "helper",stepNumber: stepNumber),
      ],
    );
  }

}

class StepTwoOption extends StatelessWidget{
  const StepTwoOption({Key? key, this.stepNumber}) : super(key: key);
  final stepNumber;
  @override
  Widget build(BuildContext context) {
    ChatEditController controller = Get.put(ChatEditController());
    return Column(
      children: [
        StepOptionItem(optionString:"후배",optionValue: "junior",stepNumber: stepNumber),
        SizedBox(height: 8.h,),
        StepOptionItem(optionString:"동기",optionValue: "same",stepNumber: stepNumber),
        SizedBox(height: 8.h,),
        StepOptionItem(optionString:"선배",optionValue: "senior",stepNumber: stepNumber),
        SizedBox(height: 8.h,),
        Container(
            alignment: Alignment.centerLeft,
            width: 324.w,
            height: 14.h,
            child: Obx(() => Row(
              children: [
                Transform.scale(
                  scale: 0.7.w,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Palette.main,
                    ),
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      checkColor: Palette.main,
                        activeColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: controller.isSameSex.value,
                        onChanged: (value){
                          controller.changeIsSameSex(value);}
                    ),
                  ),
                ),
                Text(
                  "동성만 찾기",
                  style: TextStyle(
                    fontFamily: "NotoSansKR_Md",
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color:Colors.black)
                )
              ],
            ))
        )
      ],
    );
  }

}

class StepOptionItem extends StatelessWidget{
  const StepOptionItem({Key? key, this.optionString, this.optionValue, this.stepNumber}) : super(key: key);
  final optionString;
  final optionValue;
  final stepNumber;
  @override
  Widget build(BuildContext context) {
    ChatEditController controller = Get.put(ChatEditController());
    return Obx(() => InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: (){
          if(stepNumber == 1){
            controller.changeStepOneOption(optionValue);
          }else if(stepNumber == 2){
            controller.changeStepTwoOption(optionValue);
          }
        },
        child: Container(
          width: 324.w,
          height: 42.h,
          alignment: Alignment.center,
          decoration:BoxDecoration(
              color: controller.stepOneOption == optionValue || controller.stepTwoOption == optionValue ? Palette.main : Color.fromRGBO(218, 175, 254, 0.2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Text(optionString,
              style: TextStyle(
                  fontFamily: "NotoSansKR_Md",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: controller.stepOneOption == optionValue || controller.stepTwoOption == optionValue ? Colors.white : Colors.black)),
        )
    ));
  }

}