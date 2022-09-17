import 'package:get/get.dart';
import '../../model/post/dtos/post_request_dto.dart';
import '../../model/post/dtos/waggly_response_dto.dart';
import '../../model/post/post.dart';
import '../../model/post/post_repository.dart';

class PostController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final posts = <Post>[].obs;
  final bestPost = Post().obs;
  final isButtonActivate = false.obs;

  @override
  void onInit() async {
    super.onInit();
    // await getBoard();
  }

  Future<void> getBoard() async {
    WagglyResponseDto result = await _postRepository.getBoard();
    List<dynamic> postsJson = result.datas["posts"];
    List<Post> convertedPosts = postsJson.map((e) => Post.fromJson(e)).toList();
    posts.value = convertedPosts;
    bestPost.value = Post.fromJson(result.datas["bestPost"]);
  }

  Future<void> writeBoard(PostRequestDto postRequestDto) async {
    FormData form = FormData(postRequestDto.toJson());
    await _postRepository.writeBoard(form);
  }
}
