import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_app_bar.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/chat/chat.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const int loginUserId = 1;
Chat chat1 = Chat(senderId: 1, message: "첫번째 메시지 입니다 하핳", messageTime: "12:13");
Chat chat2 = Chat(senderId: 2, message: "두번째", messageTime: "12:14");
List<Chat> chatList = [chat1, chat2];

class ChatRoomScreen extends StatefulWidget {
  ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final String _postName = "채팅방 상세";
  final Status _page = Status.chatRoom;
  bool isOverFlow = true;

  SignInController signInController = Get.put(SignInController());

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
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w),
            child: Column(
              children: [
                SizedBox(
                  height: 6.0.h,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        // height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Palette.lightGray),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0.w, right: 5.0.w, top: 5.0.h, bottom: 5.0.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.campaign,
                                color: Palette.mdGray,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                // color: Colors.red,
                                width: 208.w,
                                child: Text(
                                  "길어서 접혀야 하는데 잘 접히니 공지를",
                                  style: CommonText.BodyMediumGray,
                                  maxLines: isOverFlow == true ? 4 : 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_drop_down_sharp,
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
                SizedBox(height: 30),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10.0.w,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: chatList.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.candy,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                chatList[index].message!
                              ),
                            ),
                          ),
                        ],
                      );
                    },


                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
