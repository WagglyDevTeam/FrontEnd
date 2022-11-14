import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/header/page_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(),
      body: Container(
        child: Center(
          child: Text(
            'Hello ChatScreen',
            style: CommonText.BodyBoldMain,
          ),
        ),
      ),
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
