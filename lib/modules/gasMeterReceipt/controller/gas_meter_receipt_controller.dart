import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/view/gas_meter_receipt_page.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/view/gas_meter_receipt_page_exe.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/repository/gas_meter_receipt_repository.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/model/reading_receipt_validate_model.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/model/view_gas_invoice_receipt.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/common_widgets/save_pop_up.dart';
import '../../../support/helper.dart';

class GasMeterReadingReceiptController extends GetxController {
  GasReceiptRepository gasReceiptRepository = GasReceiptRepository();
  RxBool floatingIsExpanded = false.obs;

  Rx<bool> isEditModeEnabled = false.obs;
  ReadingInvoiceReceiptValidationModel selectedReadReceipt =
      ReadingInvoiceReceiptValidationModel();
  RxString selectedPaymentMode = "CASH".obs;
  TextEditingController txtCreditCard = TextEditingController(text: "");
  RxnString docdate = RxnString();
  RxnString lastReadingDate = RxnString();
  TextEditingController txtDocNumController = TextEditingController(text: "");
  TextEditingController txtBuildingCodeController =
      TextEditingController(text: "");
  TextEditingController txtBuildingNameController =
      TextEditingController(text: "");
  TextEditingController txtApartmentCodeController =
      TextEditingController(text: "");
  TextEditingController txtLastInvoice = TextEditingController(text: "");
  TextEditingController txtContractNoController =
      TextEditingController(text: "");
  TextEditingController txtInvoiceAmount = TextEditingController(text: "");
  TextEditingController txtLastPaidController = TextEditingController(text: "");
  TextEditingController txtOutStandingAmtController =
      TextEditingController(text: "");
  TextEditingController txtReceivedAmtController =
      TextEditingController(text: "");

  TextEditingController txtTenantNameController =
      TextEditingController(text: "");
  TextEditingController txtInvoiceNoController =
      TextEditingController(text: "");
  TextEditingController txtPartyCodeController =
      TextEditingController(text: "");

  ViewGasInvoiceReceiptModel viewGasInvoiceReceiptModel =
      ViewGasInvoiceReceiptModel();

  // String? InvNoForSaving = '';
  String? InvTypeForSaving = '';
  String? docYearCodeForSaving = '';
  fnClear() {
    // Reset RxString and RxnString fields
    selectedPaymentMode.value = "CASH";
    docdate.value = null;
    lastReadingDate.value = null;

    // Clear TextEditingControllers
    txtCreditCard.clear();
    txtDocNumController.clear();
    txtBuildingCodeController.clear();
    txtBuildingNameController.clear();
    txtApartmentCodeController.clear();
    txtLastInvoice.clear();
    txtContractNoController.clear();
    txtInvoiceAmount.clear();
    txtLastPaidController.clear();
    txtOutStandingAmtController.clear();
    txtTenantNameController.clear();
    txtPartyCodeController.clear();
    txtInvoiceNoController.clear();
    txtReceivedAmtController.clear();

    // Clear any other variables
    // InvNoForSaving = '';
    InvTypeForSaving = '';
    docYearCodeForSaving = '';

    // Clear or reset viewGasInvoiceReceiptModel as needed
    viewGasInvoiceReceiptModel = ViewGasInvoiceReceiptModel();
  }

  ////DOCUMENT VIEW /////
  fnGetLastGasMeterReceipt({required String docNo, required String mode}) {
    fnClear();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        gasReceiptRepository
            .getLastData(token: token, docno: docNo, mode: mode, docType: "")
            .then((selectedLastMeterReading) {
          if (selectedLastMeterReading != null) {
            viewGasInvoiceReceiptModel = selectedLastMeterReading;
            fnViewFill(selectedLastMeterReading: selectedLastMeterReading);
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          }
        });
      }
    });
  }

  fillValidatedData() {
    // txtDocNumController.text = selectedReadReceipt.docno ?? "0";
    txtContractNoController.text = selectedReadReceipt.contractNo ?? "0";
    txtBuildingNameController.text = selectedReadReceipt.buildingName ?? "0";
    txtBuildingCodeController.text = selectedReadReceipt.buildingCode ?? "0";
    txtApartmentCodeController.text = selectedReadReceipt.apartmentCode ?? "0";
    txtTenantNameController.text = selectedReadReceipt.partyname ?? "0";
    txtPartyCodeController.text = selectedReadReceipt.partycode ?? "0";
    txtLastInvoice.text = selectedReadReceipt.invoiceDeposit ?? "0";
    txtOutStandingAmtController.text =
        (double.parse(selectedReadReceipt.netAmount ?? "0") -
                double.parse(selectedReadReceipt.paidAmt ?? "0"))
            .toString();
    // selectedReadReceipt.receivedamt ?? "0";
    txtLastPaidController.text = selectedReadReceipt.paidAmt ?? "0";
    txtInvoiceAmount.text = selectedReadReceipt.netAmount ?? "0";
    txtInvoiceNoController.text = selectedReadReceipt.docno ?? "";
    txtReceivedAmtController.text =
        double.parse(txtOutStandingAmtController.text) < 0
            ? "0.00"
            : txtOutStandingAmtController.text;
    //  selectedReadReceipt.receivedamt ?? "0";

    // lastReadingDate.value = selectedReadReceipt.lastReadingDate ;

    // fnTotalAmount();
  }

  fnViewFill({required ViewGasInvoiceReceiptModel selectedLastMeterReading}) {
    if (selectedLastMeterReading.table1 == null ||
        selectedLastMeterReading.table1!.isEmpty) {
      return;
    }
    logger.f(selectedLastMeterReading.table2?[0].paidAmt);
    Table1 table1 = selectedLastMeterReading.table1![0];
    Table2 table2 = selectedLastMeterReading.table2![0];
    txtDocNumController.text = table1.docno ?? "0";
    txtContractNoController.text = table2.contractNo ?? "0";
    txtBuildingNameController.text = table2.buildingName ?? "0";
    txtBuildingCodeController.text = table2.buildingCode ?? "0";
    txtApartmentCodeController.text = table2.apartmentCode ?? "0";
    txtTenantNameController.text = table2.partyName ?? "0";
    txtPartyCodeController.text = table2.partyCode ?? "0";
    txtLastInvoice.text = table1.invnoFrom ?? "0";
    lastReadingDate.value = table2.lastRecDate;
    txtInvoiceAmount.text = table2.invAmt ?? "0";
    txtLastPaidController.text = table2.paidAmt ?? "0";
    txtInvoiceNoController.text = table1.docno ?? "";
    txtOutStandingAmtController.text = (double.parse(table2.invAmt ?? "0") -
            double.parse(table2.paidAmt ?? "0") -
            double.parse(table2.recAmt ?? "0"))
        .toStringAsFixed(3)
        // txtOutStandingAmtController.text =
        //     (double.parse(selectedReadReceipt.netAmount ?? "0") -
        //             double.parse(selectedReadReceipt.paidAmt ?? "0") -
        //             double.parse(table2.recAmt ?? "0"))
        .toString();
    //  table2.recAmt ?? "0";
    selectedPaymentMode.value = table1.payMode ?? "";
    txtCreditCard.text = table2.creditCard ?? "";
    txtReceivedAmtController.text = table2.recAmt ?? "0";
  }

  fnSaveValidate() async {
    if (double.parse(txtReceivedAmtController.text) == 0) {
      errorMsg(msg: "Received Amount cant be zero");
      return false;
    }
    return true;
  }

  ////DELETE DATA/////
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

  ////SAVE INVOICE RECEIPT/////
  fnSaveMeterReceipt() async {
    // Table1 table1 = viewGasInvoiceReceiptModel.table1![0];

    fnSaveValidate().then((value) {
      if (value) {
        showLoadingDialog();

        List<Map<String, dynamic>> tblGReading = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "YEARCODE": Global.selectedCompanyYear,
            "DOCDATE": Helper.convertDateFormat(
                dateTime: selectedReadReceipt.docdate.toString()),
            "SMAN": "",
            "BILLCOLLECTOR": selectedReadReceipt.billcollector,
            "BUILDING_CODE_FROM": selectedReadReceipt.buildingCode,
            "BUILDING_CODE_TO": selectedReadReceipt.buildingCode,
            "ACCODE": "",
            "SLCODE": "",
            "ACDESCP": "",
            "SLDESCP": "",
            "CURR": "",
            "CURRATE": "1",
            "CHQBANK": "",
            "CHQBANKDESCP": "",
            "DEPBANK": "",
            "CHQBANK_BRANCH": "",
            "PAYMODE":
                selectedPaymentMode.value == "CASH" ? "CASH" : "CREDITCARD",
            "REMITTO": "",
            "CHQNO": "",
            "CHQDATE": "",
            "PDC_YN": "",
            "REMARKS": "",
            "REF1": "",
            "REF2": "",
            "REF3": "",
            "REF4": "",
            "REF5": "",
            "REF6": "",
            "CONTRACT_NO_FROM": selectedReadReceipt.contractNo,
            "CONTRACT_NO_TO": selectedReadReceipt.contractNo,
            "INVNO_FROM": txtInvoiceNoController.text,
            "INVNO_TO": txtInvoiceNoController.text,
            "CREATE_USER": Global.userCD,
            "CREATE_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "CREDITCARD": txtCreditCard.text,
            "BRNCODE": Global.brnCode,
            "DIVCODE": Global.divCode,
            "CCCODE": Global.ccCode,
            "ONLINE_SYNCH_STATUS": "1"
          }
        ];
        List<Map<String, dynamic>> tblGReadingDet = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "YEARCODE": Global.selectedCompanyYear,
            "SRNO": selectedReadReceipt.srno,
            "DOCDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "INVNO": txtInvoiceNoController.text,
            "INVDATE": Helper.convertDateFormat4(
                dateTime: selectedReadReceipt.docdate.toString()),
            "BUILDING_CODE": selectedReadReceipt.buildingCode,
            "BUILDING_NAME": selectedReadReceipt.buildingName,
            "APARTMENT_CODE": selectedReadReceipt.apartmentCode,
            "PARTYCODE": selectedReadReceipt.partycode,
            "INVAMT": selectedReadReceipt.netAmount,
            "RECAMT": txtReceivedAmtController.text,
            "REF1": "",
            "READING_DOCNO": selectedReadReceipt.readingDocno,
            "CONTRACT_NO": selectedReadReceipt.contractNo,
            "INVDOCTYPE": selectedReadReceipt.doctype,
            "INVYEARCODE": selectedReadReceipt.yearcode,
            "INVSRNO": 1,
            "PAYMODE":
                selectedPaymentMode.value == "CASH" ? "CASH" : "CREDITCARD",
            "CREDITCARD": txtCreditCard.text,
            "DISC_AMT": 0,
            "PRV_DISC_AMT": 0,
            "ONLINE_FEE": 0,
            "LATE_PAY_FEE": 0,
            "BRNCODE": Global.brnCode,
            "DIVCODE": Global.divCode,
            "CCCODE": Global.ccCode,
            "APP_SYNCH_STATUS": "1",
            "INVOICE_DEPOSIT": selectedReadReceipt.invoiceDeposit,
            "PRV_DEPOSIT_RECEIVED": selectedReadReceipt.prvRecvedDeposit,
            "RECEIVED_DEPOSIT": selectedReadReceipt.receivedDepositamt,
            "ONLINE_SYNCH_STATUS": "1",
            "PAIDAMT": selectedReadReceipt.paidAmt
          }
        ];
        final Map<String, dynamic> payLoad = {
          "TBL_GREC": tblGReading,
          "TBL_GRECDET": tblGReadingDet,
          "MODE": "ADD"
        };
        Helper.fngetTocken().then((token) {
          if (token != null) {
            gasReceiptRepository
                .saveGasMeterInvoiceReceipt(
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
    fnGetLastGasMeterReceipt(mode: "LAST", docNo: "");
  }

  ///////////////////////

  fnValidateReadingReceipt({
    required String invoiceDocNo,
    required String invoiceDocType,
    required String invoiceYearCode,
  }) {
    // docNoForSaving = readingDocNo;
    // docTypeForSaving = readingDocType;
    // docYearCodeForSaving = readingYearCode;
    showLoadingDialog();

    Helper.fngetTocken().then((token) {
      fnClear();
      if (token != null) {
        gasReceiptRepository
            .validateInvoiceReceipt(
          token: token,
          invoiceDocNo: invoiceDocNo,
          invoiceDocType: invoiceDocType,
          invoiceYearCode: invoiceYearCode,
        )
            .then((value) {
          if (value!.buildingCode != null) {
            selectedReadReceipt = value;
            fillValidatedData();
            isEditModeEnabled.value = true;

            if (Global.isWindows) {
              Get.off(
                () => GasMeterReadingReceiptPageExe(
                  isFromInvoicePage: true,
                ),
              );
            } else {
              Get.back();
              Get.off(
                () => GasMeterReadingReceiptPage(
                  isFromInvoicePage: true,
                ),
              );
            }
          } else {
            if (Get.isDialogOpen == true) {
              Get.back();
            }
            errorMsg(msg: "Invoice already Received");
          }

          isEditModeEnabled.value = true;
        });
      }
    });
  }
}
