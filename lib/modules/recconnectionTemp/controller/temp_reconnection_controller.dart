import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/model/temp_disconnection_view_model.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/model/reading_receipt_validate_model.dart';
import 'package:gas_utility_app/modules/recconnectionTemp/model/temp_reconnection_view_model.dart';
import 'package:gas_utility_app/modules/recconnectionTemp/repository/temp_reconnection_repository.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/common_widgets/save_pop_up.dart';
import '../../../support/helper.dart';

class TempReconnectionController extends GetxController {
  TempContractReconnectionRepository tempContractReconnectionRepository =
      TempContractReconnectionRepository();
  Rx<bool> isEditModeEnabled = false.obs;
  Rx<bool> floatingIsExpanded = false.obs;
  RxnString docdate = RxnString();
  RxnString lastReadingDate = RxnString();
  RxnString tempDisconnectionDate = RxnString();
  TextEditingController txtDocNumController = TextEditingController(text: "");
  TextEditingController txtBuildingCodeController =
      TextEditingController(text: "");
  TextEditingController txtBuildingNameController =
      TextEditingController(text: "");
  TextEditingController txtApartmentCodeController =
      TextEditingController(text: "");
  TextEditingController txtContractNoController =
      TextEditingController(text: "");
  TextEditingController txtTenantNameController =
      TextEditingController(text: "");
  TextEditingController txtBranch = TextEditingController(text: "");
  TextEditingController txtCostCenter = TextEditingController(text: "");
  TextEditingController txtDivision = TextEditingController(text: "");
  TextEditingController remarks = TextEditingController(text: "");
  TextEditingController ref1 = TextEditingController(text: "");
  TextEditingController ref2 = TextEditingController(text: "");
  TextEditingController ref3 = TextEditingController(text: "");
  String? connectionDate = "";
  ReadingInvoiceReceiptValidationModel selectedReadReceipt =
      ReadingInvoiceReceiptValidationModel();
  TempReconnectionViewModel tempReconnectionViewModel =
      TempReconnectionViewModel();
  String? docYearCodeForSaving = '';

  fnClear() {
    docdate.value = null;
    lastReadingDate.value = null;
    tempDisconnectionDate.value = null;
    txtDocNumController.clear();
    txtBuildingCodeController.clear();
    txtBuildingNameController.clear();
    txtApartmentCodeController.clear();
    txtContractNoController.clear();
    txtTenantNameController.clear();
    txtBranch.clear();
    txtCostCenter.clear();
    txtDivision.clear();
    remarks.clear();
    ref1.clear();
    ref2.clear();
    ref3.clear();
    docYearCodeForSaving = '';
    tempReconnectionViewModel = TempReconnectionViewModel();
  }

  fnSaveTemporaryReconnection() async {
    showLoadingDialog();
    fnSaveValidate().then((value) {
      if (value) {
        List<Map<String, dynamic>> tblggasempReconnection = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "YEARCODE": Global.selectedCompanyYear,
            "DOCTYPE": Global.selectedDocType,
            "DOCDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "CONTRACT_NO": txtContractNoController.text,
            "PARTYCODE": txtContractNoController.text,
            "PARTYNAME": txtTenantNameController.text,
            "BUILDING_CODE": txtBuildingCodeController.text,
            "DESCP": txtBuildingNameController.text,
            "APARTMENT_CODE": txtApartmentCodeController.text,
            "REMARKS": remarks.text,
            "CREATE_USER": Global.userCD,
            "CREATE_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "BRNCODE": txtBranch.text,
            "DIVCODE": txtDivision.text,
            "CCCODE": txtCostCenter.text,
            "REF1": ref1.text,
            "REF2": ref2.text,
            "REF3": ref3.text,
            "CONNECTION_DATE": connectionDate ?? "06/11/2022",
            "CREATE_MACHINE": Global.wstrDeviceId,
            "TEMPORARY_DISCONNECT_DATE": tempDisconnectionDate.value,
          }
        ];

        final Map<String, dynamic> payLoad = {
          "TBL_GGASTEMPORARY_RECONNECTION": tblggasempReconnection,
          "MODE": "ADD"
        };
        Helper.fngetTocken().then((token) {
          if (token != null) {
            tempContractReconnectionRepository
                .fnSaveTempContractReconnection(
              token: token,
              payLoad: payLoad,
            )
                .then((response) {
              logger.e(response);
              if (Get.isDialogOpen == true) {
                Get.back();
              }
              if (response["STATUS"] == "1") {
                _fnSaveSuccess();
              } else {
                errorMsg(msg: response["MSG"]);
              }
            });
          }
        });
      }
    });
  }

  // fnGetLastTempContractReconnection(
  //     {required String docNo, required String mode}) {
  //   fnClear();
  //   Helper.fngetTocken().then((token) {
  //     if (token != null) {
  //       tempContractReconnectionRepository
  //           .fnGetLastTempContractReconnection(
  //         token: token,
  //         docno: docNo,
  //         mode: mode,
  //       )
  //           .then((tempReconnection) {
  //         if (tempReconnection != null) {
  //           fnViewFill(tempReconnection: tempReconnection);
  //           if (Get.isDialogOpen == true) {
  //             Get.back();
  //           }
  //         }
  //       });
  //     }
  //   });
  // }
  Future<void> fnGetLastTempContractReconnection({
    required String docNo,
    required String mode,
  }) async {
    fnClear();

    try {
      final token = await Helper.fngetTocken();
      if (token == null || token.isEmpty) {
        return;
      }

      final tempReconnection = await tempContractReconnectionRepository
          .fnGetLastTempContractReconnection(
        token: token,
        docno: docNo,
        mode: mode,
      );

      if (tempReconnection != null) {
        fnViewFill(tempReconnection: tempReconnection);
      }
    } catch (e) {
      logger.e("Failed to load temp reconnection: $e");
    } finally {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  fnViewFill({required TempReconnectionViewModel tempReconnection}) {
    tempReconnectionViewModel = tempReconnection;
    docdate.value = tempReconnection.docdate;
    lastReadingDate.value = tempReconnection.lastReadingDate;
    txtDocNumController.text = tempReconnection.docno ?? "0";
    txtContractNoController.text = tempReconnection.contractNo ?? "0";
    txtBuildingNameController.text = tempReconnection.descp ?? "0";
    txtBuildingCodeController.text = tempReconnection.buildingCode ?? "0";
    txtApartmentCodeController.text = tempReconnection.apartmentCode ?? "0";
    txtTenantNameController.text = tempReconnection.partyname ?? "0";
    txtBranch.text = tempReconnection.brncode ?? "";
    txtCostCenter.text = tempReconnection.cccode ?? "";
    txtDivision.text = tempReconnection.divcode ?? "";
    remarks.text = tempReconnection.remarks ?? "";
    tempDisconnectionDate.value = Helper.convertDateFormat4(
        dateTime: tempReconnection.temporaryDisconnectDate ?? "");
    ref1.text = tempReconnection.ref1 ?? "";
    ref2.text = tempReconnection.ref2 ?? "";
    ref3.text = tempReconnection.ref3 ?? "";
  }

  fnSaveValidate() async {
    if (txtContractNoController.text.isEmpty) {
      errorMsg(msg: "Select atleast one contract for disconnection");
      return false;
    }
    return true;
  }

  _fnSaveSuccess() {
    successPopup();
    isEditModeEnabled.value = false;
  }
}
