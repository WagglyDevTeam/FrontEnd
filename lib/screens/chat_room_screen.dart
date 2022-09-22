import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/components/Post/post_app_bar.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomScreen extends StatelessWidget {
  final String _postName = "채팅방 상세";
  final Status _page = Status.chatRoom;

  ChatRoomScreen({Key? key}) : super(key: key);
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
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Palette.lightGray),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.campaign,
                                color: Palette.mdGray,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                child: Container(
                                  child: Text(
                                    "길어서 접혀야 하는데 잘 접히니 공지를 등록하여 소통할 수 있습니다. (80자 이내)",
                                    style: CommonText.BodyMediumGray,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0.w),
                      child: Stack(
                        children: [
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
                        ]
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Hello ChatScreen',
                      style: CommonText.BodyBoldMain,
                    ),
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
