import 'package:front_forum/app/models/comment/comment.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/repositories/comment_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:get/get.dart';

class ModerationController extends GetxController {
  final PostRepository postRepository;
  final CommentRepository commentRepository;
  final Rx<PostResponse> posts = PostResponse.loading().obs;
  final Rx<CommentsResponse> comments = CommentsResponse.loading().obs;

  ModerationController(this.commentRepository, this.postRepository);

  @override
  void onInit() {
    getPosts();
    getComments();
    super.onInit();
  }

  void getPosts() async {
    posts.value = PostResponse.loading();
    var response = await postRepository.getAllNonApprovedPosts();

    response.when(
      loading: () {},
      success: (List<Post> list) {
        posts.value = PostResponse.success(list);
      },
      failed: (message, exception) {
        posts.value = PostResponse.failed(message, exception);
      },
    );
  }

  void getComments() async {
    comments.value = CommentsResponse.loading();
    var response = await commentRepository.getAllNonApprovedComments();

    response.when(
      loading: () {},
      success: (List<Comment> list) {
        comments.value = CommentsResponse.success(list);
      },
      failed: (message, exception) {
        comments.value = CommentsResponse.failed(message, exception);
      },
    );
  }

  void approvePost(String postId) async {
    if (await postRepository.approvePost(postId)) {
      getPosts();
    }
  }

  void rejectPost(String postId) async {
    if (await postRepository.rejectPost(postId)) {
      getPosts();
    }
  }
}
