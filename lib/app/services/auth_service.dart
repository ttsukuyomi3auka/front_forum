import 'package:dio/dio.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/token/token.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService extends GetxService {
  final Dio _client = Dio(BaseOptions(baseUrl: baseUrl));
  final StorageService storageService = Get.find();
  late Token _token;
  Rx<User> currentUser = emptyUser.obs;
  late String userId = "";

  static AuthService get to => Get.find();
  Token get token => _token;

  Future<AuthService> init() async {
    var refresh = storageService.readRefresh();
    _token = Token(access: "", refresh: refresh);
    return this;
  }

  Future<bool> registration(ShortUser user) async {
    try {
      var response =
          await _client.post(ApiEndpoints.registration, data: user.toJson());
      if (response.statusCode == 201) return true;
    } catch (e) {
      printInfo(info: e.toString());
      return false;
    }
    return false;
  }

  Future<bool> login(ShortUser user) async {
    try {
      var response =
          await _client.post(ApiEndpoints.login, data: user.toJsonLogin());
      _token = Token.fromJson(response.data);
      await storageService.writeRefresh(_token.refresh);
      Map<String, dynamic> decodedToken = Jwt.parseJwt(_token.access);
      userId = decodedToken['id'];
      if (response.statusCode == 200) {
        await loadCurrentUser();
        return true;
      }
    } catch (e) {
      printInfo(info: e.toString());
      return false;
    }
    return false;
  }

  Future<bool> refresh() async {
    try {
      var response = await _client.post(
        ApiEndpoints.refresh,
        data: {'refresh': _token.refresh},
      );

      if (response.statusCode == 200) {
        _token = Token.fromJson(response.data);
        await storageService.writeRefresh(_token.refresh);
        Map<String, dynamic> decodedToken = Jwt.parseJwt(_token.access);
        userId = decodedToken['id'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      printInfo(info: e.toString());
      return false;
    }
  }

  Future<void> loadCurrentUser() async {
    try {
      var response = await _client.get('${ApiEndpoints.getUserById}$userId');
      if (response.statusCode == 200) {
        currentUser.value = User.fromJson(response.data);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  bool isLoggedIn() {
    if (token.access != "") {
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    currentUser.value = emptyUser;
    userId = "";
    _token = Token(access: "", refresh: "");
  }
}
