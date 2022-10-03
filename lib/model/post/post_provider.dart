import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:waggly/controller/signIn/sign_in_conroller.dart';
import 'package:waggly/model/post/dtos/post_detail_dto.dart';
import '../hive/user.dart';
import 'dtos/post_college_dto.dart';

import '../hive/user.dart';

final SignInController _signInController = Get.put(SignInController());
final _token = Hive.box<User>('user').get('user')?.jwtToken;

class PostProvider extends GetConnect {
  final Map<String, String> authHeaders = _token != null ? {"Authorization": _token!} : {};

  Future<Response> getBoard() => get(
        "${dotenv.get('BASE_URL')}/board?college=social",
        headers: authHeaders,
      );

  Future<Response> writeBoard(FormData data) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return post(
      "${dotenv.get('BASE_URL')}/board",
      data,
      headers: {"Authorization": token!},
    );
  }

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
  Future<Response> getBoardCollege(String college, int page, int size) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return get(
      "${dotenv.get('BASE_URL')}/board?college=$college&page=$page&size=$size",
      headers: {"Authorization": token!},
    );
  }

  /// GET 상세페이지 API
  Future<Response> getDetailBoard(String boardId) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return get(
      "${dotenv.get('BASE_URL')}/board/$boardId",
      headers: {"Authorization": token!},
    );
  }

  /// POST comment
  Future<Response> postComment(String? postId, CommentRequestDto data) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return post(
      "${dotenv.get('BASE_URL')}/comment/$postId",
      data.toJson(),
      headers: {"Authorization": token!},
    );
  }

  /// POST comment
  Future<Response> postReComment(int commentId, ReCommentRequestDto data) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return post(
      "${dotenv.get('BASE_URL')}/reply/$commentId",
      data.toJson(),
      headers: {"Authorization": token!},
    );
  }

  Future<Response> likeDetailPost(int postId, likeDetailRequestDto data) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return put(
      "${dotenv.get('BASE_URL')}/board/$postId/like",
      data.toJson(),
      headers: {"Authorization": token!},
    );
  }

  Future<Response> PostDelete(int postId) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    return delete(
      "${dotenv.get('BASE_URL')}/board/$postId",
      headers: {"Authorization": token!},
    );
  }

  Future<Response> editBoard(FormData data, dynamic value) {
    final box = Hive.box<User>('user');
    var token = box.get('user')?.jwtToken;
    print("여기임");
    print(authHeaders);
    return put(
      "${dotenv.get('BASE_URL')}/board/$value",
      data,
      headers: {"Authorization": token!},
    );
  }
}
