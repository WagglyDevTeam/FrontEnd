
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waggly/hive/post_search_history.dart';
import 'package:waggly/model/post/dtos/post_search_dto.dart';
import 'package:waggly/model/post/dtos/waggly_response_pagination_dto.dart';
import 'package:waggly/repository/post_repository.dart';

class PostSearchController extends GetxController {
  Rx<Box<PostSearchHistory>> postSearchHistoryBox = Hive.box<PostSearchHistory>('postSearchHistory').obs;
  RxList<String> historyList = <String>[].obs;

  final PostRepository _postRepository = PostRepository();
  final postPage = 0.obs;


  getHistoryList(int userId){
    return postSearchHistoryBox.value.values.where((el) => el.userId == userId).toList();
  }

  void addSearchHistory(int id, int userId, String keyword) async {
    await postSearchHistoryBox.value.add(PostSearchHistory(id: id, userId: userId, keyword: keyword));
  }

  void deleteSearchHistory(int id) async{
    await postSearchHistoryBox.value.deleteAt(id);
  }

  void toList(int userId){
    historyList.clear();
    for(var item in postSearchHistoryBox.value.values.where((element) => element.userId == userId)){
      historyList.add(item.keyword);
      historyList.reversed;
    }
  }

  void updateList(int userId) async{
    historyList.clear();
    toList(userId);
  }

  @override
  void onInit() async {
    super.onInit();
  }


  ///search post
 Future<void> getSearchPost(String? keyword) async {
   PostSearchRequestDto searchPost = PostSearchRequestDto(keyword: keyword, page: postPage.value, size: 10 );
   print('searchpost $keyword $postPage.value');
   WagglyResponsePaginationDto result = await _postRepository.searchBoard(searchPost);
   dynamic postJson = result.datas["posts"];
   print('post = ${postJson}');
 }
}