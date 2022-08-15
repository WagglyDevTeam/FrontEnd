import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:waggly/model/signIn/dtos/sign_in_reqeust_dto.dart';
import 'package:waggly/model/signIn/sign_in_repository.dart';
import '../../model/signIn/sign_in_provider.dart';

class SignInController extends GetxController{
  final SignInProvider _signInProvider = SignInProvider();

  Future<bool> signIn(SignInRequestDto signInRequestDto) async {
    Response response = await _signInProvider.signIn(signInRequestDto);
    if(response.statusCode == 200){
      Hive.box('user').put('jwtToken', response.headers!["authorization"]);
      // Get.toNamed("/writePage");
      // print(Hive.box('user').get('jwtToken'));
      return true;
    }else{
      print("로그인 에러");
      return false;
    }
  }
}