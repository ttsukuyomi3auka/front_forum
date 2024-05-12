import 'package:dio/dio.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/token/token.dart';
import 'package:front_forum/app/services/storage_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final Dio _client = Dio(BaseOptions(baseUrl: baseUrl));
  final StorageService storageService = Get.find();

  late Token _token;

  Future<AuthService> init() async {
    var refresh = storageService.readRefresh() ?? "";
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
      var response = await _client.post(ApiEndpoints.login, data: user.toJson());
      _token = Token.fromJson(response.data);
      storageService.writeRefresh(_token.refresh);
      if (response.statusCode == 200) return true;
    } catch (e) {
      printInfo(info: e.toString());
      return false;
    }
    return false;
  }
}
