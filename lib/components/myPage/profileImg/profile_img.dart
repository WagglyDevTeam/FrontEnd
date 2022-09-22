import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/components/myPage/profileImg/img_tile.dart';
import 'package:waggly/widgets/Button/button.dart';
import 'package:waggly/utils/colors.dart';
import 'package:waggly/model/myPage/waggly_img.dart';
import 'package:waggly/controller/myPage/waggly_img_controller.dart';
import 'package:waggly/widgets/header/page_appbar.dart';

class ProfileImgScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: ProfileImgList());
  }
}

class ProfileImgList extends StatelessWidget {
  WagglyImgController controller = Get.put(WagglyImgController());

  bool focus = false;
  int checkedImg = 100;
  String imgUrl = '';
  var page = Status.setting;
  var pageTitle = '와글리 이미지';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Column(
            children: [
              PageAppbar(
                pageTitle: pageTitle,
                page: page,
              ),
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      //반복될 카드가 이미지와 텍스트를 이용하는 것이라서 그 타일 모양을 만들어주는게 좋다.
                      return Obx(
                        () => InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Image.network(
                                controller.wagglyImglist[index].img),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                  color: controller.selected.value == index
                                      ? Palette.main
                                      : Palette.lightGray),
                            ),
                          ),
                          onTap: () {
                            controller.selected.value = index;
                            checkedImg = index;
                            print(controller.selected.value);
                            imgUrl = controller.wagglyImglist[index].img;
                          },
                        ),
                      );
                    },
                    itemCount: controller.wagglyImglist.length,
                  ),
                ),
              ),
              Divider(thickness: 1, height: 1, color: Palette.paper),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: Obx(
                  () => Button(
                      text: '적용하기',
                      onPress: () {
                        ProfileImgModel(img: imgUrl);
                        Get.toNamed('/myPage');
                      },
                      disabled: controller.selected.value == checkedImg
                          ? false
                          : true,
                      theme: 'double'),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
