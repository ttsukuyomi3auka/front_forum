import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/services/network_service.dart';

typedef AreaResponse = ApiResponse<AreaOfActivity>;

class AreaRepository {
  final NetworkService api;

  AreaRepository(this.api);

  Future<ApiResponse<AreaOfActivity>> getAreaById(String areaId) async {
    var response = await api.get('${ApiEndpoints.getAreaById}$areaId');
    return response.when(
      loading: () => AreaResponse.loading(),
      success: (data) {
        return AreaResponse.success(
            AreaOfActivity.fromJson(data as Map<String, dynamic>));
      },
      failed: (message, exception) => AreaResponse.failed(message, exception),
    );
  }
}
