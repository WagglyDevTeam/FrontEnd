import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/screens/my_page.dart';
import 'package:waggly/widgets/Button/button.dart';
import 'package:waggly/widgets/PageNav/page_nav.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/model/myPage/waggly_img.dart';
import 'package:waggly/controller/myPage/waggly_img_controller.dart';

class ProfileImgScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: ProfileImgList());
  }
}

class ProfileImgList extends StatelessWidget {
  WagglyImgController controller = Get.put(WagglyImgController());

  bool focus = false;
  dynamic checkedImg;
  String imgUrl = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Column(
            children: [
              PageNav(
                pageTitle: '와글리 이미지',
                noBorder: false,
              ),
              Expanded(
                child: Obx(
                  () => GridView.count(
                    padding: const EdgeInsets.all(26),
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      // ...(controller.wagglyImglist).map(
                      ...(controller.imgList).map(
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
                            // setState(() {
                            // onClick(item);
                            // imgUrl = item.img.toString();
                            // });
                          },
                        ),
                      ),
                    ],
                  ),
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
        ],
      ),
    );
  }

  void onClick(WagglyImgModel item) {
    item.value = !item.value;
    checkedImg = item;
  }
}
