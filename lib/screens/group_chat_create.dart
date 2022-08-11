import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/controller/social_text_editing_controller.dart';
import 'package:get/get.dart';
import 'package:waggly/components/button/rules_button.dart';
import 'package:waggly/components/inputField/input_hashtag_field.dart';
import 'package:waggly/components/post/post_app_bar.dart';
import 'package:waggly/controller/group_chat_controller.dart';
import 'package:waggly/controller/post/post_controller.dart';
import 'package:waggly/components/inputField/input_title_field.dart';

import '../components/button/bottom_long_button.dart';

const double appBarHeight = 50.0;
const double dividerHeight = 16.0;
const double titleAreaHeight = 40.0;
const double hashtagAreaHeight = 40.0;
const double buttonAreaHeight = 40.0;
const double rulesButtonAreaHeight = 40.0;
const double selectAreaHeight = 60;

final List<String> categoryList = [
  "취업",
  "대외활동",
  "스터디",
  "자유•생활",
  "취미",
  "동아리",
];

final List<int> participantsNumberList
  = List<int>.generate(10, (i) => ((i+1) * 5));

class GroupChatCreatePage extends StatelessWidget {
  PostController postController = Get.put(PostController());
  GroupChatController groupChatController = Get.put(GroupChatController());
  final _title = TextEditingController();
  final _hashtag = SocialTextEditingController();

  @override
  Widget build(BuildContext context) {
    var page = Status.edit;
    const postName = "채팅방 만들기";
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    var emptySpaceHeight = screenHeight -
        appBarHeight -
        titleAreaHeight -
        hashtagAreaHeight -
        buttonAreaHeight -
        rulesButtonAreaHeight -
        (selectAreaHeight * 2) -
        (dividerHeight * 6);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PostAppbar(
        page: page,
        postName: postName,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: InputTitleField(
                    controller: _title,
                    hintText: "채팅방 제목",
                    height: titleAreaHeight,
                  ),
                ), // 제목 영역
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: InputHashtagField(
                    controller: _hashtag,
                    hintText: "#해시태그를 이용하여 채팅방을 소개해주세요.",
                    height: hashtagAreaHeight,
                  ),
                ), // 해시태그 영역
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: SizedBox(
                    height: selectAreaHeight,
                    child: SelectAreaBox(
                      controller: groupChatController,
                      text: "카테고리 선택",
                      itemList: categoryList,
                      flagIndex: groupChatController.selectedCategoryIndex,
                    ),
                  ),
                ), // 카테고리 선택 영역
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                  child: SizedBox(
                    height: selectAreaHeight,
                    child: SelectAreaBox(
                      controller: groupChatController,
                      text: "참여 인원",
                      itemList: participantsNumberList,
                      flagIndex: groupChatController.selectedParticipantsNumberIndex,
                    ),
                  ),
                ), // 참여 인원 선택 영역
                Divider(),
                SizedBox(height: emptySpaceHeight),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30),
                  child: Container(
                    height: rulesButtonAreaHeight,
                    alignment: Alignment.centerRight,
                    child: RulesButton(
                      text: "채팅방 생성 가이드 전체 보기",
                    ),
                  ),
                ), // 채팅방 생성 가이드 보기
                Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: BottomLongButton(
                    text: "채팅방 생성하기",
                    height: buttonAreaHeight,
                    onPressed: () {},
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
    required this.text, required this.itemList, required this.flagIndex,
  }) : super(key: key);


  final String text;
  final controller;
  final itemList;
  final flagIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0),
        SelectButton(
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
    this.itemList,
  }) : super(key: key);

  final itemList;
  final controller;
  final RxInt flagIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 7.0);
          },
          scrollDirection: Axis.horizontal,
          itemCount: itemList.length,
          itemBuilder: (ctx, index) {
            return Obx(
              () => InkWell(
                onTap: () {
                  flagIndex.value = index;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color:
                        flagIndex.value == index ? Colors.purple : Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    itemList[index].toString(),
                    style: TextStyle(
                        color: flagIndex.value == index ? Colors.white : Color(0xFFB6B6B6),
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
