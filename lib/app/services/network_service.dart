import 'package:dio/dio.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  final Dio _client = Dio(BaseOptions(baseUrl: baseUrl));

  Future<NetworkService> init() async {
    return this;
  }

  

  Future<ApiResponse<T>> get<T>(String url) async {
    try {
      var response = await _client.get(url);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.failed(e.message ?? 'Dio error', e.error);
    } catch (e) {
      printInfo(info: e.toString());
      return ApiResponse.failed(e.toString(), e);
    }
  }

  Future<ApiResponse<T>> post<T>(String url, dynamic data) async {
    try {
      var response = await _client.post(url, data: data);
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.failed(e.message ?? 'Dio error', e.error);
    } catch (e) {
      printInfo(info: e.toString());
      return ApiResponse.failed(e.toString(), e);
    }
  }
}
