import 'package:dio/dio.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:front_forum/app/models/token/token.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart' hide Response;

class NetworkService extends GetxService {
  final Dio _client = Dio(BaseOptions(baseUrl: baseUrl));
  late Token token;

  static NetworkService get to => Get.find();

  Future<NetworkService> init() async {
    _client.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        token = AuthService.to.token;
        options.headers.addAll({'Authorization': 'Bearer ${token.access}'});
        return handler.next(options);
      }, onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401 &&
            e.response?.extra["isRetry"] == null) {
          if (await AuthService.to.refresh()) {
            token = AuthService.to.token;
            return handler.resolve(await _retry(e.requestOptions.copyWith(
              extra: {"isRetry": true},
            )));
          }
        }
        handler.reject(e);
      }),
    );
    return this;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    final response = await _client.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
    return response;
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
