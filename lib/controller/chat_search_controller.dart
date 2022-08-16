import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:waggly/model/hive/search_history.dart';

class ChatSearchController extends GetxController {
  Rx<Box<SearchHistory>> searchHistoryBox =
      Hive.box<SearchHistory>('searchHistory').obs;

  RxList<String> historyList = <String>[].obs;

  void addSearchHistory(int id, int userId, String keyword) async {
    await searchHistoryBox.value
        .add(SearchHistory(id: id, userId: userId, keyword: keyword));
  }

  void deleteSearchHistory(int id) async {
    await searchHistoryBox.value.deleteAt(id);
  }

  void toList() {
    historyList.clear();
    for (var s in searchHistoryBox.value.values) {
      historyList.add(s.keyword);
    }
  }

  void updateList() async {
    historyList.clear();
    toList();
  }
}
