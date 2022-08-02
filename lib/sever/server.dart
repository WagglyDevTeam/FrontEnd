import 'package:dio/dio.dart';
import 'package:wagly/model/wagglyImg.dart';
import 'package:wagly/model/myPageModel.dart';

class Services {
  static Future<List<WagglyImg>?> getWagglyImg() async {
    Dio dio = new Dio();
    var response = await dio.get(
        'https://2e828a7c-3f92-4016-bd0f-a0a58904819d.mock.pstmn.io/wagglylist');
    return wagglyImgFromJson(response.toString());
  }

  static Future<List<MyPostListModel>?> getMyPostList() async {
    Dio dio = new Dio();
    var response = await dio.get(
        'https://2e828a7c-3f92-4016-bd0f-a0a58904819d.mock.pstmn.io/mycomments');
    return myPostListModelFromJson(response.toString());
  }
}
