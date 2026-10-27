import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/contract%20receipt/model/charge_row_model.dart';
import 'package:gas_utility_app/modules/contract%20receipt/repository/contract_receipt_repository.dart';
import 'package:gas_utility_app/modules/contractDisconnection/model/contract_deduction_validation_model.dart';
import 'package:gas_utility_app/modules/contractDisconnection/model/deduction_model.dart';
import 'package:gas_utility_app/modules/contractDisconnection/model/disconnection_view_model.dart';
import 'package:gas_utility_app/modules/contractDisconnection/repository/contract_disconnection_repository.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/model/reading_receipt_validate_model.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/model/view_gas_invoice_receipt.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/repository/gas_meter_receipt_repository.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/save_pop_up.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/helper.dart';

class ContractDisconnectionController extends GetxController {
  ContractReceiptRepository contractReceiptRepo = ContractReceiptRepository();
  ContractDisconnectionRepository contractDisconnectionRepo =
      ContractDisconnectionRepository();

  RxBool floatingIsExpanded = true.obs;
  Rx<bool> isEditModeEnabled = false.obs;
  RxDouble totalNetAmount = 0.0.obs;
  RxDouble totalNetTax = 0.0.obs;
  RxDouble totalNetPayable = 0.0.obs;
  RxDouble totalCurrentAmount = 0.0.obs;
  RxDouble totalCurrTaxAmount = 0.0.obs;
  RxDouble netDeductionAmount = 0.0.obs;
  RxnString docdate = RxnString();
  TextEditingController txtCreditCard = TextEditingController(text: "");
  RxString tenantName = "".obs;
  RxList<ChargeRow> chargeRows = [
    ChargeRow(name: "Insurance"),
    ChargeRow(name: "Deposit"),
    ChargeRow(name: "Net payable"),
    ChargeRow(name: "Total deduction"),
    ChargeRow(name: "Consumption balance"),
    ChargeRow(name: "Net receivable"),
    ChargeRow(name: "Clearance charge"),
    ChargeRow(name: "Disconnection charge"),
    ChargeRow(name: "Security deposit"),
  ].obs;
  RxList<ChargeRow> deductionChargeRows = <ChargeRow>[].obs;
  RxBool isInProgress = false.obs;
  List<DeductionChargeModel> deductionCharges = <DeductionChargeModel>[];
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
  RxnString connectionDate = RxnString();
  ContratDisconnectionValidationModel selectedContract =
      ContratDisconnectionValidationModel();
  ContractDisViewModel selectedviewContractRefund = ContractDisViewModel();
  ReadingInvoiceReceiptValidationModel selectedReadReceipt =
      ReadingInvoiceReceiptValidationModel();
  ViewGasInvoiceReceiptModel viewGasInvoiceReceiptModel =
      ViewGasInvoiceReceiptModel();
  String? docYearCodeForSaving = '';

  ////////////////////////////function to get all total values//////////////////////
  fnGetDeductionTotal() {
    netDeductionAmount.value = 0.0;
    totalCurrTaxAmount.value = 0.0;
    totalCurrentAmount.value = 0.0;
    for (ChargeRow element in deductionChargeRows) {
      totalCurrTaxAmount.value += element.currTaxAmount.value;
      totalCurrentAmount.value += double.parse(element.txtCurrentAmt.text != ""
          ? element.txtCurrentAmt.text
          : "0.00");
    }
    netDeductionAmount.value =
        totalCurrentAmount.value + totalCurrTaxAmount.value;
    chargeRows[3].txtCurrentAmt.text = netDeductionAmount.value.toString();
    chargeRows[5].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text) +
                Helper.mfnDbl(chargeRows[4].txtCurrentAmt.text))
            .toString();
    fnTotalAmount();
  }

  void fnTotalAmount() {
    totalNetPayable.value = 0.0;

    // total netpayable = net payable- (net receivable+clearance charge+disconnection balance+security deposit)

    double netPayable = Helper.mfnDbl(chargeRows[2].txtCurrentAmt.text) +
        chargeRows[2].currTaxAmount.value;
    double netReceivable = Helper.mfnDbl(chargeRows[5].txtCurrentAmt.text);
    double clearance = Helper.mfnDbl(chargeRows[6].txtCurrentAmt.text) +
        chargeRows[6].currTaxAmount.value;
    double disconnection = Helper.mfnDbl(chargeRows[7].txtCurrentAmt.text) +
        chargeRows[7].currTaxAmount.value;
    double securityDeposit = Helper.mfnDbl(chargeRows[8].txtCurrentAmt.text) +
        chargeRows[8].currTaxAmount.value;

    totalNetAmount.value = Helper.mfnDbl(chargeRows[2].txtCurrentAmt.text) -
        (Helper.mfnDbl(chargeRows[5].txtCurrentAmt.text) +
            Helper.mfnDbl(chargeRows[6].txtCurrentAmt.text) +
            Helper.mfnDbl(chargeRows[7].txtCurrentAmt.text) +
            Helper.mfnDbl(chargeRows[8].txtCurrentAmt.text));
    totalNetTax.value = chargeRows[2].currTaxAmount.value -
        (chargeRows[5].currTaxAmount.value +
            chargeRows[6].currTaxAmount.value +
            chargeRows[7].currTaxAmount.value +
            chargeRows[8].currTaxAmount.value);

    totalNetPayable.value = totalNetAmount.value + totalNetTax.value;

    // totalNetPayable.value = netPayable -
    //     (netReceivable + clearance + disconnection + securityDeposit);
  }

  fnEnterCrntAmt(value, index) {
    deductionChargeRows[index].currentAmt.value =
        double.tryParse(value.toString().isEmpty ? "0.00" : value)!;
    deductionChargeRows[index].currTaxAmount.value =
        deductionChargeRows[index].currentAmt.value *
            (deductionChargeRows[index].taxPerc.value / 100);
    fnGetDeductionTotal();
  }

/////////////////////////////////////////////////////////api call////////////////////////////////////////////////

  getDeductionCharges() {
    Helper.fngetTocken().then((token) {
      if (token != null) {
        contractDisconnectionRepo
            .getDeductionCharges(token: token)
            .then((value) {
          deductionCharges = value ?? [];
          if (value != null && value.isNotEmpty) {
            deductionChargeRows.clear();
            for (var element in deductionCharges) {
              deductionChargeRows.add(ChargeRow(
                  name: element.code ?? "",
                  taxTaxPerc: double.parse(element.vat ?? "0")));
            }
          }
        });
      }
    });
  }

  fnValidateContractDisconnection({
    required String contractNo,
  }) {
    showLoadingDialog();
    Helper.fngetTocken().then((token) {
      fnClear();
      if (token != null) {
        contractDisconnectionRepo
            .validateContractDisconnection(token: token, contractNo: contractNo)
            .then((value) {
          if (value != null) {
            if (value.table1![0].status == "1") {
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

              errorMsg(msg: "${value.table1![0].msg}}");
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
    fnGetDeductionTotal();
    //  if (selectedContract.table2! == null ||
    //     selectedContract.table2!.isEmpty) return;
    ContratDisTable2 table2 = selectedContract.table2![0];
    txtContractNoController.text = table2.contractNo ?? "0";
    txtBuildingNameController.text = table2.buildingDescp ?? " ";
    txtBuildingCodeController.text = table2.buildingCode ?? " ";
    txtApartmentCodeController.text = table2.apartmentCode ?? " ";
    txtTenantNameController.text = table2.partyname ?? " ";
    connectionDate.value = table2.connectionDate;
    lastReadingDate.value = table2.lastReadingDate;
    ///////////////////////amount//////////////

    //==================insurance===============//

    chargeRows[0].txtCurrentAmt.text =
        Helper.mfnDbl(table2.insAmtReceived).toString();
    chargeRows[0].taxPerc.value = Helper.mfnDbl(table2.insuranceVatperc);
    chargeRows[0].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text),
        chargeRows[0].taxPerc.value));

    //=================Deposit==================//

    chargeRows[1].txtCurrentAmt.text =
        Helper.mfnDbl(table2.depAmtReceived).toString();

    //================Net Payable================//
    // netpayable = insurance + deposit

    chargeRows[2].txtCurrentAmt.text = (Helper.mfnDbl(table2.depAmtReceived) +
            Helper.mfnDbl(table2.insAmtReceived))
        .toString();
    chargeRows[2].currTaxAmount.value = chargeRows[0].currTaxAmount.value;
    //===============Total deduction ================//
    // sum of deduction charges

    chargeRows[3].txtCurrentAmt.text = netDeductionAmount.value.toString();

    //===============Consumption ================//

    chargeRows[4].txtCurrentAmt.text =
        Helper.mfnDbl(table2.consumptionAmt).toString();
    //===============net REceivable ================//
    // net REceivable = deduction + consumption

    chargeRows[5].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text) +
                Helper.mfnDbl(chargeRows[4].txtCurrentAmt.text))
            .toString();
    //===============clearance charge ================//
    chargeRows[6].txtCurrentAmt.text =
        Helper.mfnDbl(table2.clearanceAmt).toString();
    chargeRows[6].taxPerc.value = Helper.mfnDbl(table2.clearanceVatperc);
    chargeRows[6].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[6].txtCurrentAmt.text),
        chargeRows[6].taxPerc.value));
    //===============disconnection charge ================//
    chargeRows[7].txtCurrentAmt.text =
        Helper.mfnDbl(table2.balanceDisconnectionAmt).toString();
    chargeRows[7].taxPerc.value = Helper.mfnDbl(table2.disconnectionVatperc);
    chargeRows[7].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[7].txtCurrentAmt.text),
        chargeRows[7].taxPerc.value));
    //===============security charge ================//
    chargeRows[8].txtCurrentAmt.text =
        Helper.mfnDbl(table2.securityDepReturnAmt).toString();
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(table2.securityDepReturnTaxPerc);
    chargeRows[8].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[8].txtCurrentAmt.text),
        chargeRows[8].taxPerc.value));

    fnTotalAmount();
  }

  fnClear() {
    docdate.value = null;
    lastReadingDate.value = null;
    connectionDate.value = null;
    txtDocNumController.clear();
    txtBuildingCodeController.clear();
    txtBuildingNameController.clear();
    txtApartmentCodeController.clear();
    txtContractNoController.clear();
    txtTenantNameController.clear();
    docYearCodeForSaving = '';
    viewGasInvoiceReceiptModel = ViewGasInvoiceReceiptModel();
    totalCurrTaxAmount.value = 0.0;
    netDeductionAmount.value = 0.0;
    totalCurrTaxAmount.value = 0.0;
    totalCurrentAmount.value = 0.0;
    totalNetPayable.value = 0.0;
    chargeRows.clear();
    chargeRows = [
      ChargeRow(name: "Insurance"),
      ChargeRow(name: "Deposit"),
      ChargeRow(name: "Net payable"),
      ChargeRow(name: "Total deduction"),
      ChargeRow(name: "Consumption balance"),
      ChargeRow(name: "Net receivable"),
      ChargeRow(name: "Clearance charge"),
      ChargeRow(name: "Disconnection charge"),
      ChargeRow(name: "Security deposit"),
    ].obs;
    for (var element in deductionChargeRows) {
      element.txtCurrentAmt.text = "0.00";
      element.currTaxAmount.value = 0.0;
    }
  }

  fnSaveContractDisconnection() async {
    fnSaveValidate().then((value) {
      if (value) {
        showLoadingDialog();
        List<Map<String, dynamic>> tblggasContractRefund = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "YEARCODE": Global.selectedCompanyYear,
            "DOCTYPE": Global.selectedDocType,
            "DOCDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "CONTRACT_NO": txtContractNoController.text,
            "PARTYCODE": selectedContract.table2?.first.partycode ?? "",
            "PARTYNAME": txtTenantNameController.text,
            "BUILDING_CODE": txtBuildingCodeController.text,
            "DESCP": txtBuildingNameController.text,
            "APARTMENT_CODE": txtApartmentCodeController.text,
            "REMARKS": "",
            "TOTAL_DEDUCTION_AMT": netDeductionAmount.value,
            "TOTAL_GAS_AMT": chargeRows[4].txtCurrentAmt.text,
            "TOTAL_REC_AMT": chargeRows[5].txtCurrentAmt.text,
            "INS_AMT_REFUNDED": chargeRows[0].txtCurrentAmt.text,
            "DEP_AMT_REFUNDED": chargeRows[1].txtCurrentAmt.text,
            "TOTAL_AMT_REFUNDED": chargeRows[2].txtCurrentAmt.text,
            "NET_PAY_AMT": totalNetAmount.value,
            "CREATE_USER": Global.userCD,
            "CREATE_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "BRNCODE": Global.brnCode,
            "DIVCODE": Global.divCode,
            "CCCODE": Global.ccCode,
            "CLEARANCE_AMT": chargeRows[6].txtCurrentAmt.text,
            "VAT_PERC_INSURANCE": chargeRows[0].taxPerc.value,
            "VAT_AMT_INSURANCE": chargeRows[0].currTaxAmount.value,
            "VAT_AMT_NETPAYABLE": chargeRows[2].currTaxAmount.value,
            "VAT_AMT_DEDUCTION": chargeRows[3].currTaxAmount.value,
            "VAT_PERC_CONSUMPTION": chargeRows[4].taxPerc.value,
            "VAT_AMT_CONSUMPTION": chargeRows[4].currTaxAmount.value,
            "VAT_AMT_NETRECEIVABLE": chargeRows[5].currTaxAmount.value,
            "VAT_PERC_CLEARANCE": chargeRows[6].taxPerc.value,
            "VAT_AMT_CLEARANCE": chargeRows[6].currTaxAmount.value,
            "VAT_AMT_NETPAYREC": totalNetTax.value,
            "DELIVERY_EMIRATE": "",
            "REF1": "",
            "REF2": "",
            "REF3": "",
            "SECURITY_DEP_RETURN_AMT": chargeRows[8].txtCurrentAmt.text,
            "VAT_PERC_SECURITY_DEP_RETURN ": chargeRows[8].taxPerc.value,
            "VAT_AMT_SECURITY_DEP_RETURN": chargeRows[8].currTaxAmount.value,
            "DISCONNECTION_AMT": chargeRows[7].txtCurrentAmt.text,
            "VAT_PERC_DISCONNECTION": chargeRows[7].taxPerc.value,
            "VAT_AMT_DISCONNECTION": chargeRows[7].currTaxAmount.value,
            "CASHFLOW_CAT": "",
            "CONNECTION_DATE": Helper.convertDateFormat4(
                dateTime: selectedContract.table2!.first.connectionDate ??
                    DateTime.now().toString()),
            "DISCONNECTION_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "CONTRACT_NO_BASE64": ""
          }
        ];
        List<Map<String, dynamic>> tblgGasContractRefundDet =
            deductionChargeRows.map((s) {
          return {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "YEARCODE": Global.selectedCompanyYear,
            "DOCDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "SRNO": deductionChargeRows.indexOf(s) + 1,
            "CHARGE_TYPE":
                deductionCharges[deductionChargeRows.indexOf(s)].code,
            "CHARGE_TYPE_DESCP":
                deductionCharges[deductionChargeRows.indexOf(s)].descp,
            "DEDUCTION_AMT": deductionChargeRows[deductionChargeRows.indexOf(s)]
                .txtCurrentAmt
                .text,
            "VAT_PERC": deductionChargeRows[deductionChargeRows.indexOf(s)]
                .taxPerc
                .value,
            "VAT_AMT": deductionChargeRows[deductionChargeRows.indexOf(s)]
                .currTaxAmount
                .value,
            "REMARKS": "",
            "CONTRACT_NO": txtContractNoController.text,
            "PARTYCODE": selectedContract.table2?.first.partycode ?? "",
            "PARTYNAME": txtTenantNameController.text,
            "TOTAL_DEDUCTION_AMT": chargeRows[3].txtCurrentAmt.text,
            "BRNCODE": Global.brnCode,
            "DIVCODE": Global.divCode,
            "CCCODE": Global.ccCode,
            "CASHFLOW_CAT": "",
            "BUILDING_CODE": txtBuildingCodeController.text,
            "APARTMENT_CODE": txtApartmentCodeController.text
          };
        }).toList();

        final Map<String, dynamic> payLoad = {
          "TBL_GGASCONTRACTREFUND": tblggasContractRefund,
          "TBL_GGASCONTRACTREFUND_DEDDET": tblgGasContractRefundDet,
          "MODE": "ADD"
        };
        Helper.fngetTocken().then((token) {
          if (token != null) {
            contractDisconnectionRepo
                .fnSaveContractDisconnection(
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
    fnGetLastContractDisconnection(mode: "LAST", docNo: "");
  }

  fnSaveValidate() async {
    if (txtContractNoController.text.isEmpty) {
      errorMsg(msg: " Select atleast one contract for disconnection");
      return false;
    }
    return true;
  }

  fnGetLastContractDisconnection(
      {required String docNo, required String mode}) {
    fnClear();

    // showLoadingDialog();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        contractDisconnectionRepo
            .fnGetLastContractDisconnection(
                token: token, docno: docNo, mode: mode)
            .then((value) {
          if (value != null) {
            selectedviewContractRefund = value;
            _fillViewData();
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          }
        });
      }
    });
  }

  _fillViewData() {
    if (selectedviewContractRefund.headerTable == null ||
        selectedviewContractRefund.headerTable!.isEmpty) return;
    Map<String, String>? _headerDetails =
        selectedviewContractRefund.headerTable?.first;
    docdate.value = _headerDetails?['DOCDATE'];

    // txtReqDocTypeController.text = _headerDetails?['DOCTYPE'] ?? "";
    txtDocNumController.text = _headerDetails?['DOCNO'] ?? "";
    txtContractNoController.text = _headerDetails?["CONTRACT_NO"] ?? "0";
    txtBuildingNameController.text = _headerDetails?["DESCP"] ?? "";
    txtBuildingCodeController.text = _headerDetails?["BUILDING_CODE"] ?? "";
    txtApartmentCodeController.text = _headerDetails?["APARTMENT_CODE"] ?? "";
    txtTenantNameController.text = _headerDetails?["PARTYNAME"] ?? "";
    connectionDate.value = Helper.convertDateFormat1(
            dateTime: _headerDetails?["CONNECTION_DATE"] ??
                DateTime.now().toString()) ??
        "";
    lastReadingDate.value = _headerDetails?["DOCDATE"] ?? "";
    totalNetPayable.value =
        (Helper.mfnDbl(_headerDetails?["NET_PAY_AMT"] ?? "0.00"));

    ///////////////////////amount//////////////
    //==================insurance===============//

    chargeRows[0].txtCurrentAmt.text =
        Helper.mfnDbl(_headerDetails?["INS_AMT_REFUNDED"]).toString();
    chargeRows[0].taxPerc.value =
        Helper.mfnDbl(_headerDetails?["VAT_PERC_INSURANCE"]);
    chargeRows[0].currTaxAmount.value =
        Helper.mfnDbl(_headerDetails?["VAT_AMT_INSURANCE"]);

    //=================Deposit==================//

    chargeRows[1].txtCurrentAmt.text =
        Helper.mfnDbl(_headerDetails?["DEP_AMT_REFUNDED"]).toString();

    //================Net Payable================//
    // netpayable = insurance + deposit

    chargeRows[2].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[1].txtCurrentAmt.text) +
                Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text))
            .toString();
    chargeRows[2].currTaxAmount.value = chargeRows[0].currTaxAmount.value;
    //===============Total deduction ================//
    // sum of deduction charges

    chargeRows[3].txtCurrentAmt.text =
        Helper.mfnDbl(_headerDetails?["TOTAL_DEDUCTION_AMT"]).toString();
    //  netDeductionAmount.value.toString();

    //===============Consumption ================//

    chargeRows[4].txtCurrentAmt.text =
        Helper.mfnDbl(_headerDetails?["TOTAL_GAS_AMT"]).toString();
    //===============net REceivable ================//
    // net REceivable = deduction + consumption

    chargeRows[5].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text) +
                Helper.mfnDbl(chargeRows[4].txtCurrentAmt.text))
            .toString();
    //===============clearance charge ================//
    chargeRows[6].txtCurrentAmt.text =
        Helper.mfnDbl(_headerDetails?["CLEARANCE_AMT"]).toString();
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(_headerDetails?["VAT_PERC_CLEARANCE"]);
    chargeRows[6].currTaxAmount.value =
        Helper.mfnDbl(_headerDetails?["VAT_AMT_CLEARANCE"]);

    //===============disconnection charge ================//
    chargeRows[7].txtCurrentAmt.text =
        Helper.mfnDbl(_headerDetails?["DISCONNECTION_AMT"]).toString();
    chargeRows[7].taxPerc.value =
        Helper.mfnDbl(_headerDetails?["VAT_PERC_DISCONNECTION"]);
    chargeRows[7].currTaxAmount.value =
        Helper.mfnDbl(_headerDetails?["VAT_AMT_DISCONNECTION"]);

    //===============security charge ================//

    chargeRows[8].txtCurrentAmt.text =
        Helper.mfnDbl(_headerDetails?["SECURITY_DEP_RETURN_AMT"]).toString();
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(_headerDetails?["VAT_PERC_SECURITY_DEP_RETURN"]);
    chargeRows[8].currTaxAmount.value =
        Helper.mfnDbl(_headerDetails?["VAT_AMT_SECURITY_DEP_RETURN"]);

    ////////////////////////deduction charges/////////////////////////////////////////////////
    // for (var element in deductionCharges) {
    //           deductionChargeRows.add(ChargeRow(
    //               name: element.code ?? "",
    //               taxTaxPerc: double.parse(element.vat ?? "0")));
    //         }
    if (selectedviewContractRefund.chargesTable != null ||
        selectedviewContractRefund.chargesTable!.isNotEmpty) {
      for (ChargesTable charge
          in selectedviewContractRefund.chargesTable ?? <ChargesTable>[]) {
        if (deductionChargeRows.isNotEmpty) {
          int tempIndex =
              // selectedviewContractRefund.chargesTable!.indexOf(charge);
              deductionChargeRows.indexWhere(
                  (chargeRow) => chargeRow.name == charge.chargeType);
          deductionChargeRows[tempIndex].txtCurrentAmt.text =
              charge.deductionAmt ?? "0.00";
          deductionChargeRows[tempIndex].name = charge.chargeType ?? "";
          deductionChargeRows[tempIndex].taxPerc.value =
              Helper.mfnDbl(charge.vatPerc ?? "");
          deductionChargeRows[tempIndex].currTaxAmount.value =
              Helper.mfnDbl(charge.vatAmt ?? "");
        }
      }
    }

    fnGetDeductionTotal();
  }

  //   txtReqDocTypeController.text =
  //       selectedcontractReceipt.value?.doctype?.value ?? "";
  //   txtReqDocNo.clear();

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
