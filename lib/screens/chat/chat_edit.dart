import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/utils/text_frame.dart';
import '../../components/chatEdit/chat_edit_body.dart';
import '../../components/chatEdit/chat_edit_step.dart';
import '../../controller/chatEdit/chat_edit_controller.dart';
import '../../utils/colors.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatEditScreen extends StatelessWidget {
  const ChatEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatEditController controller = Get.put(ChatEditController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: TopAppBar(),
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

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(68.h);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text('채팅', style: CommonText.TitleL),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16.0.w, top: 7.0.h),
              padding: EdgeInsets.all(10.0.r),
              width: 155.0.w,
              height: 36.0.h,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(40.0) // POINT
                ),
                border: Border.all(width: 1.0, color: Palette.lightGray),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ActionButton(
                      event: () {
                        Get.toNamed("/chatCreate");
                      },
                      isIcon: Icon(
                        Icons.add,
                        color: Palette.gray,
                        size: 18.w,
                      )),
                  line(),
                  ActionButton(
                      event: () => Get.toNamed("/chatSearch"),
                      isIcon: Icon(
                        Icons.search,
                        color: Palette.gray,
                        size: 18.w,
                      )),
                  line(),
                  ActionButton(
                      event: () async {
                        // 알림 페이지로 이동
                        await Get.put(NotificationController())
                            .getNotification();
                        Get.toNamed('/notification');
                      },
                      isIcon: Icon(
                        Icons.notifications_none,
                        color: Palette.gray,
                        size: 18.w,
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

line() {
  return const SizedBox(
    width: 1,
    height: 10,
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            // POINT
            color: Palette.lightGray,
            width: 1.0,
          ),
        ),
      ),
    ),
  );
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
                    color: selectType == "일대일" ? Color(0xff959595) : Color(0xffFFFFFF),
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
