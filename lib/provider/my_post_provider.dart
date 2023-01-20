import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/hive/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


final token = Hive.box<User>('user').get('user')?.jwtToken;


class MyPostsListProvider extends GetConnect {
  final Map<String, String> authHeaders = token != null ? {"Authorization": token!} : {};
  /// 내가 쓴 포스트 가져오기
  Future<Response> getMyPosts(int page, int size ) => get(
        "${dotenv.get('BASE_URL')}/user/post?page=$page&size=$size",
        headers: {"Authorization": token!},
      );
}
