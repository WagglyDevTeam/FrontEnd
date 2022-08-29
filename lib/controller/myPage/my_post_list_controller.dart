import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/hive/user.dart';
import 'package:waggly/model/myPage/my_post_provider.dart';
import 'package:waggly/model/myPage/my_post_model.dart';
import 'package:waggly/model/myPage/my_post_repository.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';

class MyPostsListController extends GetxController {
  final MyPostsListRepository _myPostsListRepository = MyPostsListRepository();
  final myPosts = [].obs;
  final mine = true.obs;

  SignInController signInController = Get.put(SignInController());

  @override
  void onInit() {
    super.onInit();
    //getMyPosts();
  }

  Future<void> getMyPosts() async {
    //final token = signInController.getToken();
    Hive.box<User>('user').get('user')?.jwtToken;
    print(Hive.box<User>('user').get('user')?.jwtToken);
    WagglyResponseDto result = await _myPostsListRepository.getMyPosts();
    List<dynamic> myPostsListJson = result.datas['myPosts'];
    List<MyPost> convertMyPosts =
        myPostsListJson.map((e) => MyPost.fromJson(e)).toList();
    myPosts.value = convertMyPosts;
  }
}
