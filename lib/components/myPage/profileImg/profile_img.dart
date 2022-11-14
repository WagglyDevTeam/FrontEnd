import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:waggly/components/myPage/profileImg/img_tile.dart';
import 'package:waggly/utils/text_frame.dart';
import 'package:waggly/widgets/Button/button.dart';
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
  int checkedImg = 100;
  String imgUrl = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      child: Stack(
        children: [
          Column(
            children: [
              TopAppBar(),
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16.w,
                      crossAxisSpacing: 16.h,
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
              Container(padding: EdgeInsets.only(bottom: 3.h), child: Text("와글리 이미지", style: CommonText.BodyL))
            ],
          ),
        ),
      ],
    );
  }
}
