import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

class CompanySelectionRepository {
  /////
  ///
  ///Splash
  ///
  Future<dynamic> selectCompany() async {
    final Map<String, String> payLoad = {"MAIN_COMPANYCODE": Global.mainCompany};

    final response = await ApiService().post(url: "/api/GetCompany", payloadObj: payLoad, headerRequired: false).catchError((error) {
      print(error);
    });
    if (response == null) {
      Get.snackbar("", "Company Selection Failed");
      return null;
    } else {
      return response;
    }
  }

  Future<dynamic> selectCompanyYear({yearCode}) async {
    final Map<String, String> payLoad = {"MAIN_COMPANYCODE": Global.mainCompany, "COMPANY": yearCode};

    final response = await ApiService().post(url: "/api/GetYearcode", payloadObj: payLoad, headerRequired: false).catchError((error) {
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
