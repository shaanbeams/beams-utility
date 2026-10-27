import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/contract%20receipt/model/charge_row_model.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/view/gas_meter_invoice_page.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/repository/gas_meter_invoice_repository.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/model/reading_invoice_validate_model.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/model/view_gas_invoice_model.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/view/gas_meter_invoice_page_exe.dart';
import 'package:gas_utility_app/support/common_widgets/commonDialog.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/save_pop_up.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../support/enums.dart';

class GasMeterReadingInvoiceController extends GetxController {
  ReadingInvoiceValidateModel selectedReadingInvoice =
      ReadingInvoiceValidateModel();
  RxBool floatingIsExpanded = true.obs;
  RxnString lastDocdate = RxnString();
  String invoiceDocType = "";

  GasReadingInvoiceRepository gasReadingInvoiceRepository =
      GasReadingInvoiceRepository();

  //======================textEditing Controllers========================//
  //============================main=====================================//

  TextEditingController txtDocNumController = TextEditingController(text: "");

  TextEditingController txtReqDocTypeController =
      TextEditingController(text: "");
  TextEditingController txtBuildingCodeController =
      TextEditingController(text: "");
  TextEditingController txtBuildingNameController =
      TextEditingController(text: "");
  TextEditingController txtApartmentCodeController =
      TextEditingController(text: "");
  TextEditingController txtGasMeterController = TextEditingController(text: "");
  TextEditingController txtLastReadingController =
      TextEditingController(text: "");
  TextEditingController txtOutStantingAmtController =
      TextEditingController(text: "");
  TextEditingController txtlastPaidController = TextEditingController(text: "");
  TextEditingController txtContractNoController =
      TextEditingController(text: "");
  TextEditingController txtMobileNoController = TextEditingController(text: "");
  TextEditingController txtTenantNameController =
      TextEditingController(text: "");
  TextEditingController txtPartyCodeController =
      TextEditingController(text: "");
  TextEditingController txtCurrentReadingController =
      TextEditingController(text: "");
  TextEditingController txtDiscountController = TextEditingController(text: "");
  TextEditingController txtDepositController = TextEditingController(text: "");
  TextEditingController txtConsumptionController =
      TextEditingController(text: "");
  TextEditingController txtUnitPriceController =
      TextEditingController(text: "");

  TextEditingController txtConvertionFactorController =
      TextEditingController(text: "");

  //============================invoice====================================//

  RxList<ChargeRow> chargeRows = [
    ChargeRow(name: "Consumption charge"),
    ChargeRow(name: "Service charge"),
    ChargeRow(name: "Maintenance charge"),
    ChargeRow(name: "Administration"),
    ChargeRow(name: "Bill & Meter Reading fee"),
    ChargeRow(name: "Facility Management fee"),
    ChargeRow(name: "Boiler gas Consumption"),
    ChargeRow(name: "Delay payment fee"),
    ChargeRow(name: "Security fee"),
    ChargeRow(name: "Other charge"),
  ].obs;

  RxDouble totalCurrAmount = 0.0.obs;
  RxDouble totalCurrTaxAmount = 0.0.obs;
  RxDouble netAmount = 0.0.obs;
  Rx<bool> isEditModeEnabled = false.obs;
  Rx<Uint8List> lstrSignature = Uint8List(0).obs;
  var lstrByteSignature = "";
  Rx<SaveModes> saveMode = SaveModes.add.obs;
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: ThemeColors.black,
    exportBackgroundColor: Colors.white,
  );
  RxnString lastReadingDate = RxnString();
  RxnString docdate = RxnString();
  RxnString paidDate = RxnString();
  Rx<bool> isFinalReading = false.obs;

  ////for saving invoice
  String? docNoForSaving = '';
  String? docTypeForSaving = '';
  String? docYearCodeForSaving = '';
  ///////////////////////
  ///
  ///
  void fnClear() {
    // Clear RxnString fields
    // lastReadingDate.value = null;
    // docdate.value = null;
    // paidDate.value = null;

    // Clear Rx<bool> fields
    isFinalReading.value = false;

    // Reset custom objects
    // selectedApartmentData = ReadingInvoiceValidateModel();
    // selectMeterReadingModel = viewModel.ViewGasInvoiceModel();

    // Reset Rx enum and boolean values
    saveMode.value = SaveModes.add;
    floatingIsExpanded.value = true;

    // Clear signature-related fields
    lstrByteSignature = "";
    lstrSignature.value = Uint8List(0);
    signatureController.clear();

    // Clear TextEditingController fields
    txtDocNumController.clear();
    txtReqDocTypeController.clear();
    txtDocNumController.clear();
    txtBuildingCodeController.clear();
    txtBuildingNameController.clear();
    txtApartmentCodeController.clear();
    txtGasMeterController.clear();
    txtLastReadingController.clear();
    txtOutStantingAmtController.clear();
    txtlastPaidController.clear();
    txtContractNoController.clear();
    txtMobileNoController.clear();
    txtTenantNameController.clear();
    txtPartyCodeController.clear();
    txtCurrentReadingController.clear();
    txtDiscountController.clear();
    txtDepositController.clear();
    txtConsumptionController.clear();
    txtUnitPriceController.clear();
    txtConvertionFactorController.clear();

    // Clear charge rows
    chargeRows.clear();
    chargeRows.addAll([
      ChargeRow(name: "Consumption charge"),
      ChargeRow(name: "Service charge"),
      ChargeRow(name: "Maintenance charge"),
      ChargeRow(name: "Administration"),
      ChargeRow(name: "Bill & Meter Reading fee"),
      ChargeRow(name: "Facility Management fee"),
      ChargeRow(name: "Boiler gas Consumption"),
      ChargeRow(name: "Delay payment fee"),
      ChargeRow(name: "Security fee"),
      ChargeRow(name: "Other charge"),
    ]);

    // Reset double fields
    totalCurrAmount.value = 0.0;
    totalCurrTaxAmount.value = 0.0;
    netAmount.value = 0.0;
  }

  fnValidateReadingInvoice({
    required String readingDocNo,
    required String readingDocType,
    required String readingYearCode,
  }) {
    docNoForSaving = readingDocNo;
    docTypeForSaving = readingDocType;
    docYearCodeForSaving = readingYearCode;
    showLoadingDialog();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        fnClear();
        gasReadingInvoiceRepository
            .validateInvoice(
          token: token,
          readingDocNo: readingDocNo,
          readingDocType: readingDocType,
          readingYearCode: readingYearCode,
        )
            .then((value) {
          if (value!.buildingCode != null) {
            selectedReadingInvoice = value;
            fillValidatedData();
            isEditModeEnabled.value = true;
            if (Global.isWindows) {
              Get.to(() => GasMeterInvoicePageExe(
                    isFromReadingPage: true,
                  ));
            } else {
              Get.back();
              Get.off(
                () => GasMeterReadingInvoicePage(
                  isFromReadingPage: true,
                ),
              );
            }
          } else {
            if (Get.isDialogOpen == true) {
              Get.back();
            }
            errorMsg(msg: "invoice already generated for the reading");
          }

          // isEditModeEnabled.value = true;
        });
      }
    });
  }



  fillValidatedData() {
    // viewModel.ReadingViewModel readingViewModel = selectedLastMeterReading;
    // viewModel.Table2 selectedReadingInvoice = readingViewModel.table2![0];
    // viewModel.Table1 t1ViewValue = readingViewModel.table1![0];

    txtContractNoController.text = selectedReadingInvoice.partycode ?? "0";
    txtGasMeterController.text = selectedReadingInvoice.gasMeterNo ?? "0";
    txtLastReadingController.text = selectedReadingInvoice.lastReading ?? "0";
    txtUnitPriceController.text = selectedReadingInvoice.unitPrice ?? "0";
    txtTenantNameController.text = selectedReadingInvoice.partyname ?? "";
    txtPartyCodeController.text = selectedReadingInvoice.partycode ?? "";
    // txtConvertionFactorController.text = selectedReadingInvoice.readingConversion ?? "";
    txtBuildingCodeController.text =
        selectedReadingInvoice.buildingCode.toString();
    txtBuildingNameController.text = selectedReadingInvoice.descp.toString();
    txtApartmentCodeController.text =
        selectedReadingInvoice.apartmentCode.toString();
    txtCurrentReadingController.text =
        selectedReadingInvoice.currReading.toString();
    txtLastReadingController.text =
        selectedReadingInvoice.lastReading.toString();
    txtConsumptionController.text = selectedReadingInvoice.totalUnit.toString();
    txtDocNumController.text = selectedReadingInvoice.lastRecDocno.toString();
    lastReadingDate.value = Helper.convertDateFormat1(
        dateTime: selectedReadingInvoice.lastReadingDate ?? "0");

    isFinalReading.value =
        selectedReadingInvoice.final_reading_yn == "Y" ? true : false;
        txtOutStantingAmtController.text= selectedReadingInvoice.prvBalance??"";
        txtlastPaidController.text =selectedReadingInvoice.lastRecAmt??"";
        // txtConvertionFactorController.text=selectedReadingInvoice.readC

    int totalMonth = calculateMonthCount(Helper.dateDifferance(
        previousDateString: selectedReadingInvoice.lastReadingDate ?? "0"));

    ///AMOUNT///
    ///Consumption charge///
    chargeRows[0].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.totalReadcharge).toString();
    chargeRows[0].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.readingVat);
    chargeRows[0].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text),
        chargeRows[0].taxPerc.value));

    ///Service charge/MONTHLY///

    chargeRows[1].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.monthlyFee).toString();
    chargeRows[1].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.monthlyVat);
    chargeRows[1].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[1].txtCurrentAmt.text),
        chargeRows[1].taxPerc.value));

    ///Maintenance charge///
    chargeRows[2].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.maintenanceAmt).toString();
    chargeRows[2].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.maintenanceVat);
    chargeRows[2].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[2].txtCurrentAmt.text),
        chargeRows[2].taxPerc.value));

    ///Administration///
    chargeRows[3].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.administrationAmt).toString();
    chargeRows[3].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.administrationTaxPerc);
    chargeRows[3].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text),
        chargeRows[3].taxPerc.value));

    ///Bill & Meter Reading fee///
    chargeRows[4].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.billMeterReadingAmt).toString();
    chargeRows[4].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.billMeterReadingTaxPerc);
    chargeRows[4].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[4].txtCurrentAmt.text),
        chargeRows[4].taxPerc.value));

    ///Facility Management fee///
    chargeRows[5].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.facilityManageAmt).toString();
    chargeRows[5].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.facilityManageTaxPerc);
    chargeRows[5].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[5].txtCurrentAmt.text),
        chargeRows[5].taxPerc.value));

    ///Boiler gas Consumption///
    chargeRows[6].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.boilerGasConsumptionAmt)
            .toString();
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.boilerGasConsumptionTaxPerc);
    chargeRows[6].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[6].txtCurrentAmt.text),
        chargeRows[6].taxPerc.value));

    ///Delay payment fee///
    chargeRows[7].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.delayPaymentAmt).toString();
    chargeRows[7].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.delayPaymentTaxPerc);
    chargeRows[7].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[7].txtCurrentAmt.text),
        chargeRows[7].taxPerc.value));

    ///Security fee///
    chargeRows[8].txtCurrentAmt.text =
        Helper.mfnDbl(selectedReadingInvoice.securityDepReturnAmt).toString();
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(selectedReadingInvoice.securityDepReturnTaxPerc);
    chargeRows[8].currTaxAmount.value = Helper.mfnDbl(fnCalVat(
        Helper.mfnDbl(chargeRows[8].txtCurrentAmt.text),
        chargeRows[8].taxPerc.value));

    ///Other charge///

    // chargeRows[9].taxPerc.value = Helper.mfnDbl(selectedReadingInvoice.otherAmt);

    // chargeRows[9].txtCurrentAmt.text =
    //     (Helper.mfnDbl(selectedReadingInvoice.otherAmtTaxTotal) / 100).toString();
    // chargeRows[9].currTaxAmount.value =
    //     Helper.mfnDbl(selectedReadingInvoice.otherAmtTaxTotal);

    // fnConsumptionCalculator(t2ViewValue.currReading);
    fnTotalAmount();
  }

  fnGetLastGasMeterInvoice({required String docNo, required String mode}) {
    //  fnclear();

    Helper.fngetTocken().then((token) {
      if (token != null) {
        gasReadingInvoiceRepository
            .getLastInvoice(token: token, docno: docNo, mode: mode)
            .then((selectedLastMeterReading) {
          if (selectedLastMeterReading != null) {
            _fillViewData(selectedLastMeterReading);
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          }
        });
      }
    });
  }

  _fillViewData(selectedLastMeterReading) {
    ViewGasInvoiceModel readingViewModel = selectedLastMeterReading;
     if (readingViewModel.table1!.isEmpty || readingViewModel.table1 == null) {
      return;
    }
    var t1ViewValue = readingViewModel.table1![0];
    var t2ViewValue = readingViewModel.table2![0];

    lastDocdate.value = t1ViewValue?.docDate;

    txtContractNoController.text = t2ViewValue!.contractNo ?? "0";
    // txtGasMeterController.text = t2ViewValue. ?? "0";
    txtLastReadingController.text = t2ViewValue.lastReading ?? "0";
    txtUnitPriceController.text = t2ViewValue.unitPrice ?? "0";
    txtTenantNameController.text = t2ViewValue.partyname ?? "";
    txtPartyCodeController.text = t2ViewValue.partycode ?? "";
    // txtConvertionFactorController.text = t2ViewValue.readingConversion ?? "";
    txtBuildingCodeController.text = t2ViewValue.buildingCode.toString();
    txtBuildingNameController.text = t2ViewValue.buildingName.toString();
    txtApartmentCodeController.text = t2ViewValue.apartmentCode.toString();
    txtCurrentReadingController.text = t2ViewValue.currReading.toString();
    txtLastReadingController.text = t2ViewValue.lastReading.toString();
    txtConsumptionController.text = t2ViewValue.totalUnit.toString();
    txtDocNumController.text = t1ViewValue!.docNo ?? "0";
    lastReadingDate.value =
        Helper.convertDateFormat1(dateTime: t2ViewValue.lastReadingDate ?? "0");
    txtDocNumController.text = t1ViewValue.docNo ?? "0";
    int totalMonth = calculateMonthCount(Helper.dateDifferance(
        previousDateString: t2ViewValue.lastReadingDate ?? "0"));
        


        txtOutStantingAmtController.text=t2ViewValue.prevBalance ??"0";
        // txtlastPaidController.text=t2ViewValue.??"";
    //
    // ///AMOUNT///
    // ///Consumption charge///
    chargeRows[0].txtCurrentAmt.text = t2ViewValue.amt ?? "";
    chargeRows[0].taxPerc.value = Helper.mfnDbl(t2ViewValue.taxpercReadcharge);
    chargeRows[0].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.taxamtReadcharge);
    //
    // ///Service charge/MONTHLY///
    //
    chargeRows[1].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.monthlyFee).toString();
    chargeRows[1].taxPerc.value = Helper.mfnDbl(t1ViewValue.monthlyFeeTaxTotal);
    chargeRows[1].currTaxAmount.value =
        Helper.mfnDbl(t1ViewValue.monthlyFeeTaxTotal);
    //
    // ///Maintenance charge///
    chargeRows[2].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.maintenanceAmt).toString();
    chargeRows[2].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.taxpercMaintenanceAmt);
    chargeRows[2].currTaxAmount.value =
        Helper.mfnDbl(t1ViewValue.maintenanceAmtTaxTotal);
    //
    // ///Administration///
    chargeRows[3].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.administrationAmt).toString();
    chargeRows[3].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.administrationTaxPerc);
    chargeRows[3].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.administrationTaxAmt);
    //
    // ///Bill & Meter Reading fee///
    chargeRows[4].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.billMeterReadingAmt).toString();
    chargeRows[4].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.billMeterReadingTaxPerc);
    chargeRows[4].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.billMeterReadingTaxAmt);
    //
    // ///Facility Management fee///
    chargeRows[5].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.facilityManageAmt).toString();
    chargeRows[5].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.facilityManageTaxPerc);
    chargeRows[5].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.facilityManageTaxAmt);
    //
    // ///Boiler gas Consumption///
    chargeRows[6].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.boilerGasConsumptionAmt).toString();
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.boilerGasConsumptionTaxPerc);
    chargeRows[6].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.boilerGasConsumptionTaxAmt);
    //
    // ///Delay payment fee///
    chargeRows[7].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.delayPaymentAmt).toString();
    chargeRows[7].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.delayPaymentTaxPerc);
    chargeRows[7].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.delayPaymentTaxAmt);
    //
    // ///Security fee///
    chargeRows[8].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.securityDepReturnAmt).toString();
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.securityDepReturnTaxPerc);
    chargeRows[8].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.securityDepReturnTaxAmt);

    isFinalReading.value = t2ViewValue.finalInvoiceYn == "Y" ? true : false;
    //
    // ///Other charge///
    // //
    // chargeRows[9].taxPerc.value = Helper.mfnDbl(t2ViewValue.otherAmt);
    // //
    // chargeRows[9].txtCurrentAmt.text =
    //     (Helper.mfnDbl(t1ViewValue.otherAmtTaxTotal) / 100).toString();
    // chargeRows[9].currTaxAmount.value =
    //     Helper.mfnDbl(t1ViewValue.otherAmtTaxTotal);
    // frontImage.value = base64.decode(t1ViewValue.imgEidFront ?? "");
    // backImage.value = base64.decode(t1ViewValue.imgEidBack ?? "");
    // meterImage.value = base64.decode(t1ViewValue.imgMeter ?? "");
    // fnCalculateValues();
    lstrSignature.value = base64.decode(t1ViewValue.signature ?? "");
    // fnConsumptionCalculator(t2ViewValue.currReading);
    fnTotalAmount();
  }

  fnDeleteGasInvoice() {
    Helper.fngetTocken().then((token) {
      showLoadingDialog();

      if (token != null) {
        gasReadingInvoiceRepository
            .deleteInvoice(docNo: txtDocNumController.text, token: token)
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

  fnSaveInvoiceReading() async {
    await fnSignToBase64();
    fnSaveValidate().then((value) {
      if (value) {
        showLoadingDialog();

        List<Map<String, dynamic>> tblGInv = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "YEARCODE": Global.selectedCompanyYear,
            "DOCDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "BILLCOLLECTOR": "TEST",
            "BUILDING_CODE_FROM": selectedReadingInvoice.buildingCode,
            "BUILDING_CODE_TO": selectedReadingInvoice.buildingCode,
            "SMAN": "",
            "FINAL_INVOICE_YN": isFinalReading.value == true ? "Y" : "N",
            "CONTRACT_NO_FROM": selectedReadingInvoice.partycode,
            "CONTRACT_NO_TO": selectedReadingInvoice.partycode,
            "READING_DOCNO_FROM": docNoForSaving,
            "READING_DOCNO_TO": docNoForSaving,
            "BILLING_CUSTOMER": "",
            "CREATE_USER": Global.userCD,
            "CREATE_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "EDIT_USER": Global.userCD,
            "EDIT_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "CRDAYS": "0",
            "DUEDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "REMARKS": "",
            "UPDATED_ONLINE_YN": "N",
            "BRNCODE": Global.brnCode,
            "DIVCODE": Global.divCode,
            "CCCODE": Global.ccCode,
            "GPCustomer_Round_YN": "N",
            "READING_CHARGE_TAX_TOTAL": chargeRows[5].currTaxAmount.value,
            "OTHER_AMT_TAX_TOTAL": chargeRows[3].currTaxAmount.value,
            "MONTHLY_FEE_TAX_TOTAL": chargeRows[1].currTaxAmount.value,
            "MAINTENANCE_AMT_TAX_TOTAL": chargeRows[2].currTaxAmount.value,
            "TAX_AMOUNT_TOTAL": totalCurrTaxAmount.value,
            "NET_AMOUNT": netAmount.value,
            "ONLINE_SYNCH_STATUS": "1",
            "SIGNATURE": lstrByteSignature,
            "CREATE_MACHINE": Global.wstrDeviceId,
            "EDIT_MACHINE": Global.wstrDeviceId,
          }
        ];
        List<Map<String, dynamic>> tblGInvDet = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "YEARCODE": Global.selectedCompanyYear,
            "SRNO": "1",
            "BUILDING_CODE": txtBuildingCodeController.text,
            "BUILDING_NAME": txtBuildingNameController.text,
            "APARTMENT_CODE": txtApartmentCodeController.text,
            "LAST_READING": txtLastReadingController.text,
            "LAST_READING_DATE": Helper.convertDateFormat3(
                dateTime: lastReadingDate.value ?? "  "),
            "CURR_READING": txtCurrentReadingController.text,
            "CURR_READING_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "TOTAL_UNIT": txtConsumptionController.text,
            "UNIT_PRICE": txtUnitPriceController.text,
            "AMT": chargeRows[0].txtCurrentAmt.text,
            "TOTALAMT": totalCurrAmount.value,
            "MONTHLY_FEE": chargeRows[1].txtCurrentAmt.text,
            "OTHER_AMT": chargeRows[3].txtCurrentAmt.text,
            "READING_DOCNO": docNoForSaving,
            "READING_DOCTYPE": docTypeForSaving,
            "READING_YEARCODE": docYearCodeForSaving,
            "CONTRACT_NO": selectedReadingInvoice.partycode,
            "LAST_INVDOCNO": "",
            "LAST_INVDOCTYPE": "",
            "LAST_YEARCODE": "",
            "LAST_INVDATE": "",
            "PARTYCODE": selectedReadingInvoice.partycode,
            "PARTYNAME": selectedReadingInvoice.partyname,
            "PREV_BALANCE": selectedReadingInvoice.prvBalance,
            "DBREADINGAMT_ACCODE": "",
            "DBMAINTENANCE_ACCODE": "",
            "DBMONTHLY_ACCODE": "",
            "DBCONNECTION_ACCODE": "",
            "DBOTHERAMT_ACCODE": "",
            "DBINSURANCEAMT_ACCODE": "",
            "DBDEPOSITAMT_ACCODE": "",
            "READING_SRNO": "1",
            "FINAL_INVOICE_YN": isFinalReading.value == true ? "Y" : "N",
            "LAST_REC_DOCNO": "",
            "LAST_REC_DOCTYPE": "",
            "LAST_REC_DOCDATE": "",
            "LAST_REC_YEARCODE": "",
            "LAST_REC_AMT": "0",
            "GAS_METER_NO": txtGasMeterController.text,
            "DISC_AMT": "0",
            "MAINTENANCE_AMT": chargeRows[2].txtCurrentAmt.text,
            "BRNCODE": "",
            "DIVCODE": "",
            "CCCODE": "",
            "TAXPERC_READCHARGE": chargeRows[0].taxPerc.value,
            "TAXAMT_READCHARGE": chargeRows[0].currTaxAmount.value,
            "READINGTAX_ACCODE": "",
            "TAXPERC_OTHER_AMT": chargeRows[3].taxPerc.value,
            "TAXAMT_OTHER_AMT": chargeRows[3].txtCurrentAmt.text,
            "OTHERTAX_ACCODE": "",
            "TAXPERC_MONTHLY_FEE": chargeRows[1].taxPerc.value,
            "TAXAMT_MONTHLY_FEE": chargeRows[1].currTaxAmount.value,
            "MONTHLYTAX_ACCODE": "",
            "TAXPERC_MAINTENANCE_AMT": chargeRows[2].taxPerc.value,
            "TAXAMT_MAINTENANCE_AMT": chargeRows[2].currTaxAmount.value,
            "MAINTENANCETAX_ACCODE": "",
            "TAX_AMOUNT_TOTAL": totalCurrTaxAmount.value,
            "NET_AMOUNT": netAmount.value,
            "APP_SYNCH_STATUS": "1",
            "DEPOSIT_TAXPERC": "0",
            "DEPOSIT_TAXAMT": "0",
            "DEPOSITTAX_ACCODE": "",
            "DEPOSIT_AMT": "0",
            "ONLINE_SYNCH_STATUS": "1",
            "BILL_METER_READING_AMT": chargeRows[5].txtCurrentAmt.text,
            "BILL_METER_READING_TAX_PERC": chargeRows[5].taxPerc.value,
            "BILL_METER_READING_TAX_AMT": chargeRows[5].currTaxAmount.value,
            "ADMINISTRATION_AMT": chargeRows[4].txtCurrentAmt.text,
            "ADMINISTRATION_TAX_PERC": chargeRows[4].taxPerc.value,
            "ADMINISTRATION_TAX_AMT": chargeRows[4].currTaxAmount.value,
            "FACILITY_MANAGE_AMT": chargeRows[6].txtCurrentAmt.text,
            "FACILITY_MANAGE_TAX_PERC": chargeRows[6].taxPerc.value,
            "FACILITY_MANAGE_TAX_AMT": chargeRows[6].currTaxAmount.value,
            "BOILER_GAS_CONSUMPTION_AMT": chargeRows[7].txtCurrentAmt.text,
            "BOILER_GAS_CONSUMPTION_TAX_PERC": chargeRows[7].taxPerc.value,
            "BOILER_GAS_CONSUMPTION_TAX_AMT": chargeRows[7].currTaxAmount.value,
            "DELAY_PAYMENT_AMT": chargeRows[8].txtCurrentAmt.text,
            "DELAY_PAYMENT_TAX_PERC": chargeRows[8].taxPerc.value,
            "DELAY_PAYMENT_TAX_AMT": chargeRows[8].currTaxAmount.value,
            "SECURITY_DEP_RETURN_AMT": chargeRows[9].txtCurrentAmt.text,
            "SECURITY_DEP_RETURN_TAX_PERC": chargeRows[9].taxPerc.value,
            "SECURITY_DEP_RETURN_TAX_AMT": chargeRows[9].currTaxAmount.value,
            "BILL_METER_READING_VATACCODE": "",
            "ADMINISTRATION_VATACCODE": "",
            "FACILITY_MANAGE_VATACCODE": "",
            "BOILER_GAS_CONSUMPTION_VATACCODE": "",
            "DELAY_PAYMENT_VATACCODE": "",
            "SECURITY_DEP_RETURN_VATACCODE": "",
            "BILL_METER_READING_ACCODE": "",
            "ADMINISTRATION_ACCODE": "",
            "FACILITY_MANAGE_ACCODE": "",
            "BOILER_GAS_CONSUMPTION_ACCODE": "",
            "DELAY_PAYMENT_ACCODE": "",
            "SECURITY_DEP_RETURN_ACCODE": "",
            "WEBONLINE_SYNCH_STATUS": "1",
            "DUEDATE": "2024-10-31 00:00:00.000",
            "CONTRACT_NO_BASE64": "",
            "FUEL_SURCHARGE_AMT": "0",
            "FUEL_SURCHARGE_TAX_PERC": "0",
            "FUEL_SURCHARGE_TAX_AMT": "0",
            "FUEL_SURCHARGE_ACCODE": "",
            "FUEL_SURCHARGE_VATACCODE": "",
            "SYSTEM_CHECKUP_CHARGE": "0",
            "SYSTEM_CHECKUP_TAX_PERC": "0",
            "SYSTEM_CHECKUP_TAX_AMT": "0",
            "SYSTEM_CHECKUP_CHARGE_ACCODE": "",
            "SYSTEM_CHECKUP_CHARGE_VATACCODE": ""
          }
        ];
        final Map<String, dynamic> payLoad = {
          "TBL_GINV": tblGInv,
          "TBL_GINVDET": tblGInvDet,
          "MODE": saveMode.value.value
        };

        Helper.fngetTocken().then((token) {
          if (token != null) {
            gasReadingInvoiceRepository
                .saveInvoice(
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

  fnSignToBase64() async {
    lstrByteSignature = '';
    final Uint8List? data = await signatureController.toPngBytes();
    if (data != null && data.isNotEmpty) {
      lstrByteSignature = base64.encode(data as List<int>);
    }
  }

  _fnSaveSuccess() {
    successPopup();
    fnGetLastGasMeterInvoice(mode: "LAST", docNo: "");
    isEditModeEnabled.value = false;
  }

  fnSaveValidate() async {
    if (lstrByteSignature.isEmpty) {
      errorMsg(msg: "Signature cant be empty");
      return false;
    }

    return true;
  }
/////////////////////////////////////////////////////////////////////////////////////////

  fnCalculateValues() {
    chargeRows[0].txtCurrentAmt.text =
        ((Helper.mfnDbl(txtConsumptionController.text)) *
                Helper.mfnDbl(txtConvertionFactorController.text) *
                Helper.mfnDbl(txtUnitPriceController.text))
            .toString();
    chargeRows[0].currTaxAmount.value =
        Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text) *
            (chargeRows[0].taxPerc.value / 100);
    // if (selectMeterReadingModel.table2![0].p == "Y" && selectedApartmentData.table2![0].otherAmtCalcType == "L") {
    //   chargeRows[0].txtCurrentAmt.text = ((Helper.mfnDbl(txtConsumptionController.text)) * Helper.mfnDbl(txtConvertionFactorController.text) * Helper.mfnDbl(txtUnitPriceController.text)).toString();
    //   chargeRows[9].currTaxAmount.value = Helper.mfnDbl(chargeRows[9].txtCurrentAmt.text) * (chargeRows[9].taxPerc.value / 100);
    // }

    fnTotalAmount();
  }

  void fnTotalAmount() {
    totalCurrAmount.value = 0.0;
    totalCurrTaxAmount.value = 0.0;
    netAmount.value = 0.0;

    // Loop through chargeRows and sum the required fields
    for (var row in chargeRows) {
      totalCurrAmount.value += Helper.mfnDbl(row.txtCurrentAmt.text);
      totalCurrTaxAmount.value += row.currTaxAmount.value;
    }
    netAmount.value = totalCurrAmount.value + totalCurrTaxAmount.value;
  }

  void fnConsumptionCalculator(value) {
    double lastReadingValue = Helper.mfnDbl(txtLastReadingController.text);
    double consumption = Helper.mfnDbl(value) - lastReadingValue;
    txtConsumptionController.text = consumption.toStringAsFixed(3);

    fnCalculateValues();
  }

//
  int calculateMonthCount(int value) {
    int quotient = value ~/ 30; // Integer division
    int remainder = value % 30; // Remainder

    if (remainder >= 15) {
      quotient += 1;
    }

    return quotient;
  }
}
