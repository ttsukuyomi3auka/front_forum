import 'package:front_forum/app/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late SharedPreferences prefs;

  Future<StorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  void writeRefresh(String refresh) async =>
      await prefs.setString(StringName.refresh.name, refresh);

  String? readRefresh() => prefs.getString(StringName.refresh.name);
}
