import 'package:get/get.dart';
import 'package:wagly/model/wagglyImg.dart';
import 'package:wagly/sever/server.dart';

class WagglyImgController extends GetxController {
  var wagglyImglist = <WagglyImg>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var wagglyImgs = await Services.getWagglyImg();
    print(wagglyImgs);
    if (wagglyImgs != null) {
      wagglyImglist.value = wagglyImgs;
    }
  }
}
