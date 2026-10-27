import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/home/controller/home_controller.dart';
import 'package:gas_utility_app/modules/login/models/user_model.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

class SelectDocTypeRepository {
  final HomeController homeController = Get.find();

  /// Function to login a user
  /// Takes in [userName] and [password] as parameters
  /// Returns a [UserModel] if login is successful, or null otherwise

  Future<dynamic> selectDoxType({required String mDoc, required String token}) async {
    String message = '';

    final Map<String, String> payLoad = {"COMPANY": Global.selectedCompanyCode, "USER_CD": Global.userCD, "MDOC": mDoc};

    final response = await ApiService().post(url: "/api/getMenuByMdoc", payloadObj: payLoad, token: token).catchError((error) {
      print(error);
    });

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }
}
