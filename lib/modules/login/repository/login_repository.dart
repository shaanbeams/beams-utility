import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/login/controller/login_controller.dart';
import 'package:gas_utility_app/modules/login/models/user_model.dart';
import 'package:get/get.dart';

class LoginRepository {
  final LogInController logInController = Get.find();

  /// Function to login a user
  /// Takes in [userName] and [password] as parameters
  /// Returns a [UserModel] if login is successful, or null otherwise

  Future<UserModel?> loginUser({
    required String userName,
    required String password,
  }) async {
    String message = '';

    final Map<String, String> payLoad = {
      'USER_CD': userName,
      'USER_PWD': password,
    };

    final response = await ApiService().post(url: "/api/userlogin",payloadObj:  payLoad).catchError((error) {
      print(error);
    });

    if (response != null) {
      message = response["MSG"];
      logInController.loginErrorText.value = message;
      return response["DATA"] != null ? UserModel.fromJson(response["DATA"]) : null;
    } else {
      logInController.loginErrorText.value = message;
      return null;
    }
  }
}
