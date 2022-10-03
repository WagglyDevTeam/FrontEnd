import 'package:flutter/material.dart';

String convertTimeToKorean(DateTime datetime) {
  String time = datetime.hour.toString();
  String minute = datetime.minute.toString();
  String timeString = int.parse(time) >= 0 && int.parse(time) < 12 ? "오전" : "오후";

  if (timeString == "오전") {
    return "$timeString $time:$minute";
  } else {
    time = int.parse(time) - 12 == 0 ? "00" : (int.parse(time) - 12).toString();
    return "$timeString $time:$minute";
  }
}

String convertWeekDayToKorean(int weekday) {
  switch (weekday) {
    case 1:
      {
        return "월요일";
      }
    case 2:
      {
        return "화요일";
      }
    case 3:
      {
        return "수요일";
      }
    case 4:
      {
        return "목요일";
      }
    case 5:
      {
        return "금요일";
      }
    case 6:
      {
        return "토요일";
      }
    case 7:
      {
        return "일요일";
      }
    default:
      {
        return "";
      }
  }
}
