import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/utils/time_converter.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMyMessage,
    required this.isSameTime,
    required this.isSamePerson,
    required this.user,
    required this.datetime,
    required this.isSameDate,
  }) : super(key: key);

  final String message;
  final DateTime datetime;
  final bool isMyMessage;
  final bool isSameTime;
  final bool isSamePerson;
  final bool isSameDate;
  final User user;

  @override
  Widget build(BuildContext context) {
    List<String> reasonList = ["욕설/비방", "부적절 컨텐츠", "판매/사기"];

    return Column(
      crossAxisAlignment: isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isSameDate)
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0.h, top: 10.0.h),
              child: SizedBox(
                child: Text(
                  DateFormat('yyyy.MM.dd ${convertWeekDayToKorean(datetime.weekday)}').format(datetime),
                  style: CommonText.BodyMediumGray,
                ),
              ),
            ),
          ),
        if (!isSamePerson && !isMyMessage)
          Padding(
            padding: EdgeInsets.only(top: 10.0.h, bottom: 5.0.h),
            child: Row(
              mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14.0,
                  backgroundImage: NetworkImage(user.profileImg!),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  user.nickName!,
                  style: CommonText.BodyM,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  user.major!,
                  style: CommonText.BodyMediumGray,
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: isMyMessage == true ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isMyMessage && !isSameTime)
              Padding(
                padding: EdgeInsets.only(right: 7.0.w, bottom: 3.0.h),
                child: Column(
                  children: [
                    Text(
                      convertTimeToKorean(datetime),
                      style: CommonText.Chip,
                    ),
                  ],
                ),
              ),
            InkWell(
              // onLongPress: () {
              onTap: () {
                print("확인");
                showModalBottomSheet(
                  //드래그 안되게~
                  enableDrag: false,
                  //modal 위치 외에 클릭 안되게 하는것
                  isDismissible: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: ((context) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${user.nickName}님을 신고하시겠습니까?'),
                          SizedBox(height: 5.h),
                          Divider(thickness: 1, color: Palette.candy),
                          SizedBox(height: 10.h),
                          Container(
                            alignment: Alignment.center,
                            width: 120,
                            child: DropdownButtonFormField(
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              // ),
                              hint: Center(child: Text("신고 사유 선택")),
                              items: reasonList.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                              onChanged: (value){
                                print(value);
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0.w, right: 5.0.w),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 28.0.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      color: Palette.candy,
                                    ),
                                    child: Text(
                                      "취소하기",
                                      style: CommonText.BodyM,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0.w, left: 5.0.w),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 28.0.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      color: Palette.candy,
                                    ),
                                    child: Text(
                                      "신고하기",
                                      style: CommonText.BodyM,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  }),
                );
              },
              child: Container(
                constraints: BoxConstraints(maxWidth: 200.w),
                decoration: BoxDecoration(
                  color: isMyMessage ? Palette.main : Palette.paper,
                  borderRadius: BorderRadius.circular(20),
                ),
                // width: 200.w,
                padding: EdgeInsets.fromLTRB(16.0.w, 10.0.h, 16.0.w, 10.0.h),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isMyMessage ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            if (!isMyMessage && !isSameTime)
              Padding(
                padding: EdgeInsets.only(left: 7.0.w, bottom: 3.0.h),
                child: Text(
                  convertTimeToKorean(datetime),
                  style: CommonText.Chip,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
