import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:waggly/components/Post/post_app_bar.dart';
import 'package:waggly/components/chat/chat_bubble.dart';
import 'package:waggly/components/snackBar/custom_snack_bar.dart';
import 'package:waggly/controller/post/image_controller.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/chat/chat.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/utils/time_converter.dart';

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
    print(loginUser.id);
  }

  @override
  Widget build(BuildContext context) {
    const String _postName = "채팅방 상세";
    const Status _page = Status.chatRoom;
    ImageController _imageController = Get.put(ImageController());

    chatList.sort((a, b) => b.messageTime!.compareTo(a.messageTime!));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PostAppbar(
        postName: _postName,
        page: _page,
      ),
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
                                  print(isOverFlow);
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
                            print(chatList);
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
}
