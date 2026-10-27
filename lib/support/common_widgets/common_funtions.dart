import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/lookup/repository/look_up_repo.dart';
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

void showLoadingDialog() {
  Get.dialog(
    PopScope(
      canPop: true,
      child: Lottie.asset("assets/lotties/loader4.json"),
    ),
    barrierDismissible: true,
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
