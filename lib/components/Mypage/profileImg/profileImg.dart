import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wagly/screens/myPage.dart';
import 'package:wagly/widgets/Button/Button.dart';
import 'package:wagly/widgets/PageNav/PageNav.dart';
import 'package:wagly/utils/colors.dart';
import 'package:wagly/model/wagglyImg.dart';
import 'package:wagly/controller/wagglyImg_controller.dart';

class ProfileImgScreen extends StatelessWidget {
  const ProfileImgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: ProfileImgList());
  }
}

class ProfileImgList extends StatefulWidget {
  const ProfileImgList({Key? key}) : super(key: key);

  @override
  _ProfileImgList createState() => _ProfileImgList();
}

class _ProfileImgList extends State<ProfileImgList> {
  @override
  void initState() {
    super.initState();
    getImg();
  }

  bool focus = false;
  //기존 img list를 value를 넣어서 다시 만들어주기 위한 리스트
  List<dynamic> imgList = [];
  //선택된 이미지 리스트
  dynamic checkedImg;
  String imgUrl = '';

  void getImg() async {
    final controller = Get.put(WagglyImgController());
    for (var i = 0; i < controller.wagglyImglist.length; i++) {
      var imgItem = controller.wagglyImglist[i];
      imgList.add(
        WagglyImgModel(
          id: imgItem.id,
          img: imgItem.img,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Stack(children: [
        Column(
          children: [
            PageNav(
              pageTitle: '와글리 이미지',
              noBorder: false,
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(26),
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  ...imgList.map(
                    (item) => GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Image.network(item.img.toString()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                              color: checkedImg?.id == item.id
                                  ? Palette.main
                                  : Palette.light),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          onClick(item);
                          imgUrl = item.img.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, height: 1, color: Palette.paper),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Button(
                  text: '적용하기',
                  onPress: () {
                    ProfileImgModel(img: imgUrl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPageScreen()),
                    );
                    print(imgUrl);
                  },
                  disabled: checkedImg != null ? false : true,
                  theme: 'double'),
            ),
            SizedBox(height: 30),
          ],
        ),
      ]),
    );
  }

  onClick(WagglyImgModel item) {
    setState(() {
      item.value = !item.value;
      checkedImg = item;
    });
  }
}
