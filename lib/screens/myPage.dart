import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wagly/components/Mypage/profileImg/profileImg.dart';
import 'package:wagly/components/Mypage/active/index.dart';
import 'package:wagly/components/Notification/notification.dart';
import 'package:wagly/model/wagglyImg.dart';
import 'package:wagly/widgets/Button/Button.dart';
import 'package:wagly/widgets/index.dart';
import 'package:wagly/utils/textFrame.dart';
import 'package:wagly/utils/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

PageRouteWithAnimation profileImg =
    PageRouteWithAnimation(const ProfileImgScreen());

PageRouteWithAnimation activePage =
    PageRouteWithAnimation(const ActiveScreen());

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 68),
          child: Column(children: [
            const TopNav(),
          ])),
      body: const myPage(),
    );
  }
}

class TopNav extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  const TopNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Container(
        margin: EdgeInsets.only(top: 15),
        child: Text(
          '내 정보',
          style: CommonText.TitleM,
        ),
      ),
      actions: <Widget>[
        Container(
          width: 36,
          height: 36,
          margin: EdgeInsets.only(top: 20, right: 16, bottom: 0),
          //padding: const EdgeInsets.all(7.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(40.0) // POINT
                      ),
              border: Border.all(width: 1.0, color: const Color(0xFFE8E8E8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 주 축 기준 중앙
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                    ),
                    splashRadius: 50,
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    color: Palette.gray,
                    onPressed: () {
                      // Server().getList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()),
                      );
                    })
              ],
            ),
          ),
        )
      ],
    );
  }
}

class myPage extends StatefulWidget {
  const myPage({Key? key}) : super(key: key);

  @override
  _myPageState createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      debugPrint('data: $imageTemp');

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }

  //FileImage(image!)
  //"assets/images/defaultProfile.png";
  var profilePic = <ProfileImgModel>[].obs;
  String userName = "와글바글신나";
  String savedbio = "";
  bool hasSubmitted = true;
  bool profilehasSubmitted = true;

  final controller = TextEditingController();
  bool isDisabled = false;

  // for getting access to form
  final _formKey = GlobalKey<FormState>();

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
        return bottomSheet();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //close button
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // profile section
            Divider(thickness: 1, height: 1, color: Palette.paper),
            Container(
              height: 60,
              padding: EdgeInsets.only(top: 13, left: 16, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: 20.0,
                            backgroundImage: image != null
                                ? FileImage(image!)
                                : AssetImage("assets/images/defaultProfile.png")
                                    as ImageProvider),
                        if (!profilehasSubmitted)
                          Positioned(
                              bottom: 10.0,
                              right: 10.0,
                              child: InkWell(
                                  onTap: () {
                                    _showModalBottomSheet(context);
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Palette.lightGray,
                                    size: 20.0,
                                  )))
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                      width: MediaQuery.of(context).size.width - 140,
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (profilehasSubmitted)
                            Text(
                              userName,
                              style: CommonText.TitleS,
                            ),
                          if (!profilehasSubmitted)
                            Container(
                              child: TextFormField(
                                key: ValueKey(1),
                                validator: (value) {},
                                onSaved: (value) {},
                                onChanged: (value) {
                                  setState(() {
                                    userName = value;
                                  });
                                },
                                cursorColor: Palette.main,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.only(top: -2, bottom: -1),
                                  counterText: '',
                                  hintText: userName,
                                  hintStyle: CommonText.TitleS,
                                ),
                              ),
                            ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('와플대학교'),
                              Text('/'),
                              Text('누텔라딸기과')
                            ],
                          ),
                        ],
                      )),
                  if (profilehasSubmitted)
                    Container(
                      width: 52.0,
                      height: 25.0,
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(left: 5),
                      child: ElevatedButton(
                        child: Text(
                          "수정",
                          style: CommonText.BodyXS,
                        ),
                        onPressed: () => {
                          setState(() {
                            profilehasSubmitted = false;
                          }),
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Palette.candy,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                      ),
                    ),
                  if (!profilehasSubmitted)
                    Container(
                      width: 52.0,
                      height: 25.0,
                      margin: EdgeInsets.only(left: 5),
                      child: ElevatedButton(
                        child: Text(
                          "완료",
                          style: CommonText.BodyXSmallWhite,
                        ),
                        onPressed: () => {
                          setState(() {
                            profilehasSubmitted = true;
                          }),
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Palette.main,
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
            SizedBox(height: 15),
            Divider(thickness: 1, height: 1, color: Palette.paper),
            SizedBox(height: 15),

            //자기소개 button
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //서버에서 받아오는 데이터가 있을 경우
                    if (savedbio.length > 0)
                      Container(
                        child: Row(
                          children: [
                            if (hasSubmitted)
                              Container(
                                width: MediaQuery.of(context).size.width - 90,
                                child: Text(
                                  savedbio,
                                  style: CommonText.BodyS,
                                ),
                              ),
                            if (!hasSubmitted)
                              Container(
                                width: MediaQuery.of(context).size.width - 90,
                                child: TextFormField(
                                  key: ValueKey(1),
                                  validator: (value) {},
                                  onSaved: (value) {},
                                  onChanged: (value) {
                                    setState(() {
                                      savedbio = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 0, bottom: 0),
                                    counterText: '',
                                    hintText: savedbio,
                                    hintStyle: CommonText.BodyM,
                                  ),
                                ),
                              ),
                            if (hasSubmitted)
                              Container(
                                width: 52.0,
                                height: 25.0,
                                margin: EdgeInsets.only(left: 5),
                                child: ElevatedButton(
                                  child: Text(
                                    "수정",
                                    style: CommonText.BodyXS,
                                  ),
                                  onPressed: () {
                                    // validating form
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    // saving form
                                    _formKey.currentState!.save();
                                    // updating hasSubmitted
                                    setState(() {
                                      // updating hasSubmitted
                                      hasSubmitted = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Palette.candy,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ).copyWith(
                                      elevation:
                                          ButtonStyleButton.allOrNull(0.0)),
                                ),
                              ),
                            if (!hasSubmitted)
                              Container(
                                width: 52.0,
                                height: 25.0,
                                margin: EdgeInsets.only(left: 5),
                                child: ElevatedButton(
                                  child: Text(
                                    "완료",
                                    style: CommonText.BodyXSmallWhite,
                                  ),
                                  onPressed: () {
                                    // validating form
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    // saving form
                                    _formKey.currentState!.save();
                                    // updating hasSubmitted
                                    setState(() {
                                      // updating hasSubmitted
                                      hasSubmitted = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Palette.main,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ).copyWith(
                                      elevation:
                                          ButtonStyleButton.allOrNull(0.0)),
                                ),
                              ),
                          ],
                        ),
                      ),
                    //서버에서 받아오는 데이터가 없을 경우
                    if (savedbio.length == 0)
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: TextFormField(
                                maxLength: 100,
                                enabled: hasSubmitted ? false : true,
                                key: ValueKey(1),
                                validator: (value) {},
                                onSaved: (value) {},
                                onChanged: (value) {
                                  setState(() {
                                    savedbio = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(5),
                                  counterText: '',
                                  hintText: hasSubmitted
                                      ? '다른 친구들에게 자신을 소개해보세요'
                                      : savedbio,
                                  hintStyle: CommonText.BodyMediumGray,
                                ),
                              ),
                            ),
                            if (hasSubmitted)
                              Container(
                                width: 52.0,
                                height: 25.0,
                                margin: EdgeInsets.only(left: 5),
                                child: ElevatedButton(
                                  child: Text(
                                    "수정",
                                    style: CommonText.BodyXS,
                                  ),
                                  onPressed: () {
                                    // validating form
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    // saving form
                                    _formKey.currentState!.save();
                                    // updating hasSubmitted
                                    setState(() {
                                      // updating hasSubmitted
                                      hasSubmitted = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Palette.candy,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ).copyWith(
                                      elevation:
                                          ButtonStyleButton.allOrNull(0.0)),
                                ),
                              ),
                            if (!hasSubmitted)
                              Container(
                                width: 52.0,
                                height: 25.0,
                                margin: EdgeInsets.only(left: 5),
                                child: ElevatedButton(
                                  child: Text(
                                    "완료",
                                    style: CommonText.BodyXSmallWhite,
                                  ),
                                  onPressed: () {
                                    // validating form
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    // saving form
                                    _formKey.currentState!.save();
                                    // updating hasSubmitted
                                    setState(() {
                                      // updating hasSubmitted
                                      hasSubmitted = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Palette.main,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ).copyWith(
                                      elevation:
                                          ButtonStyleButton.allOrNull(0.0)),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
//             grid view list
            SizedBox(height: 15),
            Divider(thickness: 1, height: 1, color: Palette.paper),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "활동",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(activePage.slideRitghtToLeft());
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "설정",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      print('hello');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "공지",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      print('hello');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "이용안내",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      print('hello');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "서비스방침",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      print('hello');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "F&A",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      print('hello');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "문의",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      print('hello');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        "오픈소스",
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.paper,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onTap: () {
                      print('hello');
                    },
                  ),
                ],
              ),
            ),
          ]),
    ]);
  }

//사진 고르기
  Widget bottomSheet() => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('프로필 설정'),
            SizedBox(height: 16),
            Divider(thickness: 1, height: 1, color: Palette.paper),
            SizedBox(height: 10),
            Button(
                text: '와글리 이미지',
                onPress: () {
                  Navigator.of(context).push(profileImg.slideRitghtToLeft());
                },
                theme: 'small'),
            SizedBox(height: 5),
            Button(
                text: '앨범',
                onPress: () {
                  pickImage();
                },
                theme: 'small'),
            SizedBox(height: 25),
          ],
        ),
      );
}
