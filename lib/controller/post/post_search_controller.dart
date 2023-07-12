
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
  final searchedPost = [].obs;
  final selectIndex = 0.obs;
  final searchResult = false.obs;
  final getInPage = true.obs;

  //
  // getHistoryList(int userId){
  //   return postSearchHistoryBox.value.values.where((el) => el.userId == userId).toList();
  // }
  //
  // void addSearchHistory(int id, int userId, String keyword) async {
  //   await postSearchHistoryBox.value.add(PostSearchHistory(id: id, userId: userId, keyword: keyword));
  // }

  void deleteSearchHistory(int id) async{
    print('id $id');
    await postSearchHistoryBox.value.deleteAt(id);
  }

  void toList(int userId){
    historyList.clear();
    for(var item in postSearchHistoryBox.value.values.where((element) => element.userId == userId)){
      if(historyList.length == 10){
        historyList.removeLast();
      }
      historyList.insert(0, item.keyword);
      historyList;
    }
  }

  // void updateList(int userId) async{
  //   historyList.clear();
  //   toList(userId);
  // }

  @override
  void onInit() async {
    super.onInit();
    getInPage.value = true;
  }


  ///search post
 Future<void> getSearchPost(String? keyword) async {
   PostSearchRequestDto searchPost = PostSearchRequestDto(keyword: keyword, page: postPage.value, size: 10 );
   WagglyResponsePaginationDto result = await _postRepository.searchBoard(searchPost);
   dynamic postJson = result.datas["posts"];

   if(result.status == '200'){
     print('result value = ${searchResult.value}');
     searchResult.value = true;
     if(postJson != []){
       List<PostSearchData> postData = List<PostSearchData>.from(postJson.map((x) => PostSearchData.fromJson(x)).toList());
       print('postData $postData');
       searchedPost.value = postData;
       // update();
       // searchedPost.refresh();
     }
   }


 }

 Future<void> resetPostSearch() async{
   searchedPost.value = [];
 }
}