import 'package:get/get.dart';
import 'package:waggly/model/myPage/waggly_img.dart';
import 'package:waggly/server/server.dart';

class WagglyImgController extends GetxController {
  var wagglyImglist = <WagglyImg>[].obs;
  int selected = -1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var wagglyImage = await Services.getWagglyImg();
    if (wagglyImage != null) {
      wagglyImglist.value = wagglyImage;
    }
    print(wagglyImglist);
  }
}
