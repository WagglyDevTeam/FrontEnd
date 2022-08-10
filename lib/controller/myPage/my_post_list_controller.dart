import 'package:get/get.dart';
import 'package:waggly/model/Mypage/my_page_model.dart';
import 'package:waggly/server/server.dart';

class MyPostListController extends GetxController {
  var myCommentsList = <MyPostListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var myComment = await Services.getMyPostList();
    if (myComment != null) {
      // myCommentsList.value = myComment;
    }
  }
}
// 변경