import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:waggly/components/myPage/active/request_list.dart';
import 'package:waggly/controller/myPage/my_comment_list_controller.dart';
import 'package:waggly/controller/myPage/my_post_list_controller.dart';
import 'package:waggly/widgets/index.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/utils/colors.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: activeContent(),
    );
  }
}

class activeContent extends StatefulWidget {
  const activeContent({Key? key}) : super(key: key);

  @override
  _activeContentState createState() => _activeContentState();
}

class _activeContentState extends State<activeContent> {
  bool isToggled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    margin: EdgeInsets.only(top: 20, right: 10, left: 16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Palette.lightGray),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Palette.gray,
                      iconSize: 20.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: 200.w,
                    margin: EdgeInsets.only(top: 15.h),
                    child: Text(
                      '활동',
                      style: CommonText.BodyL,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Divider(thickness: 1, height: 1, color: Palette.lightGray),
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '매칭 활성화',
                            style: CommonText.TitleS,
                          ),
                          SizedBox(width: 10.w),
                          FlutterSwitch(
                            height: 20.0,
                            width: 40.0,
                            padding: 4.0,
                            toggleSize: 15.0,
                            borderRadius: 10.0,
                            activeColor: Palette.main,
                            value: isToggled,
                            onToggle: (value) {
                              setState(() {
                                isToggled = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          '매칭을 활성화하면 대화 신청을 받을 수 있어요!',
                          textAlign: TextAlign.start,
                          style: CommonText.BodyB,
                        ),
                      ),
                    ],
                  )),
              Divider(thickness: 1, height: 1, color: Palette.lightGray),
              GestureDetector(
                child: Container(
                    height: 50.h,
                    padding: EdgeInsets.only(
                      left: 16.w,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.w, top: 3.h),
                          child: Icon(
                            Icons.account_circle,
                            color: Palette.gray,
                          ),
                        ),
                        Text(
                          '요청/제안 목록',
                          style: CommonText.BodyXS,
                        ),
                      ],
                    )),
                onTap: () {
                  Get.toNamed('/myRequestList');
                },
              ),
              Divider(thickness: 0.5, height: 1, color: Palette.lightGray),
              InkWell(
                child: Container(
                    height: 50.h,
                    padding: EdgeInsets.only(left: 16.w),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.w, top: 3.h),
                          child: Icon(
                            Icons.article,
                            color: Palette.gray,
                          ),
                        ),
                        Text(
                          '내가 작성한 글/댓글',
                          style: CommonText.BodyXS,
                        ),
                      ],
                    )),
                onTap: () async {
                  await Get.put(MyPostsListController()).getMyPosts();
                  Get.toNamed('/myPostsList');
                  //await Get.put(MyCommentsListController()).getMyComments();
                },
              ),
              Divider(thickness: 0.5, height: 1, color: Palette.lightGray),
            ],
          ),
        ],
      ),
    );
  }
}
