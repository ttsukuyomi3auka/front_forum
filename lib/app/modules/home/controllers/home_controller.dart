import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final PostRepository postRepository;
  final Rx<PostResponse> posts = PostResponse.loading().obs;

  HomeController(this.postRepository);

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    posts.value = PostResponse.loading();
    posts.value = await postRepository.getAll();
  }
}
