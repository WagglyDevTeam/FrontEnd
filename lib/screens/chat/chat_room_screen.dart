import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:waggly/components/chat/chat_bubble.dart';
import 'package:waggly/hive/user.dart';
import 'package:waggly/widgets/snackbar/custom_snack_bar.dart';
import 'package:waggly/controller/post/image_controller.dart';
import 'package:waggly/model/chat/chat.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/widgets/header/page_appbar.dart';

Chat chat1 = Chat(senderId: 1, message: "잘 가는거 맞나여", messageTime: DateTime(2022, 1, 2, 12, 34, 01));
Chat chat2 = Chat(senderId: 1, message: "두번째 메시지 잘 가나여 유저1", messageTime: DateTime(2022, 1, 2, 12, 34, 02));
Chat chat3 = Chat(senderId: 25, message: "유저2 메시지 첫번째", messageTime: DateTime(2022, 1, 2, 12, 34, 03));
Chat chat4 = Chat(senderId: 25, message: "시간 잘 뜨나요?", messageTime: DateTime(2022, 1, 2, 12, 34, 04));
Chat chat5 = Chat(senderId: 25, message: "잘 없어지나요 시간?", messageTime: DateTime(2022, 1, 2, 12, 35, 05));
Chat chat6 =
    Chat(senderId: 25, message: "테스트트테스트트 긴 텍스트 테스트트트트 너비 잘 나오나 테스트트트?", messageTime: DateTime(2022, 1, 2, 12, 36, 06));
Chat chat7 = Chat(senderId: 1, message: "이제 그만 보내", messageTime: DateTime(2022, 1, 2, 12, 37, 07));
Chat chat8 = Chat(senderId: 1, message: "그만 보내라고", messageTime: DateTime(2022, 1, 2, 12, 37, 08));
Chat chat9 = Chat(senderId: 25, message: "알았써 ð", messageTime: DateTime(2022, 1, 2, 12, 38, 56));
User user1 = User(
    id: 1,
    nickName: "유저1",
    university: "가나다대학교",
    classNumber: 22,
    major: "소맥황금비율학과",
    profileImg: "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/08fdac1f-1577-486b-84e7-06d235cdd3eb.png");
User user2 = User(
    id: 25,
    nickName: "유저2",
    university: "가나다대학교",
    classNumber: 22,
    major: "주정차단속학과",
    profileImg: "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/cfa56b43-a2c3-45b7-ae3b-9f5be44f1692.png");

List<Chat> chatList = [];
List<User> participantList = [];

TextEditingController _chatMessageController = TextEditingController();
User loginUser = Hive.box<User>('user').get('user')!;
bool isOverFlow = false;
int selectedUserId = 0;

List<String> imageUrlList = [
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/ff74a528-33d1-4119-8123-ddb81f9ead02.jpg",
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/f36e6b05-70e3-4ead-80e5-c7e719bd09d3.jpeg",
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/d999b74b-61e6-4c19-b82d-986341dfaa44.png",
  "https://thandbag.s3.ap-northeast-2.amazonaws.com/waggly/cfa56b43-a2c3-45b7-ae3b-9f5be44f1692.png",
];

class ChatRoomScreen extends StatefulWidget {
  ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  initState() {
    super.initState();
    chatList = [chat1, chat2, chat3, chat4, chat5, chat6, chat7, chat8, chat9];
    participantList = [user1, user2];
    // print(loginUser.id);
  }

  @override
  Widget build(BuildContext context) {
    const String _pageTitle = "채팅방 상세";
    const Status _page = Status.chatRoom;
    ImageController _imageController = Get.put(ImageController());

    chatList.sort((a, b) => b.messageTime!.compareTo(a.messageTime!));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageAppbar(
        pageTitle: _pageTitle,
        page: _page,
      ),
      endDrawer: endDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Divider(),
            SizedBox(
              height: 5.0.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 70.h),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Palette.lightGray),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0.w, right: 5.0.w, top: 5.0.h, bottom: 5.0.h),
                        child: Row(
                          children: [
                            // Icon(
                            //   Icons.campaign,
                            //   color: Palette.mdGray,
                            // ),
                            SvgPicture.asset(
                              'assets/icons/speaker.svg',
                              fit: BoxFit.contain,
                              width: 17.w,
                              height: 17.h,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Flexible(
                              child: SizedBox(
                                child: Text(
                                  "길어서 접혀야 하는데 잘 접히니 공지를 더 써보면 늘어나야 되는데 화면은 어떻게 되는걸까",
                                  style: CommonText.BodyMediumGray,
                                  maxLines: isOverFlow ? 4 : 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.0.w,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  // TODO:59 overflow인지 아닌지 판단할 수 있는 기준이 뭐가 있을까?
                                  isOverFlow = !isOverFlow;
                                  // print(isOverFlow);
                                });
                              },
                              child: Icon(
                                size: 20,
                                isOverFlow ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
                                color: Palette.mdGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: Stack(children: [
                      Container(
                        // color: Colors.red,
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1.0, color: Palette.lightGray),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Positioned(
                        left: 8.w,
                        top: 8.h,
                        child: Container(
                          width: 14.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w),
                child: SizedBox(
                  // constraints: BoxConstraints(maxHeight: 400.0.h),
                  // height: 300.0.h,
                  child: ListView.separated(
                    reverse: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10.0.w,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: chatList.length,
                    itemBuilder: (ctx, index) {
                      if (chatList.isEmpty) {
                        return Container();
                      }
                      if (index == chatList.length - 1) {
                        // 첫번째 메시지 일 경우
                        return Column(
                          children: [
                            ChatBubble(
                              user: participantList.where((element) => element.id == chatList[index].senderId).first,
                              message: "${chatList[index].message!} : $index",
                              datetime: chatList[index].messageTime!,
                              isMyMessage: loginUser.id == chatList[index].senderId,
                              isSameTime: chatList[index].senderId == chatList[index - 1].senderId &&
                                  DateFormat('MM/dd HH:mm').format(chatList[index].messageTime!) ==
                                      DateFormat('MM/dd HH:mm').format(chatList[index - 1].messageTime!),
                              isSamePerson: false,
                              isSameDate: false,
                            ),
                          ],
                        );
                      } else if (index == 0) {
                        // 마지막 메시지 일 경우
                        return Column(
                          children: [
                            ChatBubble(
                              user: participantList.where((element) => element.id == chatList[index].senderId).first,
                              message: "${chatList[index].message!} : $index",
                              datetime: chatList[index].messageTime!,
                              isMyMessage: loginUser.id == chatList[index].senderId,
                              isSameTime: false,
                              isSamePerson: chatList[index].senderId == chatList[index + 1].senderId,
                              isSameDate:
                                  chatList[index].messageTime!.weekday == chatList[index + 1].messageTime!.weekday,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            ChatBubble(
                              user: participantList.where((element) => element.id == chatList[index].senderId).first,
                              message: "${chatList[index].message!} : $index",
                              datetime: chatList[index].messageTime!,
                              isMyMessage: loginUser.id == chatList[index].senderId,
                              isSameTime: chatList[index].senderId == chatList[index - 1].senderId &&
                                  DateFormat('MM/dd HH:mm').format(chatList[index].messageTime!) ==
                                      DateFormat('MM/dd HH:mm').format(chatList[index - 1].messageTime!),
                              isSamePerson: chatList[index].senderId == chatList[index + 1].senderId,
                              isSameDate:
                                  chatList[index].messageTime!.weekday == chatList[index + 1].messageTime!.weekday,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w, top: 15.0.h),
              child: SizedBox(
                height: 40.0.h,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0.w),
                      child: InkWell(
                        onTap: () async {
                          await _imageController.uploadSingleImage();
                        },
                        child: Container(
                          height: 30.0.h,
                          width: 30.0.h,
                          decoration: BoxDecoration(
                            color: Palette.main,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            size: 20.0.h,
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _chatMessageController,
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
                    Padding(
                      padding: EdgeInsets.only(left: 10.0.w),
                      child: InkWell(
                        onTap: () {
                          if (_chatMessageController.text.isEmpty) {
                            CustomSnackBar.messageSnackbar(
                              context,
                              "메시지를 입력해주세요.",
                              EdgeInsets.only(bottom: 45.h, left: 20.w, right: 20.w),
                            );
                          } else {
                            // print(chatList);
                            Chat newChat = Chat(
                              senderId: loginUser.id,
                              message: _chatMessageController.text,
                              messageTime: DateTime.now(),
                            );
                            setState(() {
                              chatList.add(newChat);
                            });
                            _chatMessageController.text = '';
                          }
                        },
                        child: Container(
                          height: 30.0.h,
                          width: 30.0.h,
                          decoration: BoxDecoration(
                            color: Palette.main,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            size: 18.0.h,
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SafeArea endDrawer() {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
          ),
          child: Drawer(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(top: 20.0.h, bottom: 20.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h),
                    child: SizedBox(
                      height: 30.0.h,
                      child: Text("앨범", style: CommonText.BodyL),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0.h, left: 20.0.h, right: 20.0.h),
                      child: GridView.builder(
                        itemCount: imageUrlList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                          // childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
                          mainAxisSpacing: 7, //수평 Padding
                          crossAxisSpacing: 7, //수직 Padding
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                imageUrlList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h),
                    child: SizedBox(
                      height: 30.0.h,
                      child: Text("대화 참여자", style: CommonText.BodyL),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: participantList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (selectedUserId == 0) {
                                      selectedUserId = participantList[index].id!;
                                    } else {
                                      if (selectedUserId == participantList[index].id!) {
                                        selectedUserId = 0;
                                      } else {
                                        selectedUserId = participantList[index].id!;
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 3.0.h, bottom: 3.0.h),
                                  color: participantList[index].id! == selectedUserId ? Palette.paper : Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 5.0.h),
                                          child: CircleAvatar(
                                            radius: 14.0,
                                            backgroundImage: NetworkImage(participantList[index].profileImg!),
                                          ),
                                        ),
                                        Text(
                                          participantList[index].nickName!,
                                          style: CommonText.BodyM,
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              participantList[index].major!,
                                              style: CommonText.BodyXSmallGray,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (participantList[index].id! == selectedUserId)
                                Padding(
                                  padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h, left: 20.0.h, right: 20.0.h),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 28.0.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffDAAFFE)),
                                      borderRadius: BorderRadius.circular(26),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      "채팅요청",
                                      style: CommonText.BodyM,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    height: 50.0.h,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Palette.paper),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0.h, right: 20.0.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Palette.gray,
                          ),
                          SizedBox(width: 10.0.w),
                          SvgPicture.asset(
                            'assets/icons/pin.svg',
                            color: Palette.gray,
                            width: 15.0.w,
                            height: 15.0.h,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                'assets/icons/exit.svg',
                                color: Palette.gray,
                                width: 15.0.w,
                                height: 15.0.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
