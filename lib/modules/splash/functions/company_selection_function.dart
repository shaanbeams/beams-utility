// import 'dart:convert';
//
// import 'package:gas_utility_app/modules/splash/company_selection_controller.dart';
// import 'package:gas_utility_app/modules/splash/company_selection_repository.dart';
// import 'package:get/get.dart';
//
// class CompanySelectionFunctions {
//   static CompanySelectionRepository companySelectionRepo = CompanySelectionRepository();
//   CompanySelectionController companySelectionController = CompanySelectionController();
//
//   fnGetCompany() async {
//     companySelectionRepo.selectCompany().then(
//       (value1) {
//         var value = jsonDecode(value1);
//         if (value[0]["Table1"] != null && value[0]["Table1"].isNotEmpty) {
//           fnGetCompanySuccess(value);
//         } else {
//           Get.snackbar("", "Company Selection Failed");
//         }
//
//         // Get.offAll(CompanySelectionPageExe());
//       },
//     );
//     // .then((val) {
//     //   fnLoginSuccess();
//     // });
//   }
//
//   fnGetCompanySuccess(values) {
//     companySelectionController.companyList.assignAll(values[0]["Table1"]);
//   }
// }
