import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/services/network_service.dart';

typedef PostResponse = ApiResponse<List<Post>>;

class PostRepository {
  final NetworkService api;

  PostRepository(this.api);

  Future<PostResponse> getAll() async {
    var response = await api.get(ApiEndpoints.getApprovedPost);

    return response.when(
        loading: () => PostResponse.loading(),
        success: (jsonData) {
          var temp = jsonData as List<dynamic>;
          var product = temp.map((e) => Post.fromJson(e)).toList();
          return PostResponse.success(product);
        },
        failed: (message, exception) =>
            PostResponse.failed(message, exception));
  }

  Future<PostResponse> getAllNonApprovedPosts() async {
    var response = await api.get(ApiEndpoints.getAllNonApprovedPosts);

    return response.when(
        loading: () => PostResponse.loading(),
        success: (jsonData) {
          var temp = jsonData as List<dynamic>;
          var product = temp.map((e) => Post.fromJson(e)).toList();
          return PostResponse.success(product);
        },
        failed: (message, exception) =>
            PostResponse.failed(message, exception));
  }

  Future<bool> createPost(ShortPost data) async {
    var response = await api.create(ApiEndpoints.createPost, data.toJson());
    return response;
  }

  Future<bool> approvePost(String postId) async {
    var response = await api.add("${ApiEndpoints.approvePost}$postId");
    return response;
  }

  Future<bool> rejectPost(String postId) async {
    var response = await api.add("${ApiEndpoints.rejectPost}$postId");
    return response;
  }

  Future<bool> addLikeToPost(String postId) async {
    var response = await api.add("${ApiEndpoints.addLikeToPost}$postId");
    return response;
  }

  Future<PostResponse> getUserPosts(String userId) async {
    var response = await api.get("${ApiEndpoints.getUserPosts}$userId");

    return response.when(
        loading: () => PostResponse.loading(),
        success: (jsonData) {
          var temp = jsonData as List<dynamic>;
          var product = temp.map((e) => Post.fromJson(e)).toList();
          return PostResponse.success(product);
        },
        failed: (message, exception) =>
            PostResponse.failed(message, exception));
  }

  Future<ApiResponse<Post>> getPostById(String postId) async {
    var response = await api.get("${ApiEndpoints.getPostById}$postId");
    return response.when(
      loading: () => ApiResponse<Post>.loading(),
      success: (data) {
        return ApiResponse<Post>.success(
            Post.fromJson(data as Map<String, dynamic>));
      },
      failed: (message, exception) =>
          ApiResponse<Post>.failed(message, exception),
    );
  }
}
