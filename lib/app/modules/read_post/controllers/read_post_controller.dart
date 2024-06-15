import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/comment/comment.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/repositories/comment_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';

class ReadPostController extends GetxController {
  Rx<Post> post;
  final UserRepository userRepository;
  final CommentRepository commentRepository;
  final PostRepository postRepository;
  TextEditingController commentController = TextEditingController();
  User author;
  Rx<CommentsResponse> commentsResponse = CommentsResponse.loading().obs;

  ReadPostController(
      this.userRepository, this.commentRepository, this.postRepository)
      : post = (Get.arguments[0] as Post).obs,
        author = Get.arguments[1] as User;

  @override
  void onInit() {
    getComments();
    super.onInit();
  }

  void getComments() async {
    commentsResponse.value = CommentsResponse.loading();
    var response = await commentRepository.getPostComments(post.value.id);
    response.when(
      loading: () {},
      success: (List<Comment> list) {
        commentsResponse.value = CommentsResponse.success(list);
      },
      failed: (message, exception) {},
    );
  }

  void addLike() async {
    if (AuthService.to.currentUser.value.role == Roles.unknow) {
      Get.snackbar("Ошибка", "Войдите в аккаунт");
      return;
    }
    await postRepository.addLikeToPost(post.value.id);
    post.value = post.value.copyWith(likes: post.value.likes + 1);
    update();
  }

  void createComment() async {
    ShortComment data =
        ShortComment(data: commentController.text, postId: post.value.id);
    if (await commentRepository.createComment(data)) {
      Get.snackbar(
          "Успешно", "Комментарий добавлен ожидайте результатов модерации");
      commentController.clear();
    } else {
      Get.snackbar("Ошибка", "Попробуйте отправить снова!");
    }
  }

  bool canICreateComment() {
    if (AuthService.to.currentUser.value.role == Roles.unknow) {
      Get.snackbar("Ошибка", "Войдите в аккаунт");
      return false;
    }
    if (AuthService.to.currentUser.value.role == Roles.baned) {
      Get.snackbar("Вы забанены", "У вас не возможности написать комментарий");
      return false;
    }
    if (commentController.text == "") {
      Get.snackbar("Ошибка", "Сообщение не может быть пустым");
      return false;
    }
    return true;
  }
}
