import 'package:get/get.dart';
import 'package:waggly/model/Mypage/waggly_img.dart';
import 'package:waggly/server/server.dart';

class WagglyImgController extends GetxController {
  var wagglyImglist = <WagglyImg>[].obs;
  var imgList = <WagglyImgModel>[].obs;
  dynamic checkedImg;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    imgList.value = <WagglyImgModel>[].obs;
    var wagglyImgs = await Services.getWagglyImg();
    if (wagglyImgs != null) {
      wagglyImglist.value = wagglyImgs;
    }
    print(wagglyImglist);
    // imgList.value = <WagglyImgModel>[].obs;
    // for (var i = 0; i < wagglyImglist.length; i++) {
    //   var imgItem = wagglyImglist[i];
    //   imgList.add(
    //     WagglyImgModel(
    //       id: imgItem.id,
    //       img: imgItem.img,
    //       value: false,
    //     ),
    //   );
    // }
  }
}
