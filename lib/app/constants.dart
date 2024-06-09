String baseUrl = "http://localhost:3000/api";

enum Roles {
  admin,
  moderator,
  user,
  baned,
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
