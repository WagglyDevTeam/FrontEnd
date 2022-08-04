import 'package:get/get.dart';
import '../models/dtos/wagglyResponseDto.dart';
import '../models/post/post.dart';
import '../models/post/post_repository.dart';

class PostController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final posts = <Post>[].obs;
  final bestPost = Post().obs;

  @override
  void onInit() async {
    super.onInit();
    await getBoard();
  }

  Future<void> getBoard() async {
    WagglyResponseDto result = await _postRepository.getBoard();
    List<dynamic> postsJson = result.datas["posts"];
    List<Post> convertedPosts = postsJson.map((e) => Post.fromJson(e)).toList();
    posts.value = convertedPosts;
    bestPost.value = Post.fromJson(result.datas["bestPost"]);
    print(posts.value[0].postTitle);
  }
}
