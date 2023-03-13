
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waggly/hive/post_search_history.dart';

class PostSearchController extends GetxController {
  Rx<Box<PostSearchHistory>> postSearchHistoryBox = Hive.box<PostSearchHistory>('postSearchHistory').obs;

  RxList<String> historyList = <String>[].obs;

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
}