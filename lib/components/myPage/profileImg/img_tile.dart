import 'package:flutter/cupertino.dart';
import 'package:waggly/model/myPage/waggly_img.dart';
import 'package:waggly/utils/colors.dart';
import 'package:get/get.dart';

class ImgTile extends StatelessWidget {
  final WagglyImg wagglyImg;
  const ImgTile(this.wagglyImg);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Image.network(wagglyImg.img.toString()),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
                color: wagglyImg.selected.value ? Palette.main : Palette.light),
          ),
        ),
        onTap: () {
          wagglyImg.selected.value != wagglyImg.selected.value;
          // checkedImg = item;
          // imgUrl = item.img.toString();
        },
      ),
    );
  }
}
