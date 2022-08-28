import 'package:get/get.dart';

const host = "http://54.180.108.210:8080";

const jwtToken =
    "BEARER eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJFWFBJUkVEX0RBVEUiOjE2NjEyNjQ4MjksImlzcyI6IndhZ2dseSIsIlVTRVJfTkFNRSI6IndhZ2dseV90ZXN0NEB3YWdnbHkuY29tIn0.3OXIpFK9nJzOXS2aHUW8ZRLukaXn4RbSc8A8TvkzAEo";

class MyPostsListProvider extends GetConnect {
  Future<Response> getMyPosts() => get(
        "$host/user/post?page=0&size=10",
        headers: {"Authorization": jwtToken},
      );
}
