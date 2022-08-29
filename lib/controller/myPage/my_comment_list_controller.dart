import 'package:get/get.dart';
import 'package:waggly/model/myPage/my_comment_provider.dart';
import 'package:waggly/model/myPage/my_comment_model.dart';

class MyCommentsListController extends GetxController {
  final MyCommentsListProvider _myCommentsListProvider =
      MyCommentsListProvider();
  final myComments = [].obs;

  @override
  void onInit() {
    super.onInit();
    getMyComments();
  }

  Future<void> getMyComments() async {
    Response response = await _myCommentsListProvider.getMyComments();
    dynamic body = response.body;
    // List<dynamic> myCommentsListJson = body['datas']['myComments'];
    // List<Data> convertMyComments =
    //     myCommentsListJson.map((e) => Data.fromJson(e)).toList();
    // myComments.value = convertMyComments;
  }
}
