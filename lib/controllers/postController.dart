import 'package:get/get.dart';
import 'package:wagly/models/dtos/postRequestDto.dart';
import '../models/dtos/wagglyResponseDto.dart';
import '../models/post/post.dart';
import '../models/post/postRepository.dart';

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
    print(posts[0].postTitle);
  }

  Future<void> writeBoard(PostRequestDto postRequestDto) async {
    FormData form = FormData(postRequestDto.toJson());
    await _postRepository.writeBoard(form);
    // print(result);
  }
}
