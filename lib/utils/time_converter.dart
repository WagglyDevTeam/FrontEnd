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
