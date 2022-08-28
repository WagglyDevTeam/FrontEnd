import 'package:get/get.dart';
import 'package:waggly/model/myPage/request_model.dart';
import 'package:waggly/model/myPage/request_provider.dart';

class RequestController extends GetxController {
  final RequestProvider _requestProvider = RequestProvider();
  final requests = <RequestModel>[].obs;
  final requestsData = <Data>[].obs;
  final requestUser = RequestUser(nickname: '').obs;

  @override
  void onInit() async {
    super.onInit();
    await getRequestList();
  }

  Future<void> getRequestList() async {
    Response response = await _requestProvider.getRequestList();
    dynamic body = response.body;
    List<dynamic> requestListJson = body['datas'];
    List<Data> convertRequestList =
        requestListJson.map((e) => Data.fromJson(e)).toList();
    requestsData.value = convertRequestList;
  }
}
