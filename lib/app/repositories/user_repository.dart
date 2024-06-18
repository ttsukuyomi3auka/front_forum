import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/api%20response/api_response.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/services/auth_service.dart';
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

  Future<bool> addAreasToUser(List<String> data) async {
    var response = await api.addPost(
        "${ApiEndpoints.addAreasToUser}${AuthService.to.userId}",
        {"areas": data});
    print(response);
    if (response == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> updateUser(UpdateUser data) async {
    var response = await api.addPost(
        "${ApiEndpoints.updateUser}${AuthService.to.userId}", data.toJson());
    if (response == 201) {
      return 1;
    } else if (response == 403) {
      return 2;
    } else {
      return 3;
    }
  }
}
