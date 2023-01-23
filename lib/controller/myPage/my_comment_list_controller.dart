import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waggly/model/post/dtos/waggly_response_dto.dart';
import 'package:waggly/model/myPage/my_comment_model.dart';
import 'package:waggly/repository/my_comment_repository.dart';



class MyCommentsListController extends GetxController {
  final MyCommentsListRepository _myCommentsListProvider = MyCommentsListRepository();
  final myComments = [].obs;
  final postPage = 0.obs;
  final mine = false.obs;

  final scrollController = ScrollController().obs;
  final isLoadedMore = false.obs;
  final hasMore = false.obs;


  @override
  void onInit() {
    getMyComments();

    this.scrollController.value.addListener((){
      if(this.scrollController.value.position.maxScrollExtent == this.scrollController.value.position.pixels && hasMore.value == true){
        getMyComments();
      }
    });

    super.onInit();
  }

  Future<void> getMyComments() async {
    isLoadedMore.value = true;

    await Future.delayed(Duration(seconds: 2));
    print(postPage);
    print(555555555);
    MyCommentDto writtenComment = MyCommentDto(page: postPage.value , size: 10);
    WagglyResponseDto response = await _myCommentsListProvider.getMyComments(writtenComment);
    List<dynamic> myCommentsListJson = response.datas['myComments']!;
    List<MyComment> convertMyComments =
        myCommentsListJson.map((e) => MyComment.fromJson(e)).toList();
    if(convertMyComments.length < 10){
      hasMore.value = false;
      isLoadedMore.value = false;
    }else{
      isLoadedMore.value = false;
      hasMore.value = true;
      postPage.value += 1;
    }
    //myComments.value = convertMyComments;
    myComments.addAll(convertMyComments);

  }


  ///만약에 마지막 데이터를 다 가져왔다면?
  reload() async {
    isLoadedMore.value = false;
    myComments.clear();

    await Future.delayed(Duration(seconds: 2));
    postPage.value = 0;
    getMyComments();
  }
}
