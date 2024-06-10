import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/services/network_service.dart';

typedef UserResponse = ApiResponse<User>;

class UserRepository {
  final NetworkService api;

  UserRepository(this.api);

  Future<ApiResponse<User>> getUserById(String userId) async {
    var response = await api.get('${ApiEndpoints.getUserById}$userId');
    return response.when(
      loading: () => UserResponse.loading(),
      success: (data) {
        return UserResponse.success(
            User.fromJson(data as Map<String, dynamic>));
      },
      failed: (message, exception) => UserResponse.failed(message, exception),
    );
  }
}
