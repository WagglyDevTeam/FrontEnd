import 'package:get/get_connect/connect.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PushNotificationProvider extends GetConnect {
  Future<Response> sendPushMessage(String token, String body, String title) => post(
        "https://fcm.googleapis.com/fcm/send",
        {
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "title": title,
            "body": body,
          },
          "notification": {
            "title": title,
            "body": body,
          },
          "registration_ids": [token]
        },
        headers: {
          "content-type": "application/json",
          "Authorization": 'key=${dotenv.get("FIREBASE_APP_KEY")}',
        },
      );
}
