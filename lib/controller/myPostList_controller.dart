import 'package:get/get.dart';
import 'package:wagly/model/myPageModel.dart';
import 'package:wagly/sever/server.dart';

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
      myCommentsList.value = myComment;
    }
  }
}
