import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:get/get.dart';
import 'package:waggly/components/button/rules_button.dart';
import 'package:waggly/components/inputField/input_hashtag_field.dart';
import 'package:waggly/components/post/post_app_bar.dart';
import 'package:waggly/controller/group_chat_controller.dart';
import 'package:waggly/controller/post/post_controller.dart';
import 'package:waggly/components/inputField/input_title_field.dart';
import 'package:waggly/components/button/bottom_long_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';

final List<String> categoryList = [
  "취업",
  "대외활동",
  "스터디",
  "자유•생활",
  "취미",
  "동아리",
];

final List<int> participantsNumberList =
    List<int>.generate(10, (i) => ((i + 1) * 5));

const double dividerHeight = 16.0;
const double titleAreaHeight = 40.0;
const double hashtagAreaHeight = 40.0;
const double buttonAreaHeight = 41.0;
const double rulesButtonAreaHeight = 40.0;
const double selectAreaHeight = 60;
const double bottomButtonPaddingTop = 20.0;
const double bottomButtonPaddingBottom = 15.0;

class GroupChatCreatePage extends StatelessWidget {
  PostController postController = Get.put(PostController());
  GroupChatController groupChatController = Get.put(GroupChatController());
  final _title = TextEditingController();
  final _hashtag = SocialTextEditingController();

  void buttonActivateCheck() {
    if (_title.text.isBlank == true ||
        _hashtag.text.isBlank == true ||
        groupChatController.selectedCategoryIndex.value == 999 ||
        groupChatController.selectedParticipantsNumberIndex.value == 999) {
      groupChatController.isButtonActivate.value = false;
      print("title is blank ${_title.text.isBlank}, ${_title.text}");
      print("hashtag is blank ${_hashtag.text.isBlank}");
    } else {
      groupChatController.isButtonActivate.value = true;
    }
    print("title is blank ${_title.text.isBlank}");
    print("hashtag is blank ${_hashtag.text.isBlank}");
  }

  @override
  Widget build(BuildContext context) {
    var os = Platform.operatingSystem;
    var page = Status.edit;
    const postName = "채팅방 만들기";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PostAppbar(
        page: page,
        postName: postName,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: dividerHeight.h),
                SizedBox(
                  height: titleAreaHeight,
                  child: InputTitleField(
                    onEditingComplete: buttonActivateCheck,
                    controller: _title,
                    hintText: "채팅방 제목",
                    // height: titleAreaHeight.h,
                  ),
                ), // 제목 영역
                Divider(height: dividerHeight.h),
                SizedBox(
                  height: hashtagAreaHeight.h,
                  child: InputHashtagField(
                    onEditingComplete: buttonActivateCheck,
                    controller: _hashtag,
                    hintText: "#해시태그를 이용하여 채팅방을 소개해주세요.",
                    // height: hashtagAreaHeight.h,
                  ),
                ), // 해시태그 영역
                Divider(height: dividerHeight.h),
                Padding(
                  padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                  child: SizedBox(
                    height: selectAreaHeight.h,
                    child: SelectAreaBox(
                      onTap: buttonActivateCheck,
                      controller: groupChatController,
                      text: "카테고리 선택",
                      itemList: categoryList,
                      flagIndex: groupChatController.selectedCategoryIndex,
                    ),
                  ),
                ), // 카테고리 선택 영역
                Divider(height: dividerHeight.h),
                Padding(
                  padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                  child: SizedBox(
                    height: selectAreaHeight.h,
                    child: SelectAreaBox(
                      onTap: buttonActivateCheck,
                      controller: groupChatController,
                      text: "참여 인원",
                      itemList: participantsNumberList,
                      flagIndex:
                          groupChatController.selectedParticipantsNumberIndex,
                    ),
                  ),
                ), // 참여 인원 선택 영역
                Divider(height: dividerHeight.h),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Container(
                    height: rulesButtonAreaHeight.h,
                    alignment: Alignment.centerRight,
                    child: RulesButton(
                      text: "채팅방 생성 가이드 전체보기",
                    ),
                  ),
                ), // 채팅방 생성 가이드 보기
                Divider(height: dividerHeight.h),
                Padding(
                  padding: EdgeInsets.only(
                    top: bottomButtonPaddingTop.h,
                    bottom: os == "ios" ? 0.0 : bottomButtonPaddingBottom.h,
                  ),
                  child: BottomLongButton(
                    controller: groupChatController,
                    text: "채팅방 생성하기",
                    height: buttonAreaHeight.h,
                    onPressed: () {
                      print(groupChatController.isButtonActivate.value);
                    },
                  ),
                ), // 채팅방 생성하기 버튼
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectAreaBox extends StatelessWidget {
  const SelectAreaBox({
    Key? key,
    required this.controller,
    required this.text,
    required this.itemList,
    required this.flagIndex, this.onTap,
  }) : super(key: key);

  final String text;
  final controller;
  final itemList;
  final flagIndex;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: CommonText.BodyM,
          ),
        ),
        SizedBox(height: 10.0.h),
        SelectButton(
          onTap: onTap,
          itemList: itemList,
          controller: controller,
          flagIndex: flagIndex,
        ),
      ],
    );
  }
}

class SelectButton extends StatelessWidget {
  const SelectButton({
    Key? key,
    required this.controller,
    required this.flagIndex,
    this.itemList, this.onTap,
  }) : super(key: key);

  final itemList;
  final controller;
  final RxInt flagIndex;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 24.h,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 7.0.h);
          },
          scrollDirection: Axis.horizontal,
          itemCount: itemList.length,
          itemBuilder: (ctx, index) {
            return Obx(
              () => InkWell(
                onTap: () {
                  flagIndex.value = index;
                  onTap();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: flagIndex.value == index
                        ? Palette.main
                        : Palette.paper,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    itemList[index].toString(),
                    style: CommonText.BodyM.copyWith(
                      color: flagIndex.value == index
                          ? Colors.white
                          : Palette.data,
                    )

                    // TextStyle(
                    //     color: flagIndex.value == index
                    //         ? Colors.white
                    //         : Palette.data,
                    //     fontSize: 13.0,
                    //     fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
