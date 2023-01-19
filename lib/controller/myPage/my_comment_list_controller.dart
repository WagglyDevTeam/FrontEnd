import 'package:get/get.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/myPage/my_comment_model.dart';
import 'package:waggly/repository/my_comment_repository.dart';

class MyCommentsListController extends GetxController {
  final MyCommentsListRepository _myCommentsListProvider = MyCommentsListRepository();
  final myComments = [].obs;
  final postPage = 0.obs;
  final mine = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getMyComments() async {
    print(1);
    MyCommentDto writtenComment = MyCommentDto(page: postPage.value , size: 10);
    print(2);
    WagglyResponseDto response = await _myCommentsListProvider.getMyComments(writtenComment);
    List<dynamic> myCommentsListJson = response.datas['myComments']!;
    List<MyCommentModel> convertMyComments =
        myCommentsListJson.map((e) => MyCommentModel.fromJson(e)).toList();
    print(convertMyComments);
    myComments.value = convertMyComments;

  }
}
