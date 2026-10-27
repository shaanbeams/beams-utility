import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/contract%20receipt/repository/contract_receipt_repository.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/common_widgets/save_pop_up.dart';
import '../../../support/helper.dart';
import '../view/contract_receipt_page.dart';
import '../model/charge_row_model.dart';
import '../model/contract_receipt_model.dart';
import '../model/contract_receipt_view_model.dart';

class ContractReceiptController extends GetxController {
  ContractReceiptRepository contractReceiptRepo = ContractReceiptRepository();
  Rx<ContractReceiptModel?> selectedcontractReceipt =
      ContractReceiptModel().obs;
  ContractReceiptFill selectedContractReceiptFill = ContractReceiptFill();
  RxBool floatingIsExpanded = true.obs;
  Rx<bool> isEditModeEnabled = false.obs;

  RxDouble totalAmount = 0.0.obs;
  RxDouble totalCurrAmount = 0.0.obs;
  RxDouble totalBalanceAmount = 0.0.obs;
  RxDouble totalBillAmount = 0.0.obs;
  RxDouble totalBillAmountRec = 0.0.obs;
  RxDouble totalCurrTaxAmount = 0.0.obs;
  RxDouble netAmount = 0.0.obs;
  RxnString docdate = RxnString();

  TextEditingController txtReqDocTypeController =
      TextEditingController(text: "");
  RxString selectedPaymentMode = "CASH".obs;
  TextEditingController txtCreditCard = TextEditingController(text: "");
  TextEditingController txtReqDocNo = TextEditingController(text: "");
  RxString tenantName = "".obs;
  RxList<ChargeRow> chargeRows = [
    ChargeRow(name: "Insurance"),
    ChargeRow(name: "Deposit"),
    ChargeRow(name: "Connection"),
    ChargeRow(name: "Maintenance"),
    ChargeRow(name: "Disconnection"),
    ChargeRow(name: "Registration"),
    ChargeRow(name: "Other Charge 1"),
    ChargeRow(name: "Other Charge 2"),
    ChargeRow(name: "Other Charge 3"),
    // Add other rows similarly
  ].obs;

  RxBool isInProgress = false.obs;
  ////////////////////////////function to get all total values//////////////////////
  void fnTotalAmount() {
    totalAmount.value = 0.0;
    totalCurrAmount.value = 0.0;
    totalBalanceAmount.value = 0.0;
    totalBillAmount.value = 0.0;
    totalBillAmountRec.value = 0.0;
    totalCurrTaxAmount.value = 0.0;
    netAmount.value = 0.0;

    // Loop through chargeRows and sum the required fields
    for (var row in chargeRows) {
      totalAmount.value += row.total.value;
      totalCurrAmount.value += row.currentAmt.value;
      totalBalanceAmount.value += row.balance.value;
      totalBillAmount.value += row.amount.value;
      totalBillAmountRec.value += row.amountReceived.value;
      totalCurrTaxAmount.value += row.currTaxAmount.value;
      netAmount.value = totalCurrAmount.value + totalCurrTaxAmount.value;
    }
  }

  fnEnterCrntAmt(value, index) {
    chargeRows[index].currentAmt.value =
        double.tryParse(value.toString().isEmpty ? "0.00" : value)!;
    chargeRows[index].total.value =
        double.tryParse(value.toString().isEmpty ? "0.00" : value)! +
            chargeRows[index].amountReceived.value;
    chargeRows[index].balance.value = chargeRows[index].amount.value -
        (chargeRows[index].amountReceived.value +
            chargeRows[index].currentAmt.value);
    chargeRows[index].currTaxAmount.value = chargeRows[index].currentAmt.value *
        (chargeRows[index].taxPerc.value / 100);
    fnTotalAmount();
  }

  checkNodeFocus(index) {
    if (chargeRows[index].balance.value < 0) {
      contractReceiptController.chargeRows[index].txtCurrentAmt.clear();
      chargeRows[index].currentAmt.value = 0.0;
      chargeRows[index].currTaxAmount.value = 0.0;

      chargeRows[index].txtCurrentAmt.text = "0.0";
      chargeRows[index].total.value = chargeRows[index].currentAmt.value +
          chargeRows[index].amountReceived.value;
      chargeRows[index].balance.value = chargeRows[index].amount.value -
          (chargeRows[index].amountReceived.value +
              chargeRows[index].currentAmt.value);
      fnTotalAmount();
      errorMsg(msg: "Amount Exceed", node: chargeRows[index].focusNode);
    }
  }

/////////////////////////////////////////////////////////api call////////////////////////////////////////////////
  getContractReceipt({required String contractNo}) {
    Helper.fngetTocken().then((token) {
      if (token != null) {
        contractReceiptRepo
            .getContractReceiptDetails(token: token, contractNo: contractNo)
            .then((contractReceipt) {
          _fnGetContractReceiptSuccess(
              contractReceipt: contractReceipt ?? ContractReceiptModel());
        });
      }
    });
  }

  _fnGetContractReceiptSuccess(
      {required ContractReceiptModel contractReceipt}) {
    selectedcontractReceipt.value = contractReceipt;

    _fillData();
    isInProgress.value = false;

    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  fnSaveContractReceipt() {
    if (netAmount.value != 0.0) {
      showLoadingDialog();

      Helper.fngetTocken().then((token) {
        if (token != null) {
          contractReceiptRepo
              .saveContractReceipt(
                  txtCreditCard: txtCreditCard.text,
                  selectedPaymentMode: selectedPaymentMode.value,
                  token: token,
                  selectedContractReceipt: selectedcontractReceipt.value,
                  chargeRows: chargeRows,
                  totalCurrAmount: totalCurrAmount)
              .then((value) {
            if (Get.isDialogOpen == true) {
              Get.back();
            }
            if (value["STATUS"] == "1") {
              _fnSaveContractReceiptSuccess();
            } else {
              errorMsg(msg: value != null ? value["MSG"] : "FAILED TO SAVE");
            }
          });
        }
      });
    } else {
      errorMsg(
        msg: "Net Amount is 0.00",
      );
    }
  }

  fnDeleteContractReceipt() {
    Helper.fngetTocken().then((token) {
      showLoadingDialog();
 
      if (token != null) {
        contractReceiptRepo
            .deleteContractReceiptDetails(
                docNo: selectedContractReceiptFill.docno!.toString(),
                token: token)
            .then((response) {
          if (response != null && response[0]["STATUS"] == "1") {
            Get.back();
            deletePopup();
            fngetLastContractDetails(mode: "LAST", docNo: "");
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

  _fnSaveContractReceiptSuccess() {
    // if (Get.isDialogOpen == true) {
    //   Get.back();
    // }
    fngetLastContractDetails(docNo: "", mode: "LAST");
    successPopup();
    isEditModeEnabled(false);
  }

  ////////////////////////////////////////////////
  fngetLastContractDetails({required String docNo, required String mode}) {
    //  fnclear();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        contractReceiptRepo
            .getLastContractReceiptDetails(
                token: token, docno: docNo, mode: mode)
            .then((selectedLastContract) {
          if (selectedLastContract != null) {
            selectedContractReceiptFill = selectedLastContract;
            contractReceiptRepo
                .getContractReceiptDetails(
                    token: token,
                    contractNo: selectedLastContract.contractNo ?? "0.00")
                .then((contractReceipt) {
              selectedcontractReceipt.value = contractReceipt;
              _fillViewData();
              if (Get.isDialogOpen == true) {
                Get.back();
              }
              isInProgress.value = false;
            });
          }
        });
      }
    });
  }

  _fillViewData() {
    docdate.value = selectedContractReceiptFill.docdate;
    

    txtReqDocTypeController.text =
        selectedcontractReceipt.value?.doctype?.value ?? "";
    txtReqDocNo.text = selectedContractReceiptFill.docno ?? "";

    ////Insurance////
    chargeRows[0].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.insAmt?.value);

    chargeRows[0].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.insAmtReceived?.value);

    chargeRows[0].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.insamtRecv);
    chargeRows[0].txtCurrentAmt.text =
        chargeRows[0].currentAmt.value.toString();

    chargeRows[0].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.instaxRecv);

    chargeRows[0].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.insTotalRecv);
    chargeRows[0].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.instaxPerc);
    chargeRows[0].balance.value =
        chargeRows[0].amount.value - chargeRows[0].amountReceived.value;

    ////Deposit////
    chargeRows[1].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.depAmt?.value);

    chargeRows[1].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.depAmtReceived?.value);

    chargeRows[1].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.depamtRecv);
    chargeRows[1].txtCurrentAmt.text =
        chargeRows[1].currentAmt.value.toString();

    chargeRows[1].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.deptaxRecv);

    chargeRows[1].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.depTotalRecv);
    chargeRows[1].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.deptaxPerc);
    chargeRows[1].balance.value =
        chargeRows[1].amount.value - chargeRows[1].amountReceived.value;

    ////Connection////
    chargeRows[2].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.connectionAmt?.value);

    chargeRows[2].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.connectionAmtReceived?.value);

    chargeRows[2].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.connectionAmtRecv);
    chargeRows[2].txtCurrentAmt.text =
        chargeRows[2].currentAmt.value.toString();

    chargeRows[2].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.connectionTaxRecv);

    chargeRows[2].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.connectionTotalRecv);
    chargeRows[2].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.connectionTaxPerc);
    chargeRows[2].balance.value =
        chargeRows[2].amount.value - chargeRows[2].amountReceived.value;

    ////Maintenance////
    chargeRows[3].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.maintenanceAmt?.value);

    chargeRows[3].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.maintenanceAmtReceived?.value);

    chargeRows[3].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.maintenanceAmtRecv);
    chargeRows[3].txtCurrentAmt.text =
        chargeRows[3].currentAmt.value.toString();

    chargeRows[3].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.maintenanceTaxRecv);

    chargeRows[3].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.maintenanceTotalRecv);
    chargeRows[3].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.maintenanceTaxPerc);
    chargeRows[3].balance.value =
        chargeRows[3].amount.value - chargeRows[3].amountReceived.value;

    ////Disconnection////

    chargeRows[4].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.disconnectionAmt?.value);

    chargeRows[4].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.disconnectionAmtReceived?.value);

    chargeRows[4].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.disconnectionAmtRecv);
    chargeRows[4].txtCurrentAmt.text =
        chargeRows[4].currentAmt.value.toString();

    chargeRows[4].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.disconnectionTaxRecv);

    chargeRows[4].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.disconnectionTotalRecv);
    chargeRows[4].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.disconnectionTaxPerc);
    chargeRows[4].balance.value =
        chargeRows[4].amount.value - chargeRows[4].amountReceived.value;

    ////Registration////

    chargeRows[5].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.registrationAmt?.value);

    chargeRows[5].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.registrationAmtReceived?.value);

    chargeRows[5].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.registrationAmtRecv);
    chargeRows[5].txtCurrentAmt.text =
        chargeRows[5].currentAmt.value.toString();

    chargeRows[5].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.registrationTaxRecv);

    chargeRows[5].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.registrationTotalRecv);
    chargeRows[5].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.registrationTaxPerc);
    chargeRows[5].balance.value =
        chargeRows[5].amount.value - chargeRows[5].amountReceived.value;

    ////Other Charge 1////

    chargeRows[6].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other1Amt?.value);

    chargeRows[6].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other1AmtReceived?.value);

    chargeRows[6].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.other1AmtRecv);
    chargeRows[6].txtCurrentAmt.text =
        chargeRows[6].currentAmt.value.toString();

    chargeRows[6].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.other1TaxRecv);

    chargeRows[6].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.other1TotalRecv);
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.other1TaxPerc);
    chargeRows[6].balance.value =
        chargeRows[6].amount.value - chargeRows[6].amountReceived.value;

    ////Other Charge 2////
    chargeRows[7].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other2Amt?.value);

    chargeRows[7].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other2AmtReceived?.value);

    chargeRows[7].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.other2AmtRecv);
    chargeRows[7].txtCurrentAmt.text =
        chargeRows[7].currentAmt.value.toString();

    chargeRows[7].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.other2TaxRecv);

    chargeRows[7].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.other2TotalRecv);
    chargeRows[7].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.other2TaxPerc);
    chargeRows[7].balance.value =
        chargeRows[7].amount.value - chargeRows[7].amountReceived.value;

    ////Other Charge 3////
    chargeRows[8].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other3Amt?.value);

    chargeRows[8].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other3AmtReceived?.value);

    chargeRows[8].currentAmt.value =
        Helper.mfnDbl(selectedContractReceiptFill.other3AmtRecv);
    chargeRows[8].txtCurrentAmt.text =
        chargeRows[8].currentAmt.value.toString();

    chargeRows[8].currTaxAmount.value =
        Helper.mfnDbl(selectedContractReceiptFill.other3TaxRecv);

    chargeRows[8].total.value =
        Helper.mfnDbl(selectedContractReceiptFill.other3TotalRecv);
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(selectedContractReceiptFill.other3TaxPerc);
    chargeRows[8].balance.value =
        chargeRows[8].amount.value - chargeRows[8].amountReceived.value;

    ////To Fill All value to total////
    fnTotalAmount();
  }

  _fillData() {
    txtReqDocTypeController.text =
        selectedcontractReceipt.value?.doctype?.value ?? "";
    txtReqDocNo.clear();

    ////Insurance////
    chargeRows[0].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.insAmt?.value);
    chargeRows[0].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.insAmtReceived?.value);
    // chargeRows[0].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.insTaxReceived?.value);
    chargeRows[0].taxPerc.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.insuranceVatperc?.value);
    chargeRows[0].total.value = chargeRows[0].amount.value;
    chargeRows[0].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[0].amount.value) -
                Helper.mfnDbl(chargeRows[0].amountReceived.value))
            .toString();
    chargeRows[0].currentAmt.value =
        Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text);
    chargeRows[0].currTaxAmount.value =
        chargeRows[0].currentAmt.value * (chargeRows[0].taxPerc.value / 100);
    ////Deposit////
    chargeRows[1].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.depAmt?.value);
    chargeRows[1].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.depAmtReceived?.value);
    // chargeRows[1].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.depTaxReceived?.value);
    chargeRows[1].taxPerc.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.depositVatperc?.value);
    chargeRows[1].total.value = chargeRows[1].amount.value;
    chargeRows[1].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[1].amount.value) -
                Helper.mfnDbl(chargeRows[1].amountReceived.value))
            .toString();
    chargeRows[1].currentAmt.value =
        Helper.mfnDbl(chargeRows[1].txtCurrentAmt.text);
    chargeRows[1].currTaxAmount.value =
        chargeRows[1].currentAmt.value * (chargeRows[1].taxPerc.value / 100);

    ////Connection////
    chargeRows[2].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.connectionAmt?.value);
    chargeRows[2].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.connectionAmtReceived?.value);
    // chargeRows[2].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.connectionTaxReceived?.value);
    chargeRows[2].taxPerc.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.connectionVatperc?.value);
    // chargeRows[2].balance.value = chargeRows[2].amount.value - chargeRows[2].amountReceived.value;
    // chargeRows[2].total.value = Helper.mfnDbl(selectedcontractReceipt.value?.connectionAmtReceived?.value);
    print("object${chargeRows[2].amount.value}");
    chargeRows[2].total.value = chargeRows[2].amount.value;
    chargeRows[2].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[2].amount.value) -
                Helper.mfnDbl(chargeRows[2].amountReceived.value))
            .toString();
    chargeRows[2].currentAmt.value =
        Helper.mfnDbl(chargeRows[2].txtCurrentAmt.text);
    chargeRows[2].currTaxAmount.value =
        chargeRows[2].currentAmt.value * (chargeRows[2].taxPerc.value / 100);

    ////Maintenance////
    chargeRows[3].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.maintenanceAmt?.value);
    chargeRows[3].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.maintenanceAmtReceived?.value);
    // chargeRows[3].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.maintenanceTaxReceived?.value);
    chargeRows[3].taxPerc.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.maintenanceVatperc?.value);
    // chargeRows[3].balance.value = chargeRows[3].amount.value - chargeRows[3].amountReceived.value;
    // chargeRows[3].total.value = Helper.mfnDbl(selectedcontractReceipt.value?.maintenanceAmtReceived?.value);
    chargeRows[3].total.value = chargeRows[3].amount.value;
    chargeRows[3].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[3].amount.value) -
                Helper.mfnDbl(chargeRows[3].amountReceived.value))
            .toString();
    chargeRows[3].currentAmt.value =
        Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text);
    chargeRows[3].currTaxAmount.value =
        chargeRows[3].currentAmt.value * (chargeRows[3].taxPerc.value / 100);

    ////Disconnection////
    chargeRows[4].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.disconnectionAmt?.value);
    chargeRows[4].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.disconnectionAmtReceived?.value);
    // chargeRows[4].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.disconnectionTaxReceived?.value);
    chargeRows[4].taxPerc.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.disconnectionVatperc?.value);
    // chargeRows[4].balance.value = chargeRows[4].amount.value - chargeRows[4].amountReceived.value;
    // chargeRows[4].total.value = Helper.mfnDbl(selectedcontractReceipt.value?.disconnectionAmtReceived?.value);
    chargeRows[4].total.value = chargeRows[4].amount.value;
    chargeRows[4].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[4].amount.value) -
                Helper.mfnDbl(chargeRows[4].amountReceived.value))
            .toString();
    chargeRows[4].currentAmt.value =
        Helper.mfnDbl(chargeRows[4].txtCurrentAmt.text);
    chargeRows[4].currTaxAmount.value =
        chargeRows[4].currentAmt.value * (chargeRows[4].taxPerc.value / 100);

    ////Registration////
    chargeRows[5].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.registrationAmt?.value);
    chargeRows[5].amountReceived.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.registrationAmtReceived?.value);
    // chargeRows[5].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.registrationTaxReceived?.value);
    chargeRows[5].taxPerc.value = Helper.mfnDbl(
        selectedcontractReceipt.value?.registrationVatperc?.value);
    // chargeRows[5].balance.value = chargeRows[5].amount.value - chargeRows[5].amountReceived.value;
    // chargeRows[5].total.value = Helper.mfnDbl(selectedcontractReceipt.value?.registrationAmtReceived?.value);
    chargeRows[5].total.value = chargeRows[5].amount.value;

    chargeRows[5].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[5].amount.value) -
                Helper.mfnDbl(chargeRows[5].amountReceived.value))
            .toString();
    chargeRows[5].currentAmt.value =
        Helper.mfnDbl(chargeRows[5].txtCurrentAmt.text);
    chargeRows[5].currTaxAmount.value =
        chargeRows[5].currentAmt.value * (chargeRows[5].taxPerc.value / 100);

    ////Other Charge 1////
    chargeRows[6].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other1Amt?.value);
    chargeRows[6].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other1AmtReceived?.value);
    // chargeRows[6].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.other1TaxReceived?.value);
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.otheramtVatperc?.value);
    // chargeRows[6].balance.value = chargeRows[6].amount.value - chargeRows[6].amountReceived.value;
    // chargeRows[6].total.value = Helper.mfnDbl(selectedcontractReceipt.value?.other1AmtReceived?.value);
    chargeRows[6].total.value = chargeRows[6].amount.value;
    chargeRows[6].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[6].amount.value) -
                Helper.mfnDbl(chargeRows[6].amountReceived.value))
            .toString();
    chargeRows[6].currentAmt.value =
        Helper.mfnDbl(chargeRows[6].txtCurrentAmt.text);
    chargeRows[6].currTaxAmount.value =
        chargeRows[6].currentAmt.value * (chargeRows[6].taxPerc.value / 100);

    ////Other Charge 2////
    chargeRows[7].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other2Amt?.value);
    chargeRows[7].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other2AmtReceived?.value);
    // chargeRows[7].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.other2TaxReceived?.value);
    chargeRows[7].taxPerc.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.otheramt2Vatperc?.value);
    // chargeRows[7].balance.value = chargeRows[7].amount.value - chargeRows[7].amountReceived.value;
    // chargeRows[7].total.value = Helper.mfnDbl(selectedcontractReceipt.value?.other2AmtReceived?.value);
    chargeRows[7].total.value = chargeRows[7].amount.value;
    chargeRows[7].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[7].amount.value) -
                Helper.mfnDbl(chargeRows[7].amountReceived.value))
            .toString();
    chargeRows[7].currentAmt.value =
        Helper.mfnDbl(chargeRows[7].txtCurrentAmt.text);
    chargeRows[7].currTaxAmount.value =
        chargeRows[7].currentAmt.value * (chargeRows[7].taxPerc.value / 100);

    ////Other Charge 3////
    chargeRows[8].amount.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other3Amt?.value);
    chargeRows[8].amountReceived.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.other3AmtReceived?.value);
    // chargeRows[8].taxAmtReceived.value = Helper.mfnDbl(selectedcontractReceipt.value?.other3TaxReceived?.value);
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(selectedcontractReceipt.value?.otheramt3Vatperc?.value);
    // chargeRows[8].balance.value = chargeRows[8].amount.value - chargeRows[8].amountReceived.value;
    // chargeRows[8].total.value = Helper.mfnDbl(selectedcontractReceipt.value?.other3AmtReceived?.value);
    chargeRows[8].total.value = chargeRows[8].amount.value;
    chargeRows[8].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[8].amount.value) -
                Helper.mfnDbl(chargeRows[8].amountReceived.value))
            .toString();
    chargeRows[8].currentAmt.value =
        Helper.mfnDbl(chargeRows[8].txtCurrentAmt.text);
    chargeRows[8].currTaxAmount.value =
        chargeRows[8].currentAmt.value * (chargeRows[8].taxPerc.value / 100);

    ////To Fill All value to total////
    fnTotalAmount();
  }
}
