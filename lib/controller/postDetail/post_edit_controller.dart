import 'dart:convert';

import 'package:get/get.dart';
import 'package:waggly/controller/postDetail/post_detail_controller.dart';

import '../../model/post/dtos/post_detail_dto.dart';

class PostEditController extends PostDetailController {
  final postEditData = PostDetailData().obs;

  @override
  void onInit() async {
    print("value $postId");
    getDetailBoard(postId.value);
    super.onInit();
  }

  void updatePostEditData() {
    var postDetailData = getPostDetailData();
    print(jsonEncode(postDetailData));
    postEditData.value = PostDetailData.fromClass(postDetailData);
  }
}
