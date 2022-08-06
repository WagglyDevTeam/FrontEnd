import 'package:get/get.dart';
import 'package:waggly/model/Mypage/waggly_img.dart';
import 'package:waggly/server/server.dart';

class WagglyImgController extends GetxController {
  var wagglyImglist = <WagglyImg>[].obs;
  var imgList = <WagglyImgModel>[].obs;
  int checkedImgNumber = 0;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var wagglyImgs = await Services.getWagglyImg();
    if (wagglyImgs != null) {
      wagglyImglist.value = wagglyImgs;
    }
  }

  void getImg() async {
    imgList.value = <WagglyImgModel>[];
    for (var i = 0; i < wagglyImglist.length; i++) {
      var imgItem = wagglyImglist[i];
      imgList.add(
        WagglyImgModel(
          id: imgItem.id,
          img: imgItem.img,
        ),
      );
    }
  }
}
