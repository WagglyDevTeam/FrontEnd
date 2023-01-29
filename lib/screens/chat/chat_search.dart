import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/hive/search_history.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:waggly/controller/chat/chat_search_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
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
  final _searchKeyword = TextEditingController();
  final ChatSearchController chatSearchController = Get.put(ChatSearchController());
  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<User>('user');
    var userId = box.get('user')?.id;
    chatSearchController.toList(userId!);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: Column(
        children: [
          SizedBox(height: 5.0.h),
          Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 15.0.w),
            child: Row(
              children: [
                SizedBox(
                  width: 250.0.w,
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
                        left: 10.0.w,
                        right: 20.0.w,
                        bottom: 36.0.h / 2, // Vertical Center
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "채팅,학과 검색",
                      hintStyle: CommonText.BodyMediumGray,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.lavender, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.lavender,width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () async {
                    final searchList = chatSearchController.searchHistoryBox.value;

                    if (_searchKeyword.text.isEmpty) {
                      CustomSnackBar.messageSnackbar(
                        context,
                        "검색어를 입력해주세요.",
                        EdgeInsets.only(bottom: 60.h, left: 20.w, right: 20.w),
                      );
                    } else {
                      int id = 0;
                      if (chatSearchController.historyList.isNotEmpty == true) {
                        final prevItem = searchList.getAt(searchList.length - 1);
                        id = prevItem!.id + 1;
                      }

                      chatSearchController.searchHistoryBox.value
                          .add(SearchHistory(id: id, userId: userId, keyword: _searchKeyword.text));
                      chatSearchController.toList(userId);

                      _searchKeyword.text = '';
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 70.0.w,
                      height: 36.0.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Palette.violet),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("검색하기", style: TextStyle(fontSize: 12.0.sp,
                        color: Palette.violet,
                        fontFamily: 'NotoSansKR_Md',),),
                  ),
                ),
              ],
            ),
          ), // 검색영역
          SizedBox(height: 24.0.h),
          SizedBox(
            height: 65.h,
            child: SearchHistoryItemsBox(
              text: "최근 검색어",
              itemList: chatSearchController.historyList,
              // itemList: chatSearchController.getHistoryList(userId),
            ),
          ), // 최근 검색어
          SizedBox(height: 24.0.h),
          SizedBox(
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
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("채팅 검색", style: CommonText.BodyL))
            ],
          ),
          actions: [
              InkWell(
                onTap: () async {
                  // 알림 페이지로 이동
                  await Get.put(NotificationController()).getNotification();
                  Get.toNamed('/notification');
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 16.0.w),
                  width: 36.0.w,
                  height: 36.0.h,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Palette.lightGray),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Palette.gray,
                        size: 18.r,
                      ),
                      Positioned(
                        top: 1.6.h,
                        left: 11.w,
                        // right: -20,
                        child: Container(
                          width: 6.0.w,
                          height: 6.0.h,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5.w, color: Colors.white),
                            color: Color(0xFFFF5F5F),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class SearchHistoryItemsBox extends StatelessWidget {
  SearchHistoryItemsBox({
    Key? key,
    required this.text,
    required this.itemList,
  }) : super(key: key);

  final String text;
  final itemList;
  SignInController signInController = Get.find();
  ChatSearchController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    int? userId = Hive.box<User>('user').get('user')?.id;

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
        // 검색 내역 존재하지 않을 경우 메시지 출력
        Obx(
          () => itemList.isEmpty == true
              ? Padding(
                  padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 24.0.h,
                    child: Text(
                      "검색 내역이 존재하지 않습니다.",
                      style: CommonText.BodyMediumGray,
                    ),
                  ),
                )
              : SizedBox(
                  height: 24.0.h,
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
                                    // controller.searchHistory.removeAt(index);
                                    controller.deleteSearchHistory(index);
                                    controller.toList(userId!);
                                    // print(controller.searchHistory.isEmpty);
                                  },
                                  child: Container(
                                    alignment: AlignmentDirectional(0.w, 0.15.h),
                                    child: Icon(Icons.close, size: 10.w),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index == itemList.length - 1) SizedBox(width: 20.0.w),
                        ],
                      );
                    },
                  ),
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
          padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w),
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
          height: MediaQuery.of(context).size.height - 300.h,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: itemList.length,
              itemBuilder: (ctx, index) {
                return Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.w, 12.5.h, 20.w, 12.5.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.w,
                            color: Palette.paper,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
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
                                width: MediaQuery.of(context).size.width - 165.w,
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
                              ),
                              SizedBox(width: 20.w,),
                              Stack(
                                children: [
                                  Container(
                                    width: 36.0.w,
                                    height: 36.0.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.5.w,
                                        color: Palette.light,
                                      ),
                                      borderRadius: BorderRadius.circular(100.0.w),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.w,
                                    top: 10.h,
                                    child: SizedBox(
                                      width: 16.0.w,
                                      height: 16.0.h,
                                      child: SvgPicture.asset(
                                        'assets/icons/play.svg',
                                        color: Palette.iris,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                             // 카테고리, 채팅방이름
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
