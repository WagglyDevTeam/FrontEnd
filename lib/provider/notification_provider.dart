import 'package:get/get.dart';

const host = "http://54.180.108.210:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjEyNjQ4MjksImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.3OXIpFK9nJzOXS2aHUW8ZRLukaXn4RbSc8A8TvkzAEo";

class NotificationProvider extends GetConnect {
  Future<Response> getNotification() => get(
        "https://2e828a7c-3f92-4016-bd0f-a0a58904819d.mock.pstmn.io/list",
      );
}