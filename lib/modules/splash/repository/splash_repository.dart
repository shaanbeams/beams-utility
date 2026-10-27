import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';

class SplashRepository {
  /////
  ///
  ///Splash
  ///
  Future<dynamic> selectMainCompany({required String maincompany}) async {
    final Map<String, String> payLoad = {"MAIN_COMPANYCODE": maincompany};

    final response = await ApiService().post(url: "/api/ValidateMainCompany",payloadObj:  payLoad,headerRequired:  false).catchError((error) {
      print(error);
    });
    if (response == null) {
      Get.snackbar("", "Company Selection Failed");
      return null;
    } else {
      return response;
    }
  }
}
