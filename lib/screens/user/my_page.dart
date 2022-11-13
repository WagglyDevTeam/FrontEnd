import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/controller/myPage/my_profile_controller.dart';
import 'package:waggly/controller/myPage/notification_controller.dart';
import 'package:waggly/controller/myPage/waggly_img_controller.dart';
import 'package:waggly/provider/my_comment_provider.dart';
import 'package:waggly/utils/my_page_icons.dart';
import 'package:waggly/model/myPage/waggly_img.dart';
import 'package:waggly/widgets/Button/button.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/myPage/my_profile_model.dart';
import 'package:waggly/model/myPage/my_profile_introduction_model.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(),
      body: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  MyProfileController myProfileController = Get.put(MyProfileController());
  SignInController signInController = Get.put(SignInController());
  final _nickname = TextEditingController();
  final _introduction = TextEditingController();

  void buttonToggle() {
    if (_nickname.text.isBlank == true) {
      myProfileController.nicknameBtn.value = false;
    } else {
      myProfileController.nicknameBtn.value = true;
    }
  }

  var profilePic = <ProfileImgModel>[].obs;

  String savedbio = "";
  bool hasSubmitted = true;
  bool profilehasSubmitted = true;

  final controller = TextEditingController();
  bool isDisabled = false;

  void _showModalBottomSheet(BuildContext context) {
    WagglyImgController controller = Get.put(WagglyImgController());
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
              Text('프로필 설정'),
              SizedBox(height: 16.h),
              Divider(thickness: 1, height: 1, color: Palette.paper),
              SizedBox(height: 10.h),
              Button(
                  text: '와글리 이미지',
                  onPress: () {
                    controller.fetchData();
                    Get.toNamed('/profileImg');
                    myProfileController.removeData();
                  },
                  theme: 'small'),
              SizedBox(height: 5.h),
              Button(
                  text: '앨범',
                  onPress: () {
                    myProfileController.pickImage();
                  },
                  theme: 'small'),
              SizedBox(height: 25.h),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<MyProfileController>();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //close button
      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        // profile section
        Divider(thickness: 1, height: 1, color: Palette.paper),
        Container(
          height: 60.h,
          padding: EdgeInsets.only(top: 13.h, left: 10.w, right: 10.w),
          child: Obx(
                () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: 20.0,
                          backgroundImage: myProfileController.profilePic.value != "기본이미지 Url"
                              ? NetworkImage(myProfileController.profilePic.value)
                              : AssetImage("assets/images/defaultProfile.png") as ImageProvider),
                      if (myProfileController.nicknameBtn.value)
                        Positioned(
                            bottom: 6.0.h,
                            right: 6.0.w,
                            child: InkWell(
                                onTap: () {
                                  _showModalBottomSheet(context);
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Palette.lightGray,
                                  size: 20.0.r,
                                ))),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: MediaQuery.of(context).size.width - 119.w,
                  padding: EdgeInsets.only(top: 8.h),
                  child: Obx(
                        () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        !myProfileController.nicknameBtn.value
                            ? Text(
                          myProfileController.nickname.value,
                          style: CommonText.TitleS,
                        )
                            : TextFormField(
                          controller: _nickname,
                          maxLines: 1,
                          maxLength: 10,
                          cursorColor: Palette.main,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.only(top: -2, bottom: -1),
                            counterText: '',
                            hintText: myProfileController.nickname.value,
                            hintStyle: CommonText.TitleSmallGray,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(myProfileController.university.value),
                            Text('/'),
                            Text(myProfileController.major.value)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.0.w,
                  height: 20.0.h,
                  child: ElevatedButton(
                    child: Text(
                      !myProfileController.nicknameBtn.value ? "수정" : "완료",
                      style: !myProfileController.nicknameBtn.value ? CommonText.BodyXS : CommonText.BodyXSmallWhite,
                    ),
                    onPressed: () async {
                      if (!myProfileController.nicknameBtn.value) {
                        myProfileController.nicknameBtn.value = true;
                      } else {
                        await myProfileController.changeUserProfile(
                          ProfileData(profileImg: _nickname.text, nickname: _nickname.text),
                        );
                        myProfileController.nicknameBtn.value = false;
                        // myProfileController.nickname.value = _nickname.text;

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: !myProfileController.nicknameBtn.value ? Palette.candy : Palette.main,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Divider(thickness: 1, height: 1, color: Palette.paper),
        SizedBox(height: 15.h),
        //자기소개 button
        Container(
          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
          child: Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () => Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width - 80.w,
                    padding: EdgeInsets.only(top: 2),
                    child: !myProfileController.bioBtn.value
                        ? Obx(
                          () => myProfileController.bio.value != ''
                          ? Text(myProfileController.bio.value, style: CommonText.BodyS)
                          : TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          counterText: '',
                          contentPadding: EdgeInsets.only(top: 2),
                          hintText: '다른 친구들에게 자신을 소개해보세요',
                          hintStyle: CommonText.BodyMediumGray,
                        ),
                      ),
                    )
                        : Obx(
                          () => TextFormField(
                        controller: _introduction..text = myProfileController.bio.value,
                        maxLength: 100,
                        maxLines: 2,
                        autofocus: true,
                        cursorColor: Palette.main,
                        style: CommonText.BodyS,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          counterText: '',
                          contentPadding: EdgeInsets.only(top: 0),
                          hintText: myProfileController.bio.value != ''
                              ? myProfileController.bio.value
                              : '다른 친구들에게 자신을 소개해보세요',
                          hintStyle: CommonText.BodyMediumGray,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.0.w,
                  height: 20.0.h,
                  child: ElevatedButton(
                    child: Obx(
                          () => Text(
                        myProfileController.bioBtn.value == false ? "수정" : "완료",
                        style: !myProfileController.bioBtn.value ? CommonText.BodyXS : CommonText.BodyXSmallWhite,
                      ),
                    ),
                    onPressed: () async {
                      if (!myProfileController.bioBtn.value) {
                        myProfileController.bioBtn.value = true;
                      } else {
                        if (_introduction.text.isNotEmpty) {
                          await myProfileController.changeUserIntroduction(Bio(userIntroduction: _introduction.text));
                        }
                        myProfileController.bioBtn.value = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: !myProfileController.bioBtn.value ? Palette.candy : Palette.main,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
        //grid view list
        SizedBox(height: 15.h),
        Divider(thickness: 1, height: 1, color: Palette.paper),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.0.r),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 7.w,
              crossAxisSpacing: 7.h,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        myPageIcons[index]['icon'],
                        size: 20.r,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '${myPageIcons[index]['title']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Palette.paper,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onTap: () {
                  Get.toNamed('${myPageIcons[index]['page']}');
                  myProfileController.removeData();
                },
              );
            },
            itemCount: myPageIcons.length,
          ),
        ),
      ]),
    ]);
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
          title: Text('내정보', style: CommonText.TitleL),
          actions: [
            if (signInController.checkLoggedIn().value == true)
              InkWell(
                onTap: () async {
                  // 알림 페이지로 이동
                  await Get.put(NotificationController()).getNotification();
                  Get.put(MyProfileController()).removeData();
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