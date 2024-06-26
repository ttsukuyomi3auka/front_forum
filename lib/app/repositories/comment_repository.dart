import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:front_forum/app/models/comment/comment.dart';
import 'package:front_forum/app/services/network_service.dart';

typedef CommentsResponse = ApiResponse<List<Comment>>;

class CommentRepository {
  final NetworkService api;

  CommentRepository(this.api);

  Future<CommentsResponse> getPostComments(String postId) async {
    var response = await api.get("${ApiEndpoints.getPostComments}$postId");

    return response.when(
        loading: () => CommentsResponse.loading(),
        success: (jsonData) {
          var temp = jsonData as List<dynamic>;
          var comments = temp.map((e) => Comment.fromJson(e)).toList();
          return CommentsResponse.success(comments);
        },
        failed: (message, exception) =>
            CommentsResponse.failed(message, exception));
  }

  Future<CommentsResponse> getAllNonApprovedComments() async {
    var response = await api.get(ApiEndpoints.getAllNonApprovedComments);

    return response.when(
        loading: () => CommentsResponse.loading(),
        success: (jsonData) {
          var temp = jsonData as List<dynamic>;
          var comments = temp.map((e) => Comment.fromJson(e)).toList();
          return CommentsResponse.success(comments);
        },
        failed: (message, exception) =>
            CommentsResponse.failed(message, exception));
  }

  Future<bool> createComment(ShortComment data) async {
    var response = await api.create(ApiEndpoints.createComment, data.toJson());
    return response;
  }

  Future<bool> approveComment(String commentId) async {
    var response = await api.add("${ApiEndpoints.approveComment}$commentId");
    return response;
  }

  Future<bool> addLikeToComment(String commentId) async {
    var response = await api.add("${ApiEndpoints.addLikeToComment}$commentId");
    return response;
  }

  Future<bool> rejectComment(String commentId) async {
    var response = await api.add("${ApiEndpoints.rejectComment}$commentId");
    return response;
  }
}
