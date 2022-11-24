import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: myNotification(),
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Palette.lightGray),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Palette.gray,
                    iconSize: 20.0.sp,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("알림", style: CommonText.BodyL))
            ],
          ),
        ),
      ],
    );
  }
}

class myNotification extends StatelessWidget {
  NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            //편집하기,삭제하기 버튼
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //전체 선택 체크박스
                    controller.isEdit.value
                        ? Container(
                            padding: EdgeInsets.only(top: 10.h, left: 12.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12.w,
                                  height: 12.h,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      value: controller.isAllChecked.value,
                                      onChanged: (value) {
                                        controller.changeIsAllChecked(value,
                                            controller.notificationData.length);
                                      },
                                      activeColor: Palette.main,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  '전체선택',
                                  style: CommonText.BodyXS,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      width: 66.0.w,
                      height: 22.0.h,
                      margin: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: ElevatedButton(
                        child: Text(
                          controller.isEdit.value ? "삭제하기" : "편집하기",
                          style: CommonText.BodyXS,
                        ),
                        onPressed: () {
                          controller.isEdit.value = !controller.isEdit.value;
                          controller.isCheckedId.value = [];
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Palette.candy,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 10.h),
            Divider(thickness: 1, height: 1, color: Palette.paper),
            Obx(
              () => ListView(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  ...controller.notificationData
                      .map(
                        (item) => ListTile(
                          title: Column(
                            children: [
                              Row(
                                children: [
                                  controller.isEdit.value
                                      ? SizedBox(
                                          width: 12.w,
                                          height: 12.h,
                                          child: Transform.scale(
                                            scale: 0.8,
                                            child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              value: controller
                                                      .isCheckedId.value
                                                      .contains(item.alarmId)
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                controller.changeIsChecked(
                                                    value, item.alarmId);
                                              },
                                              activeColor: Palette.main,
                                            ),
                                          ),
                                        )
                                      : SizedBox(width: 0),
                                  SizedBox(width: 5.w),
                                  Container(
                                    height: 28.h,
                                    width: 28.w,
                                    margin: EdgeInsets.only(
                                        right: 10, left: 5, top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            (item.alarmType == 'chatting')
                                                ? 'assets/images/green.png'
                                                : 'assets/images/red.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: controller.isEdit.value
                                        ? MediaQuery.of(context).size.width -
                                            100.w
                                        : MediaQuery.of(context).size.width -
                                            110.w,
                                    child: Text(item.alarmMsg,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xff47505F),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ),
                                  if (!controller.isEdit.value)
                                    Text(
                                      item.time,
                                      style: CommonText.LabelGray,
                                    ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Divider(
                                  thickness: 1,
                                  height: 1,
                                  color: Palette.paper),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
