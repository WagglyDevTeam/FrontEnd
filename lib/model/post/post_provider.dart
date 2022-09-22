import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';

import '../hive/user.dart';
import 'dtos/post_college_dto.dart';

final SignInController _signInController = Get.put(SignInController());
final _token = Hive.box<User>('user').get('user')?.jwtToken;

class PostProvider extends GetConnect {
  final Map<String, String> authHeaders =
      _token != null ? {"Authorization": _token!} : {};

  Future<Response> getBoard() => get(
        "${dotenv.get('BASE_URL')}/board?college=social",
        headers: authHeaders,
      );

  Future<Response> writeBoard(FormData data) => post(
        "${dotenv.get('BASE_URL')}/board",
        data,
        headers: authHeaders,
      );

  Future<Response> getHome() => get(
        "${dotenv.get('BASE_URL')}/home",
        headers: authHeaders,
      );

  /// GET 게시판 홈 API
  Future<Response> getBoardHome() => get(
        "${dotenv.get('BASE_URL')}/board/home",
        headers: authHeaders,
      );

  /// GET 특정 학과 페이지 API
  Future<Response> getBoardCollege(String college, int page, int size) => get(
        "${dotenv.get('BASE_URL')}/board?college=$college&page=$page&size=$size",
        headers: authHeaders,
      );

  /// GET 상세페이지 API
  Future<Response> getDetailBoard(String boardId) => get(
        "${dotenv.get('BASE_URL')}/board/$boardId",
        headers: authHeaders,
      );
}
