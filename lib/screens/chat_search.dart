import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/components/post/post_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/controller/chat_search_controller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

List<dynamic> groupChatItem = [
  {"a": "b"},
  {"c": "d"},
  {"e": "f"},
  {"g": "h"},
  {"i", "j"}
];

class ChatSearchScreen extends StatelessWidget {
  final String _postName = "채팅 검색";
  final Status _page = Status.editAlarmOnly;
  final _searchKeyword = TextEditingController();
  final ChatSearchController chatSearchController = Get.put(ChatSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PostAppbar(
        postName: _postName,
        page: _page,
      ),
      body: Column(
        children: [
          SizedBox(height: 5.0.h),
          Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 15.0.w),
            child: Row(
              children: [
                SizedBox(
                  width: 278.0.w,
                  height: 36.0.h,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: CommonText.BodyM,
                    controller: _searchKeyword,
                    maxLines: 1,
                    onEditingComplete: () {},
                    autocorrect: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 20.0.w,
                        right: 20.0.w,
                        bottom: 36.0.h / 2, // Vertical Center
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Color(0xFFF8F8F8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: InkWell(
                    onTap: () {
                      // 알림 페이지로 이동
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 36.0.w,
                      height: 36.0.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Palette.lightGray),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Palette.gray,
                        size: 18.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ), // 검색영역
          SizedBox(height: 24.0.h),
          SizedBox(
            height: 65.h,
            child: SearchHistoryItemsBox(
              controller: chatSearchController,
              text: "최근 검색어",
              itemList: chatSearchController.searchHistory,
            ),
          ), // 최근 검색어
          SizedBox(height: 24.0.h),
          SizedBox(
            height: 110.h,
            child: GroupChatBoxArea(
              text: "신규 채팅방을 확인해보세요!",
              itemList: groupChatItem,
            ),
          ), // 신규 채팅방
        ],
      ),
    );
  }
}

class SearchHistoryItemsBox extends StatelessWidget {
  const SearchHistoryItemsBox({
    Key? key,
    required this.text,
    required this.itemList,
    required this.controller,
  }) : super(key: key);

  final String text;
  final itemList;
  final ChatSearchController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: CommonText.TitleS,
            ),
          ),
        ), // 타이틀
        SizedBox(height: 10.0.h),
        Obx(
          // 검색 내역 존재하지 않을 경우 메시지 출력
          () => controller.searchHistory.isEmpty == true
              ? Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 24.0.h,
                    child: Text("검색 내역이 존재하지 않습니다.", style: CommonText.BodyMediumGray,),
                  ),
              )
              : SizedBox(
                  height: 24.h,
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 7.0.h);
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: itemList.length,
                      itemBuilder: (ctx, index) {
                        return Row(
                          children: [
                            if (index == 0) SizedBox(width: 20.0.w),
                            Container(
                              alignment: AlignmentDirectional(0.w, -0.2.h),
                              height: 24.0.h,
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                              decoration: BoxDecoration(
                                color: Palette.candy,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    itemList[index],
                                    style: CommonText.BodyM,
                                  ),
                                  SizedBox(
                                    width: 4.0.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.searchHistory.removeAt(index);
                                      print(controller.searchHistory.isEmpty);
                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional(0.w, 0.15.h),
                                      child: Icon(Icons.close, size: 10.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index == itemList.length - 1) SizedBox(width: 20.0.w),
                          ],
                        );
                      }),
                ),
        ),
      ],
    );
  }
}

class GroupChatBoxArea extends StatelessWidget {
  const GroupChatBoxArea({
    Key? key,
    required this.text,
    required this.itemList,
  }) : super(key: key);

  final String text;
  final itemList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: CommonText.TitleS,
            ),
          ),
        ),
        SizedBox(height: 10.0.h),
        SizedBox(
          height: 72.h,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 7.0.h);
              },
              scrollDirection: Axis.horizontal,
              itemCount: itemList.length,
              itemBuilder: (ctx, index) {
                return Row(
                  children: [
                    if (index == 0) SizedBox(width: 20.0.w),
                    Container(
                      height: 85.0.h,
                      width: 217.0.w,
                      padding: EdgeInsets.all(12.5.r),
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          width: 0.7,
                          color: Palette.lavender,
                        ),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 48.0.w,
                                height: 48.0.h,
                                child: CircleAvatar(
                                  radius: 30.0,
                                  foregroundImage: AssetImage("assets/images/red_face_big.png"),
                                ),
                              ),
                              Positioned(
                                top: 22.5.h,
                                child: Center(
                                  child: Text(
                                    "99/99",
                                    style: CommonText.BodyEngWhite,
                                  ),
                                ),
                              ),
                            ],
                          ), // 참여자 수 얼굴
                          SizedBox(width: 7.w),
                          SizedBox(
                            width: 135.5.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(5.0.w, 3.0.h, 5.0.w, 3.0.h),
                                      height: 14.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Palette.main,
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        "대외활동",
                                        style: CommonText.ChipWhite,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "와글와글 채팅방 이름?이름이름이름",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: CommonText.BodyL,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Text(
                                      "#도전",
                                      style: CommonText.BodyXSmallMain,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      "#취직",
                                      style: CommonText.BodyXSmallMain,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      "#파이팅",
                                      style: CommonText.BodyXSmallMain,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ), // 카테고리, 채팅방이름
                        ],
                      ),
                    ),
                    if (index == groupChatItem.length - 1) SizedBox(width: 20.0.w),
                  ],
                );
              }),
        ),
        SizedBox(height: 10.0.h),
      ],
    );
  }
}
