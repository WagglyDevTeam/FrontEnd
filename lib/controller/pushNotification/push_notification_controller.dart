import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:waggly/firebase_options.dart';
import 'package:waggly/provider/push_notification_provider.dart';

class PushNotificationController extends GetxController {
  // static PushNotificationController get to => Get.find();

  final PushNotificationProvider _pushNotificationProvider = PushNotificationProvider();
  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();

  Future<bool> initialize() async {
    // Firebase 초기화부터 해야 Firebase Messaging 을 사용할 수 있다.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.instance.getInitialMessage();

    // Android 에서는 별도의 확인 없이 리턴되지만, requestPermission()을 호출하지 않으면 수신되지 않는다.
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage rm) {
      if (rm.notification != null) {
        message.value = rm;
        print(message);
      } else {
        print("no notification");
      }
    });
    return true;
  }

  Future<String> getToken() async {
    final String? token = await FirebaseMessaging.instance.getToken();
    return token!;
  }

  Future<void> sendPushMessage(String token, String title, String body) async {
    print("푸시푸시");
    var result = await _pushNotificationProvider.sendPushMessage(token, body, title);
    print(result.body);
  }
}
