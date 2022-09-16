import 'package:validators/validators.dart';

String validateEmail(String? value) {
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

String validateClassNumber(String? value) {
  if (value!.isEmpty) {
    return "학번을 입력해주세요.";
  } else if (!matches(value, r'[0-9]{2,2}$')) {
    return "학번을 두 자리로 입력해주세요.(2022학번 = 22)";
  } else {
    return "";
  }
}
