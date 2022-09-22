import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../components/chatEdit/chat_edit_body.dart';
import '../components/chatEdit/chat_edit_step.dart';
import '../controller/chatEdit/chat_edit_controller.dart';
import '../utils/colors.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatEditScreen extends StatelessWidget {
  const ChatEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatEditController controller = Get.put(ChatEditController());
    Status _page = Status.home;
    String _pageTitle = '채팅';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PageAppbar(page: _page, pageTitle: _pageTitle),
          body: Obx(
            () => Column(
              children: [
                SizedBox(height: 10.h),
                ChatTypeList(),
                SizedBox(height: 96.h),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChatEditStep(
                        stepNumber: controller.stepNumber.value,
                      ),
                      ChatEditBody(stepNumber: controller.stepNumber.value)
                    ],
                  ),
                ))
              ],
            ),
          )),
    );
  }
}

class ChatTypeList extends StatefulWidget {
  const ChatTypeList({Key? key}) : super(key: key);

  @override
  _chatTypeList createState() => _chatTypeList();
}

class _chatTypeList extends State<ChatTypeList> {
  String selectType = "일대일";

  void selectOneToOneType() {
    setState(() {
      selectType = "일대일";
    });
  }

  void selectGroupType() {
    setState(() {
      selectType = "그룹";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            print("object");
          },
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Palette.main,
                  border: Border.all(
                    color: selectType == "일대일"
                        ? Color(0xff959595)
                        : Color(0xffFFFFFF),
                  ),
                  borderRadius: BorderRadius.circular(20)),
              width: 155.w,
              height: 24.h,
              padding: EdgeInsets.all(0),
              child: SvgPicture.asset(
                'assets/icons/unions.svg',
                color: Colors.white,
                width: 13.w,
                height: 12.h,
              )),
        ),
        SizedBox(width: 12.w),
        InkWell(
          onTap: () {
            print("object");
          },
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(218, 175, 254, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(20)),
              width: 155.w,
              height: 24.h,
              padding: EdgeInsets.all(0),
              child: SvgPicture.asset(
                'assets/icons/groupIcon.svg',
                color: Colors.grey,
                width: 24.w,
                height: 12.h,
              )),
        ),
      ],
    );
  }
}
