import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';

String baseUrl = "http://localhost:3000/api";

enum Roles {
  admin,
  moderator,
  user,
  baned,
  unknow,
}

enum ReviewStatus {
  pending,
  rejected,
  approved,
}

enum StringName {
  refresh,
  username,
  password,
}

abstract class ApiEndpoints {
  static const String registration = "/auth/registration";
  static const String login = "/auth/login";
  static const String refresh = "/auth/refresh";

  static const String getUserById = "/user/";
  static const String addAreasToUser = "/user/areas";

  static const String getPostById = "/post/post";
  static const String getApprovedPost = "/post/";
  static const String createPost = "/post/create";
  static const String getUserPosts = "/post/user-posts/";
  static const String addLikeToPost = "/post/like";
  static const String getAllNonApprovedPosts = "/post/non-approved";

  static const String getArea = "/area/";

  static const String createComment = "/comment/create";
  static const String getPostComments = "/comment/post";
  static const String getAllNonApprovedComments = "/comment/non-approved";
}

class ShortUser {
  String username;
  String password;
  String name;
  String surname;

  ShortUser(
      {required this.username,
      required this.password,
      required this.name,
      required this.surname});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'surname': surname,
    };
  }

  Map<String, dynamic> toJsonLogin() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class ShortPost {
  String title;
  String description;
  List<String> areas;

  ShortPost({
    required this.title,
    required this.description,
    required this.areas,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'areas': areas,
    };
  }
}

class ShortComment {
  String data;
  String postId;

  ShortComment({
    required this.data,
    required this.postId,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'postId': postId,
    };
  }
}

User emptyUser = User(
    username: "no name",
    password: "",
    name: "def",
    surname: "def",
    role: Roles.unknow);

Post emptyPost = Post(
    id: "",
    title: "",
    description: "",
    status: ReviewStatus.approved,
    author: "",
    date: DateTime.now(),
    likes: 0,
    comments: [],
    areas: []);
