import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/Button/button.dart';

class SettingScreen extends StatelessWidget{
  const SettingScreen({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: SettingContent(),
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
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("설정", style: CommonText.BodyL))
            ],
          ),
        ),
      ],
    );
  }
}

class SettingContent extends StatefulWidget {
  const SettingContent({Key? key}) : super(key: key);

  @override
  _SettingContentState createState() => _SettingContentState();
}

class _SettingContentState extends State<SettingContent> {

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      //드래그 안되게~
      enableDrag: false,
      //modal 위치 외에 클릭 안되게 하는것
      isDismissible: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: ((context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('로그아웃 하시겠습니까?',
                style:CommonText.BodyM),
              SizedBox(height: 16.h),
              Divider(thickness: 1, height: 1, color: Palette.paper),
              SizedBox(height: 10.h),
              Container(
                  alignment: Alignment.center,
                width: 200.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: Palette.candy,
                    borderRadius: BorderRadius.circular(40),
                  ),
                child: TextButton(
                    onPressed: () {
                      // 로긴 로그아웃 체크
                      Get.toNamed('/signInPage');
                      if (Get.put(SignInController()).checkLoggedIn().value == true) {
                        Get.put(SignInController()).logout();
                      }
                    },
                    child: Text('예', style: TextStyle(color: Palette.purple),),

                  ),
              ),
              SizedBox(height: 5.h),
              Container(
                alignment: Alignment.center,
                width: 200.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: Palette.candy,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('아니요', style: TextStyle(color: Palette.purple),),

                ),
              ),
              SizedBox(height: 25.h),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
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
                        '로그아웃',
                        style: CommonText.BodyXS,
                      ),
                    ],
                  )),
              onTap: () {
                _showModalBottomSheet(context);
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
                        '탈퇴',
                        style: CommonText.BodyXS,
                      ),
                    ],
                  )),
              onTap: () async {
                Get.toNamed('/withdraw');
              },
            ),
            Divider(thickness: 1, height: 1, color: Palette.paper),
          ],
        ),
      ],
    );
  }
}
