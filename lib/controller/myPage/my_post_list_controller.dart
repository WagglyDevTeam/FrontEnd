import 'package:get/get.dart';
import 'package:waggly/model/myPage/my_post_provider.dart';
import 'package:waggly/model/myPage/my_post_model.dart';

class MyPostsListController extends GetxController {
  final MyPostsListProvider _myPostsListProvider = MyPostsListProvider();
  final myPosts = [].obs;
  final mine = true.obs;

  @override
  void onInit() {
    super.onInit();
    getMyPosts();
  }

  Future<void> getMyPosts() async {
    Response response = await _myPostsListProvider.getMyPosts();
    dynamic body = response.body;
    print(response);
    List<dynamic> myPostsListJson = body['datas']['myPosts'];
    List<Data> convertMyPosts =
        myPostsListJson.map((e) => Data.fromJson(e)).toList();
    myPosts.value = convertMyPosts;
  }
}
