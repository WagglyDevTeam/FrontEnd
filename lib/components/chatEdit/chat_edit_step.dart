import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/chatEdit/chat_edit_controller.dart';

class ChatEditStep extends StatelessWidget{
  const ChatEditStep({Key? key, this.stepNumber}) : super(key: key);
  final stepNumber;
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 324.w,
      height: 24.h,
      color: Colors.white,
      child: Row(
        children: [
          Text("Q$stepNumber",
            style: TextStyle(
                fontFamily: "NotoSansKR_Md",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black),),
          stepNumber == 1 ? SizedBox(width: 261.w,):SizedBox(width: 231.w,) , // 채팅 만들기 단계가 1이라면
          stepNumber == 1 ? SizedBox() : GoStepButton(direction: "left",stepNumber: stepNumber,) , // 채팅 만들기 단계가 1이라면
          SizedBox(width: 1.w,),
          GoStepButton(direction: "right",stepNumber: stepNumber),
        ],
      )
    );
  }
}

class GoStepButton extends StatelessWidget{
  const GoStepButton({Key? key, this.direction, this.stepNumber}) : super(key: key);

  final direction;
  final stepNumber;
  @override
  Widget build(BuildContext context) {
    ChatEditController controller = Get.put(ChatEditController());
    return RotatedBox(quarterTurns: direction == "left" ? 0 : 2, // 이전 방향이면 회전x 다음 단계면 회전
    child: Container(
      width: 30.w,
      height: 20.h,
      color: Colors.white,
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          controller.changeStepNumber(nextStepFuc(stepNumber,direction));
          controller.changeStepLineWidth(animationLineFuc(controller.stepNumber));
        },
        child: SvgPicture.asset('assets/icons/arrowLeft.svg', width: 14.w,height: 14.h,),
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            backgroundColor: Color.fromRGBO(218, 175, 254, 0.3),
            primary: Color.fromRGBO(218, 175, 254, 0.9),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)))
        ),
      ),
    ));
  }

  int nextStepFuc(step,direction){
    if(step != 3 && direction == "right") {
      step++;
    }
    else if(step != 1 && direction == "left"){
      step--;
    }
    return step;
  }

  double animationLineFuc(stepNumber){
    if(stepNumber == 1){
      return 100.0;
    }else if(stepNumber == 2){
      return 224.0;
    }else{
      return 324.0;
    }
  }

}

