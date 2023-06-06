import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/utils/time_converter.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
     this.senderId,
    required this.body,
    required this.type,
    required this.createAt,
    required this.isMyMessage,
    required this.isSameTime,
    required this.isSameDate,
    required this.isSamePerson,
  }) : super(key: key);

  final String body;
  final DateTime createAt;
  final String type;
  final int? senderId;
  final bool isMyMessage;
  final bool isSameTime;
  final bool isSameDate;
  final bool isSamePerson;

  @override
  Widget build(BuildContext context) {
    final _userId = Hive.box<User>('user').get('user')?.id;
    final _userProfileImg = Hive.box<User>('user').get('user')?.profileImg;

    List<String> reasonList = ["욕설/비방", "부적절 컨텐츠", "판매/사기"];

    bool isSameDate = true;

    return Column(
      crossAxisAlignment: senderId == _userId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isSameDate)
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0.h, top: 10.0.h),
              child: SizedBox(
                child: Text(
                  DateFormat('yyyy.MM.dd ${convertWeekDayToKorean(createAt.weekday)}').format(createAt),
                  style: CommonText.BodyMediumGray,
                ),
              ),
            ),
          ),
        if (senderId != _userId)
          Padding(
            padding: EdgeInsets.only(top: 10.0.h, bottom: 5.0.h),
            child: Row(
              mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14.0,
                  backgroundImage: NetworkImage(_userProfileImg!),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  body!,
                  style: CommonText.BodyM,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  body!,
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
                      convertTimeToKorean(createAt),
                      style: CommonText.Chip,
                    ),
                  ],
                ),
              ),
            InkWell(
              onLongPress: () {
                showModalBottomSheet(
                  enableDrag: false,
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
                          Text('${senderId}님을 신고하시겠습니까?'),
                          SizedBox(height: 5.h),
                          Divider(thickness: 1, color: Palette.candy),
                          SizedBox(height: 10.h),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              isDense: true,
                              constraints: BoxConstraints.tight(Size(150, 50)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Palette.main, width: 1)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Palette.main, width: 1)),
                              hintText: "신고 사유 선택",
                              hintStyle: CommonText.BodyMediumGray,
                              hintMaxLines: 1,
                              // border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
                            ),
                            alignment: Alignment.centerLeft,
                            items: reasonList
                                .map((e) => DropdownMenuItem(
                                    alignment: Alignment.center, child: Text(e, style: CommonText.BodyM), value: e))
                                .toList(),
                            onChanged: (value) {
                              // print(value);
                            },
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
                  body,
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
                  convertTimeToKorean(createAt),
                  style: CommonText.Chip,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
