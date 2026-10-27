import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/model/temp_disconnection_view_model.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/repository/temp_disconnection_repository.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/model/reading_receipt_validate_model.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/common_widgets/save_pop_up.dart';
import '../../../support/helper.dart';

class TempDisconnectionController extends GetxController {
  TempContractDisconnectionRepository tempContractDisconnectionRepository =
      TempContractDisconnectionRepository();
  Rx<bool> isEditModeEnabled = false.obs;
  Rx<bool> floatingIsExpanded = false.obs;
  RxnString docdate = RxnString();
  RxnString lastReadingDate = RxnString();
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
  TempDisconnectionViewModel tempDisconnectionViewModel =
      TempDisconnectionViewModel();
  String? docYearCodeForSaving = '';

  fnClear() {
    docdate.value = null;
    lastReadingDate.value = null;
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
    tempDisconnectionViewModel = TempDisconnectionViewModel();
  }

  fnSaveTemporaryDisconnection() async {
    showLoadingDialog();
    fnSaveValidate().then((value) {
      if (value) {
        List<Map<String, dynamic>> tblggasempdisconnection = [
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
            "CREATE_MACHINE": Global.wstrDeviceId
          }
        ];

        final Map<String, dynamic> payLoad = {
          "TBL_GGASTEMPORARY_DISCONNECTION": tblggasempdisconnection,
          "MODE": "ADD"
        };
        Helper.fngetTocken().then((token) {
          if (token != null) {
            tempContractDisconnectionRepository
                .fnSaveTempContractDisconnection(
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

  fnGetLastTempContractDisconnection(
      {required String docNo, required String mode}) {
    fnClear();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        tempContractDisconnectionRepository
            .fnGetLastTempContractDisconnection(
          token: token,
          docno: docNo,
          mode: mode,
        )
            .then((tempDisconnection) {
          if (tempDisconnection != null) {
            fnViewFill(tempDisconnection: tempDisconnection);
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          }
        });
      }
    });
  }
 

  fnViewFill({required TempDisconnectionViewModel tempDisconnection}) {
    tempDisconnectionViewModel = tempDisconnection;
    docdate.value = tempDisconnection.docdate;
    lastReadingDate.value = tempDisconnection.lastReadingDate;
    txtDocNumController.text = tempDisconnection.docno ?? "0";
    txtContractNoController.text = tempDisconnection.contractNo ?? "0";
    txtBuildingNameController.text = tempDisconnection.descp ?? "0";
    txtBuildingCodeController.text = tempDisconnection.buildingCode ?? "0";
    txtApartmentCodeController.text = tempDisconnection.apartmentCode ?? "0";
    txtTenantNameController.text = tempDisconnection.partyname ?? "0";
    txtBranch.text = tempDisconnection.brncode ?? "";
    txtCostCenter.text = tempDisconnection.cccode ?? "";
    txtDivision.text = tempDisconnection.divcode ?? "";
    remarks.text = tempDisconnection.remarks ?? "";
    ref1.text = tempDisconnection.ref1 ?? "";
    ref2.text = tempDisconnection.ref2 ?? "";
    ref3.text = tempDisconnection.ref3 ?? "";
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
