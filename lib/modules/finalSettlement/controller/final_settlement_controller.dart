import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/finalSettlement/model/final_settlement_view_model.dart';
import 'package:gas_utility_app/modules/finalSettlement/model/settlement_validation_model.dart';
import 'package:gas_utility_app/modules/finalSettlement/repository/final_settlement_repository.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/repository/gas_meter_receipt_repository.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/save_pop_up.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/helper.dart';

class FinalSettlementController extends GetxController {
  FinalSettlementrepository finalSettlementrepo = FinalSettlementrepository();

  RxBool floatingIsExpanded = true.obs;
  Rx<bool> isEditModeEnabled = false.obs;
  RxnString docdate = RxnString();
  RxString tenantName = "".obs;
  GasReceiptRepository gasReceiptRepository = GasReceiptRepository();
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
  TextEditingController txtRemark =
      TextEditingController(text: "");
  RxnString connectionDate = RxnString();
  SettlementValidationModel selectedContract = SettlementValidationModel();

  FinalSettlementViewModel selectedFinalSettlement = FinalSettlementViewModel();
  // ReadingInvoiceReceiptValidationModel selectedReadReceipt =
  //     ReadingInvoiceReceiptValidationModel();
  // ViewGasInvoiceReceiptModel viewGasInvoiceReceiptModel =
  //     ViewGasInvoiceReceiptModel();
  String? docYearCodeForSaving = '';
  RxString selectedpaymentMode = "".obs;

  Rx<bool> isInProgress = false.obs;

  /////////////////////////////////////////
  TextEditingController txtNetReceivable = TextEditingController(text: "");
  TextEditingController txtNetPayable = TextEditingController(text: "");
  TextEditingController txtotalDeduction = TextEditingController(text: "");
  TextEditingController txtNetBalance = TextEditingController(text: "");
  TextEditingController txtamountpaid = TextEditingController(text: "");
  TextEditingController txtAmountPaidOrReceivable =
      TextEditingController(text: "");

  TextEditingController txtCostCenterController =
      TextEditingController(text: Global.ccCode);
  TextEditingController txtBranchController =
      TextEditingController(text: Global.brnCode);
  TextEditingController txtDivisionController =
      TextEditingController(text: Global.divCode);
  TextEditingController txtPaymentMode = TextEditingController(text: "");

  TextEditingController txtCreditCard = TextEditingController(text: "");
  TextEditingController txtChequeNo = TextEditingController(text: "");
  TextEditingController txtChequeBank = TextEditingController(text: "");
  TextEditingController txtBankDetails = TextEditingController(text: "");
  RxBool isPDC = true.obs;
  RxString chequeDate =
      Helper.convertDateFormat2(dateTime: DateTime.now().toString())
          .toString()
          .obs;

  ////////////////////////////function to get all total values//////////////////////
  // fnGetDeductionTotal() {
  //   netDeductionAmount.value = 0.0;
  //   totalCurrTaxAmount.value = 0.0;
  //   totalCurrentAmount.value = 0.0;
  //   for (ChargeRow element in deductionChargeRows) {
  //     totalCurrTaxAmount.value += element.currTaxAmount.value;
  //     totalCurrentAmount.value += element.currentAmt.value;
  //     netDeductionAmount.value =
  //         totalCurrentAmount.value + totalCurrTaxAmount.value;
  //   }
  //   chargeRows[3].txtCurrentAmt.text = netDeductionAmount.value.toString();
  //   chargeRows[5].txtCurrentAmt.text =
  //       (Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text) +
  //               Helper.mfnDbl(chargeRows[4].txtCurrentAmt.text))
  //           .toString();
  //   fnTotalAmount();
  // }

  // void fnTotalAmount() {
  //   totalNetPayable.value = 0.0;

  //   // total netpayable = net payable- (net receivable+clearance charge+disconnection balance+security deposit)

  //   double netPayable = Helper.mfnDbl(chargeRows[2].txtCurrentAmt.text) +
  //       chargeRows[2].currTaxAmount.value;
  //   double netReceivable = Helper.mfnDbl(chargeRows[5].txtCurrentAmt.text);
  //   // +
  //   // Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text);
  //   double clearance = Helper.mfnDbl(chargeRows[6].txtCurrentAmt.text) +
  //       chargeRows[6].currTaxAmount.value;
  //   double disconnection = Helper.mfnDbl(chargeRows[7].txtCurrentAmt.text) +
  //       chargeRows[7].currTaxAmount.value;
  //   double securityDeposit = Helper.mfnDbl(chargeRows[8].txtCurrentAmt.text) +
  //       chargeRows[8].currTaxAmount.value;
  //   totalNetPayable.value = netPayable -
  //       (netReceivable + clearance + disconnection + securityDeposit);
  // }

  // fnEnterCrntAmt(value, index) {
  //   deductionChargeRows[index].currentAmt.value =
  //       double.tryParse(value.toString().isEmpty ? "0.00" : value)!;
  //   deductionChargeRows[index].currTaxAmount.value =
  //       deductionChargeRows[index].currentAmt.value *
  //           (deductionChargeRows[index].taxPerc.value / 100);
  //   fnGetDeductionTotal();
  // }

/////////////////////////////////////////////////////////api call////////////////////////////////////////////////

  // getDeductionCharges() {
  //   Helper.fngetTocken().then((token) {
  //     if (token != null) {
  //       contractReceiptRepo
  //           .getDeductionCharges(token: token)
  //           .then((value) {
  //         deductionCharges = value ?? [];
  //         if (value != null && value.isNotEmpty) {
  //           deductionChargeRows.clear();
  //           for (var element in deductionCharges) {
  //             deductionChargeRows.add(ChargeRow(
  //                 name: element.code ?? "",
  //                 taxTaxPerc: double.parse(element.vat ?? "0")));
  //           }
  //         }
  //       });
  //     }
  //   });
  // }

  fnValidateContractDisconnection({
    required String contractNo,
  }) {
    showLoadingDialog();
    Helper.fngetTocken().then((token) {
      fnClear();
      if (token != null) {
        finalSettlementrepo
            .validateFinalSettlement(token: token, contractNo: contractNo)
            .then((value) {
          if (value != null) {
            if (value.headerTable![0].status == "1") {
              selectedContract = value;
              fillValidatedData();
              isEditModeEnabled.value = true;

              if (Get.isDialogOpen == true) {
                Get.back();
              }
            } else {
              if (Get.isDialogOpen == true) {
                Get.back();
              }

              errorMsg(msg: "${value.headerTable![0].msg}}");
            }
          } else {
            if (Get.isDialogOpen == true) {
              Get.back();
            }
            errorMsg(msg: "Error validating  Contract");
          }
        });
      }
    });
  }

  fillValidatedData() {
    // fnGetDeductionTotal();
    SettleValidationDetail table2 = selectedContract.settleValidationDetail![0];
    txtContractNoController.text = table2.contractNo ?? "0";
    txtBuildingNameController.text = table2.buildingDescp ?? " ";
    txtBuildingCodeController.text = table2.buildingCode ?? " ";
    txtApartmentCodeController.text = table2.apartmentCode ?? " ";
    txtTenantNameController.text = table2.partyname ?? " ";
    txtNetReceivable.text = table2.netReceivable ?? "";
    txtNetPayable.text = table2.netPayable ?? "";
    txtotalDeduction.text = table2.deduction ?? "";
    txtNetBalance.text = table2.netBalance ?? "";
    txtamountpaid.text = table2.amtPaid ?? "0.00";
    txtAmountPaidOrReceivable.text = table2.netBalance ?? "";
  }

  fngetPaymentFieldsToShowFields() {}

  fnClear() {
    docdate.value = null;
    // lastReadingDate.value = null;
    // connectionDate.value = null;
    txtDocNumController.clear();
    txtBuildingCodeController.clear();
    txtBuildingNameController.clear();
    txtApartmentCodeController.clear();
    txtContractNoController.clear();
    txtTenantNameController.clear();
    docYearCodeForSaving = '';
    selectedpaymentMode.value = "";
    txtNetReceivable.clear();
    txtNetPayable.clear();
    txtotalDeduction.clear();
    txtNetBalance.clear();
    txtamountpaid.clear();
    txtAmountPaidOrReceivable.clear();
    txtCostCenterController.clear();
    txtBranchController.clear();
    txtDivisionController.clear();
    txtPaymentMode.clear();
    txtCreditCard.clear();
    txtChequeNo.clear();
    txtChequeBank.clear();
    txtBankDetails.clear();
    isPDC = true.obs;
    chequeDate.value =
        Helper.convertDateFormat2(dateTime: DateTime.now().toString());
  }

  fnSaveFinalSettlement() async {
    fnSaveValidate().then((value) {
      if (value) {
        showLoadingDialog();
        List<Map<String, dynamic>> tblgasContractSettle = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "YEARCODE": Global.selectedCompanyYear,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "DOCDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "ACCODE": "",
            "SLCODE": "",
            "ACDESCP": "",
            "SLDESCP": "",
            "PARTYCODE": txtContractNoController.text,
            "PARTYNAME": txtTenantNameController.text,
            "BUILDING_CODE": txtBuildingCodeController.text,
            "DESCP": txtBuildingNameController.text,
            "CONTRACT_NO": txtContractNoController.text,
            "APARTMENT_CODE": txtApartmentCodeController.text,
            "AMT": txtAmountPaidOrReceivable.text,
            "SMAN": "",
            "CHQBANK":
                selectedpaymentMode.value == "CHEQUE" ? txtChequeBank.text : "",
            "CHQBANKDESCP": selectedpaymentMode.value == "CHEQUE"
                ? txtBankDetails.text
                : "",
            "PAYMODE": selectedpaymentMode.value,
            "REMITTO": "",
            "CHQNO":
                selectedpaymentMode.value == "CHEQUE" ? txtChequeNo.text : "",
            "CHQDATE":
                selectedpaymentMode.value == "CHEQUE" ? chequeDate.value : "",
            "PDC_YN": selectedpaymentMode.value == "CHEQUE"
                ? isPDC.value == true
                    ? "Y"
                    : "N"
                : "",
            "REMARKS": txtRemark.text,
            "CREATE_USER": Global.userCD,
            "CREATE_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "CREDITCARD": selectedpaymentMode.value == "CREDITCARD"
                ? txtCreditCard.text
                : "",
            "PAY_TO": "",
            "BRNCODE": txtBranchController.text,
            "DIVCODE": txtDivisionController.text,
            "CCCODE": txtCostCenterController.text,
            "NET_RECEIVABLE": txtNetReceivable.text,
            "NET_PAYABLE": txtNetPayable.text,
            "CASHFLOW_CAT": "",
            "INS_AMT": 0,
            "NET_INS_AMT": 0,
            "DEPOSIT": 0,
            "NET_DEPOSIT": 0,
            "INVOICE": 0,
            "INVOICE_TAX": 0,
            "INVOICE_RECEIVED": 0,
            "NET_INVOICE": 0,
            "MAINTENANCE": 0,
            "MAINTENANCE_TAX": 0,
            "NET_MAINTENANCE": 0,
            "SECURITY_DEP": 0,
            "SECURITY_DEP_TAX": 0,
            "NET_SECURITY_DEP": 0,
            "CLEARANCE": 0,
            "CLEARANCE_TAX": 0,
            "NET_CLEARANCE": 0,
            "DISCONNECTION": 0,
            "DISCONNECTION_TAX": 0,
            "NET_DISCONNECTION": 0,
            "DED": 0,
            "DED_TAX": 0,
            "NET_DED": txtotalDeduction.text,
            "NET_AMTPAID": txtamountpaid.text,
            "NET_NETBAL": txtNetBalance.text
          }
        ];

        final Map<String, dynamic> payLoad = {
          "TBL_GASCONTRACTSETTLE": tblgasContractSettle,
          "MODE": "ADD"
        };
        Helper.fngetTocken().then((token) {
          if (token != null) {
            finalSettlementrepo
                .fnSaveFinalSettlement(
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
    fnGetLastFinalSettlement(mode: "LAST", docNo: "");
  }

  fnSaveValidate() async {
    if (txtContractNoController.text.isEmpty) {
      errorMsg(msg: "Select atleast one contract for disconnection");
      return false;
    }
    if (txtPaymentMode.text.isEmpty) {
      errorMsg(msg: "Select atleast one payment mode");
      return false;
    }
    if (txtPaymentMode.text == "CREDITCARD") {
      if (txtCreditCard.text.isEmpty) {
        errorMsg(msg: "Choose the credit card");
        return false;
      }
    }
    if (txtPaymentMode.text == "CHEQUE") {
      if (txtChequeNo.text.isEmpty) {
        errorMsg(msg: "Enter cheque Number");
        return false;
      } else if (txtChequeBank.text.isEmpty) {
        errorMsg(msg: "Choose cheque bank");
        return false;
      }
    }
    return true;
  }

  fnGetLastFinalSettlement({required String docNo, required String mode}) {
    fnClear();

    Helper.fngetTocken().then((token) {
      if (token != null) {
        finalSettlementrepo
            .fnGetLastFinalSettlement(token: token, docno: docNo, mode: mode)
            .then((value) {
          if (value != null) {
            selectedFinalSettlement = value;
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

  _fillViewData() {
    docdate.value = selectedFinalSettlement.docdate;
    txtDocNumController.text = selectedFinalSettlement.docno ?? "";
    txtContractNoController.text = selectedFinalSettlement.contractNo ?? "0";
    txtBuildingNameController.text = selectedFinalSettlement.descp ?? "";
    txtBuildingCodeController.text = selectedFinalSettlement.buildingCode ?? "";
    txtApartmentCodeController.text =
        selectedFinalSettlement.apartmentCode ?? "";
    txtTenantNameController.text = selectedFinalSettlement.partyname ?? "";
    selectedpaymentMode.value = selectedFinalSettlement.paymode ?? "";

    txtNetReceivable.text = selectedFinalSettlement.netReceivable ?? "";
    txtNetPayable.text = selectedFinalSettlement.netPayable ?? "";
    txtotalDeduction.text = selectedFinalSettlement.netDed ?? "";
    txtNetBalance.text = selectedFinalSettlement.netNetbal ?? "";
    txtamountpaid.text = selectedFinalSettlement.netAmtpaid ?? "";
    txtAmountPaidOrReceivable.text = selectedFinalSettlement.amt ?? "";
    txtCostCenterController.text = selectedFinalSettlement.cccode ?? "";
    txtBranchController.text = selectedFinalSettlement.brncode ?? "";
    txtDivisionController.text = selectedFinalSettlement.divcode ?? "";
    txtPaymentMode.text = selectedFinalSettlement.paymode ?? "";
    txtCreditCard.text = selectedFinalSettlement.creditcard ?? "";
    txtChequeNo.text = selectedFinalSettlement.chqno ?? "";
    txtChequeBank.text = selectedFinalSettlement.chqbank ?? "";
    txtBankDetails.text = selectedFinalSettlement.chqbankdescp ?? "";
    isPDC.value = selectedFinalSettlement.pdcYn == 'Y' ? true : false;
    chequeDate.value = selectedFinalSettlement.chqdate != ""
        ? Helper.convertDateFormat1(
            dateTime: selectedFinalSettlement.chqdate ?? "")
        : "";
  }

  fnDeleteGasInvoiceReceipt() {
    Helper.fngetTocken().then((token) {
      showLoadingDialog();

      if (token != null) {
        gasReceiptRepository
            .deleteInvoiceReceipt(docNo: txtDocNumController.text, token: token)
            .then((response) {
          if (response != null && response[0]["STATUS"] == "1") {
            Get.back();
            deletePopup();
            // fngetLastContractDetails(mode: "LAST", docNo: "");
          } else {
            Get.back();
            errorMsg(
                msg:
                    response != null ? response[0]["MSG"] : "FAILED TO DELETE");
          }
        });
      }
    });
  }
}
