import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/disconnectionRequest/model/disconnection_request_model.dart';
import 'package:gas_utility_app/modules/disconnectionRequest/repository/disconnection_request_repository.dart';
import 'package:gas_utility_app/modules/disconnectionRequest/view/disconnection_request_page.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/save_pop_up.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/helper.dart';

class DisconnectionRequestController extends GetxController {
  DisconnectionRequestRepository disconnectionRequestRepository =
      DisconnectionRequestRepository();

  RxBool floatingIsExpanded = true.obs;
  Rx<bool> isEditModeEnabled = false.obs;
  RxnString docdate = RxnString();
  RxString tenantName = "".obs;
  // GasReceiptRepository gasReceiptRepository = GasReceiptRepository();
  RxnString expctedDisconnectionRequest = RxnString();
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

  RxnString expctedDate = RxnString();
  TextEditingController txtIBANNo = TextEditingController(text: "");
  TextEditingController txtAccountNo = TextEditingController(text: "");

  TextEditingController txtRemark = TextEditingController(text: "");

  // SettlementValidationModel selectedContract = SettlementValidationModel();

  DiconnectionRequestModel diconnectionRequest = DiconnectionRequestModel();
  // ReadingInvoiceReceiptValidationModel selectedReadReceipt =
  //     ReadingInvoiceReceiptValidationModel();
  // ViewGasInvoiceReceiptModel viewGasInvoiceReceiptModel =
  //     ViewGasInvoiceReceiptModel();
  String? docYearCodeForSaving = '';
  RxString selectedpaymentMode = "".obs;
  Rx<bool> isInProgress = false.obs;

  // fnValidateContractDisconnection({
  //   required String contractNo,
  // }) {
  //   showLoadingDialog();
  //   Helper.fngetTocken().then((token) {
  //     fnClear();
  //     if (token != null) {
  //       disconnectionRequestRepository
  //           .validateFinalSettlement(token: token, contractNo: contractNo)
  //           .then((value) {
  //         if (value != null) {
  //           if (value.headerTable![0].status == "1") {
  //             // selectedContract = value;
  //             fillValidatedData();
  //             isEditModeEnabled.value = true;

  //             if (Get.isDialogOpen == true) {
  //               Get.back();
  //             }
  //           } else {
  //             if (Get.isDialogOpen == true) {
  //               Get.back();
  //             }

  //             errorMsg(msg: "${value.headerTable![0].msg}}");
  //           }
  //         } else {
  //           if (Get.isDialogOpen == true) {
  //             Get.back();
  //           }
  //           errorMsg(msg: "Error validating  Contract");
  //         }
  //       });
  //     }
  //   });
  // }

  // fillValidatedData() {
  //   // fnGetDeductionTotal();
  //   SettleValidationDetail table2 = selectedContract.settleValidationDetail![0];
  //   txtContractNoController.text = table2.contractNo ?? "0";
  //   txtBuildingNameController.text = table2.buildingDescp ?? " ";
  //   txtBuildingCodeController.text = table2.buildingCode ?? " ";
  //   txtApartmentCodeController.text = table2.apartmentCode ?? " ";
  //   txtTenantNameController.text = table2.partyname ?? " ";

  // }

  fnClear() {
    docdate.value = null;
    txtDocNumController.clear();
    txtBuildingCodeController.clear();
    txtBuildingNameController.clear();
    txtApartmentCodeController.clear();
    txtContractNoController.clear();
    txtTenantNameController.clear();
    docYearCodeForSaving = '';
    selectedpaymentMode.value = "";
    txtAccountNo.clear();
    txtIBANNo.clear();
    expctedDate.value = null;
  }

  fnSaveDisconnectionRequest() async {
    fnSaveValidate().then((value) {
      if (value) {
        showLoadingDialog();

        final Map<String, dynamic> payLoad = {
          "COMPANY": Global.selectedCompanyCode,
          "DOCTYPE": Global.selectedDocType,
          "CONTRACT_NO": txtContractNoController.text,
          "DOCDATE":
              Helper.convertDateTime(dateTime: DateTime.now().toString()),
          "EXPT_DISCONNECTION_DATE":
              expctedDate.value ?? DateTime.now().toString(),
          "IBAN": txtIBANNo.text,
          "BANK_ACNO": txtAccountNo.text
        };
        Helper.fngetTocken().then((token) {
          if (token != null) {
            disconnectionRequestRepository
                .fnSaveDisconnectionRequest(
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

  _fnSaveSuccess() {
    successPopup();
    isEditModeEnabled.value = false;
    fnGetLastDisconnectionRequest(mode: "LAST", docNo: "");
  }

  fnSaveValidate() async {
    if (txtIBANNo.text.isEmpty) {
      errorMsg(msg: "Please enter IBAN number");
      return false;
    }
    if (txtAccountNo.text.isEmpty) {
      errorMsg(msg: "Please enter the account No");
      return false;
    }

    return true;
  }

  fnGetLastDisconnectionRequest({required String docNo, required String mode}) {
    fnClear();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        disconnectionRequestRepository
            .fnGetLastDisconnectionRequest(
                token: token, docno: docNo, mode: mode)
            .then((value) {
          if (value != null) {
            diconnectionRequest = value;
            _fillViewData();
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          } else {
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          }
        });
      }
    });
  }

//convertDateFormat1
  _fillViewData() {
    getBuildingName(buildingCode: diconnectionRequest.buildingCode??"")
        .then((value) {
       txtBuildingNameController.text =
          value[0]["DESCP"];
    });

    docdate.value = diconnectionRequest.docdate;
    txtDocNumController.text = diconnectionRequest.docno ?? "";
    txtContractNoController.text = diconnectionRequest.contractNo ?? "0";
    // txtBuildingNameController.text = diconnectionRequest.descp ?? "";
    txtBuildingCodeController.text = diconnectionRequest.buildingCode ?? "";
    txtApartmentCodeController.text = diconnectionRequest.apartmentCode ?? "";
    txtTenantNameController.text = diconnectionRequest.partyname ?? "";
    expctedDate.value = Helper.convertDateFormat4(dateTime:diconnectionRequest. expDisconnectionDate??"") ;
    txtIBANNo.text = diconnectionRequest.ibanNo ?? "";
    txtAccountNo.text = diconnectionRequest.bankAcno ?? "";
  }

  // fnDeleteGasInvoiceReceipt() {
  //   Helper.fngetTocken().then((token) {
  //     showLoadingDialog();

  //     if (token != null) {
  //       gasReceiptRepository
  //           .deleteInvoiceReceipt(docNo: txtDocNumController.text, token: token)
  //           .then((response) {
  //         if (response != null && response[0]["STATUS"] == "1") {
  //           Get.back();
  //           deletePopup();
  //           // fngetLastContractDetails(mode: "LAST", docNo: "");
  //         } else {
  //           Get.back();
  //           errorMsg(
  //               msg:
  //                   response != null ? response[0]["MSG"] : "FAILED TO DELETE");
  //         }
  //       });
  //     }
  //   });
  // }
}
