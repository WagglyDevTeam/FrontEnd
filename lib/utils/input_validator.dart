import 'package:validators/validators.dart';

String validateEmail(String? value) {
  final endWith = RegExp(r'.ac.kr$');
  if (value!.isEmpty) {
    return "email 주소를 입력해주세요.";
  } else if (!isEmail(value)) {
    return "email 형식을 확인해주세요.";
  } else if (!matches(value, r'ac.kr|.edu$')) {
    return "대학교 email이 아닙니다.";
  } else {
    return "";
  }
}
