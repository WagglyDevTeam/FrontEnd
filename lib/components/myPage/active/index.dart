import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:waggly/components/myPage/active/request_list.dart';
import 'package:waggly/controller/myPage/my_comment_list_controller.dart';
import 'package:waggly/controller/myPage/my_post_list_controller.dart';
import 'package:waggly/widgets/header/page_appbar.dart';
import 'package:waggly/widgets/index.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/utils/colors.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _page = Status.setting;
    var _pageTitle = '활동';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageAppbar(
        page: _page,
        pageTitle: _pageTitle,
      ),
      body: ActiveContent(),
    );
  }
}

class ActiveContent extends StatefulWidget {
  const ActiveContent({Key? key}) : super(key: key);

  @override
  _ActiveContentState createState() => _ActiveContentState();
}

class _ActiveContentState extends State<ActiveContent> {
  bool isToggled = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Divider(thickness: 1, height: 1, color: Palette.paper),
            Container(
                margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                padding: EdgeInsets.only(left: 16.w),
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
                          height: 20.0.h,
                          width: 40.0.w,
                          padding: 4.0.r,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '매칭을 활성화하면 대화 신청을 받을 수 있어요!',
                        textAlign: TextAlign.start,
                        style: CommonText.BodyB,
                      ),
                    ),
                  ],
                )),
            Divider(thickness: 1, height: 1, color: Palette.paper),
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
            Divider(thickness: 1, height: 1, color: Palette.paper),
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
            Divider(thickness: 1, height: 1, color: Palette.paper),
          ],
        ),
      ],
    );
  }
}
