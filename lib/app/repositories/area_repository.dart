import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/services/network_service.dart';

typedef AreaResponse = ApiResponse<AreaOfActivity>;
typedef AreasResponse = ApiResponse<List<AreaOfActivity>>;

class AreaRepository {
  final NetworkService api;

  AreaRepository(this.api);

  Future<AreaResponse> getAreaById(String areaId) async {
    var response = await api.get('${ApiEndpoints.getArea}$areaId');
    return response.when(
      loading: () => AreaResponse.loading(),
      success: (data) {
        return AreaResponse.success(
            AreaOfActivity.fromJson(data as Map<String, dynamic>));
      },
      failed: (message, exception) => AreaResponse.failed(message, exception),
    );
  }

  Future<AreasResponse> getAllAreas() async {
    var response = await api.get(ApiEndpoints.getArea);
    return response.when(
        loading: () => AreasResponse.loading(),
        success: (jsonData) {
          var temp = jsonData as List<dynamic>;
          var product = temp.map((e) => AreaOfActivity.fromJson(e)).toList();
          return AreasResponse.success(product);
        },
        failed: (message, exception) =>
            AreasResponse.failed(message, exception));
  }
}
