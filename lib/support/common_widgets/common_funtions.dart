import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/lookup/repository/look_up_repo.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Future<List> fnGetGasDocMaster({required String docType}) async {
  var searchColumn = [
    {"showItem": true, "columnName": "CCCODE", "showName": "Cost Center"},
    {"showItem": true, "columnName": "BRNCODE", "showName": 'Branch Code'},
    {"showItem": true, "columnName": "DIVCODE", "showName": 'Division Code'}
  ];
  String searchColumnString =
      '${searchColumn.map((item) => item['columnName']).join('|')}|';
  List data = [];
  await Helper.fngetTocken().then((token) async {
    if (token != null) {
      await LookUpRepository()
          .getLookListData(
              token: token,
              filter: [
                {
                  'Column': "COMPANY",
                  'Operator': '=',
                  'Value': Global.selectedCompanyCode,
                  'JoinType': 'AND'
                },
                {
                  'Column': "CODE",
                  'Operator': '=',
                  'Value': docType,
                  'JoinType': 'AND'
                },
              ],
              searchColumn: searchColumnString,
              tableName: 'GASDOCMASTER')
          .then((list) {
        data.add(list[0]);
      });
    }
  });
  return data;
}

// void showLoadingDialog() {
//   Get.dialog(
//     PopScope(
//       canPop: true,
//       child:CircularProgressIndicator()
//       //  Lottie.asset("assets/lotties/loader4.json"),
//     ),
//     barrierDismissible: true,
//   );
// }
  void showLoadingDialog({String message = 'Loading..'}) {
    // Avoid opening multiple dialogs if one is already open
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      PopScope(
        canPop: false, // Prevents hardware back button from closing it mid-process
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: ThemeColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: ThemeColors.grey,
                    ),
                  ),
                  
                  // Alternative: Lottie animation
                  // Lottie.asset(
                  //   'assets/lotties/loader4.json',
                  //   width: 80,
                  //   height: 80,
                  // ),

                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(Get.context!).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false, // Prevents tapping outside to dismiss
      barrierColor: Colors.black.withOpacity(0.35), // Subtle backdrop dim
    );
  }

getBuildingName({required String buildingCode}) async {
  var searchColumn = [
    {"showItem": true, "columnName": "DESCP", "showName": "Building name"},
    
  ];
  String searchColumnString =
      '${searchColumn.map((item) => item['columnName']).join('|')}|';
  List data = [];
  await Helper.fngetTocken().then((token) async {
    if (token != null) {
      await LookUpRepository()
          .getLookListData(
              token: token,
              filter: [
                {
                  'Column': "COMPANY",
                  'Operator': '=',
                  'Value': Global.selectedCompanyCode,
                  'JoinType': 'AND'
                },
                {
                  'Column': "BUILDING_CODE",
                  'Operator': '=',
                  'Value': buildingCode,
                  'JoinType': 'AND'
                },
              ],
              searchColumn: searchColumnString,
              tableName: 'GBUILDINGMASTER')
          .then((list) {
        data.add(list[0]);
      });
    }
  });
  print(data);
  return data;
}
