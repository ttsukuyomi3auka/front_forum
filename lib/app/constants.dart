String baseUrl = "http://localhost:3000/api";

enum Roles {
  admin,
  moderator,
  user,
  baned,
}

enum StringName {
  refresh,
  username,
  password,
}

abstract class ApiEndpoints {
  static const String registration = "/auth/registration";
  static const String login = "/auth/login";
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
