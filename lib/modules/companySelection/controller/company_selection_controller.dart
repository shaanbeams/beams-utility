import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

import '../repository/company_selection_repository.dart';

class CompanySelectionController extends GetxController {
  static CompanySelectionRepository companySelectionRepo = CompanySelectionRepository();
  RxList companyList = [].obs;
  RxList yearList = [].obs;
  @override
  void onInit() {
    fnGetCompany();
    super.onInit();
  }

  fnGetCompany() async {
    companySelectionRepo.selectCompany().then(
      (value) {
        // var value = jsonDecode(value1); 
        if (value[0]["Table1"] != null && value[0]["Table1"].isNotEmpty) {
          fnGetCompanySuccess(value);
        } else {
          Get.snackbar("", "Company Selection Failed");
        }

        // Get.offAll(CompanySelectionPageExe());
      },
    );
    // .then((val) {
    //   fnLoginSuccess();
    // });
  }

  fnGetCompanyYear({yearCode}) async {
    companySelectionRepo.selectCompanyYear(yearCode: yearCode).then(
      (value) {
        // var value = jsonDecode(value1);
        if (value[0]["Table1"] != null && value[0]["Table1"].isNotEmpty) {
          fnGetCompanyYearSuccess(value);
        } else {
          if (value[0]["Table1"].isEmpty) {
            yearList.clear();
          } else {
            Get.snackbar("", "Company Selection Failed");
          }
        }
        // Get.offAll(CompanySelectionPageExe());
      },
    );
    // .then((val) {
    //   fnLoginSuccess();
    // });
  }

  fnGetCompanyYearSuccess(values) {
    yearList.assignAll(values[0]["Table1"]);
    Global.selectedCompanyYear = values[0]["Table1"][0]["YEARCODE"];
  }

  fnGetCompanySuccess(values) {
    companyList.assignAll(values[0]["Table1"]);
    Global.selectedCompanyCodeWithName = values[0]["Table1"][0]["COMPANY_CODE"];
    // fnGetCompanyYear();
  }
}
