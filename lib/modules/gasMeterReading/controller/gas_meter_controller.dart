import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/contract%20receipt/model/charge_row_model.dart';
import 'package:gas_utility_app/modules/gasMeterReading/repository/gas_reading_repository.dart';
import 'package:gas_utility_app/modules/gasMeterReading/model/validate_apartment_model.dart';
import 'package:gas_utility_app/modules/gasMeterReading/model/validate_apartment_view_model.dart'
    as viewModel;
import 'package:gas_utility_app/support/common_widgets/commonDialog.dart';
import 'package:gas_utility_app/support/common_widgets/save_pop_up.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/enums.dart';
import '../../../support/helper.dart';

class GasMeterReadingController extends GetxController {
  RxnString lastReadingDate = RxnString();
  RxnString docdate = RxnString();
  RxnString lastDocdate = RxnString();
  RxnString paidDate = RxnString();
  Rx<bool> isEditModeEnabled = false.obs;
  Rx<bool> isFinalReading = false.obs;
  GasReadingRepository gasReadingRepository = GasReadingRepository();
  ValidateApartmentModel selectedApartmentData = ValidateApartmentModel();
  viewModel.ReadingViewModel selectMeterReadingModel =
      viewModel.ReadingViewModel();
  Rx<SaveModes> saveMode = SaveModes.add.obs;
  RxBool floatingIsExpanded = true.obs;
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: ThemeColors.black,
    exportBackgroundColor: Colors.white,
  );
  var lstrByteSignature = "";
  var lstrSignature = Uint8List(0).obs;

  String contractReadingDocType = "";

  // String lstrSignature = "".obs;

  @override
  onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog();
    });
    contractReadingDocType = Global.selectedDocType;
    fnGetLastGasMeterReading(mode: "LAST", docNo: "");
    fnGetGasDocMaster(docType: Global.selectedDocType).then(
      (value) {
        Global.ccCode = value[0]["CCCODE"];
        Global.divCode = value[0]["DIVCODE"];
        Global.brnCode = value[0]["BRNCODE"];
      },
    );
    if (Global.enableFuelSurcharge == "Y") {
      chargeRows.add(
        ChargeRow(name: "Fuel Surcharge"),
      );
    }

    super.onInit();
  }

  //======================textEditing Controllers========================//
  //============================main=====================================//
  TextEditingController txtReqDocTypeController =
      TextEditingController(text: "");
  TextEditingController txtDocNumController = TextEditingController(text: "");
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
  // TextEditingController txtSummaryLastReadingController = TextEditingController(text: "");
  // TextEditingController txtSummaryOutstandngController = TextEditingController(text: "");
  // TextEditingController txtSummaryLastPaidController = TextEditingController(text: "");
  TextEditingController txtConvertionFactorController =
      TextEditingController(text: "");
  var meterImage = Uint8List(0).obs;
  var frontImage = Uint8List(0).obs;
  var backImage = Uint8List(0).obs;

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

  void fnClear() {
    // Clear RxnString fields
    // lastReadingDate.value = null;
    // docdate.value = null;
    // paidDate.value = null;

    // Clear Rx<bool> fields
    isFinalReading.value = false;

    // Reset custom objects
    selectedApartmentData = ValidateApartmentModel();
    selectMeterReadingModel = viewModel.ReadingViewModel();

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
    // txtBuildingCodeController.clear();
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

    // Clear image-related fields
    meterImage.value = Uint8List(0);
    frontImage.value = Uint8List(0);
    backImage.value = Uint8List(0);

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

  ////////////API Validate Apartment/////////////////////////////////

  fnSaveMeterReading() async {
    await fnSignToBase64();
    fnSaveValidate().then((value) {
      if (value) {
        showLoadingDialog();

        List<Map<String, dynamic>> tblGReading = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "YEARCODE": Global.selectedCompanyYear,
            "DOCDATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "READING_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "READING_BY": Global.userCD,
            "REMARKS": " ",
            "READING_TOTAL": txtCurrentReadingController.text,
            "UNIT_TOTAL": txtConsumptionController.text,
            // "READING_AMOUNT_TOTAL": chargeRows[0].txtCurrentAmt.text,
            "READING_AMOUNT_TOTAL": totalCurrAmount.value,
            "OTHER_AMT_TOTAL": chargeRows[9].txtCurrentAmt.text,
            "MONTHLY_FEE_TOTAL": chargeRows[1].txtCurrentAmt.text,
            "READING_CHARGE_TOTAL": chargeRows[0].txtCurrentAmt.text,
            "FINAL_READING_YN": isFinalReading.value == true ? "Y" : "N",
            "MAINTENANCE_AMT_TOTAL": chargeRows[2].txtCurrentAmt.text,
            "CREATE_USER": Global.userCD,
            "CREATE_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "EDIT_USER": Global.userCD,
            "EDIT_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "BRNCODE": "",
            "DIVCODE": "",
            "CCCODE": "",
            "READING_CHARGE_TAX_TOTAL": chargeRows[0].currTaxAmount.value,
            "OTHER_AMT_TAX_TOTAL": chargeRows[9].currTaxAmount.value,
            "MONTHLY_FEE_TAX_TOTAL": chargeRows[1].currTaxAmount.value,
            "MAINTENANCE_AMT_TAX_TOTAL": chargeRows[2].currTaxAmount.value,
            "TAX_AMOUNT_TOTAL": totalCurrTaxAmount.value,
            "NET_AMOUNT": netAmount.value,
            "ONLINE_SYNCH_STATUS": "1",
            "MANUAL_MONTHLY_CONSUMPTION_YN": "N",
            "MANUAL_MONTHLY_CONSUMPTION": "0",
            "CREATE_MACHINE": Global.wstrDeviceId,
            "EDIT_MACHINE": Global.wstrDeviceId,
            "SIGNATURE": lstrByteSignature,
            "IMG_EID_FRONT": base64.encode(frontImage.value),
            "IMG_EID_BACK": base64.encode(backImage.value),
            "IMG_METER": base64.encode(meterImage.value),
          }
        ];
        List<Map<String, dynamic>> tblGReadingDet = [
          {
            "COMPANY": Global.selectedCompanyCode,
            "DOCNO": "",
            "DOCTYPE": Global.selectedDocType,
            "YEARCODE": Global.selectedCompanyYear,
            "SRNO": 1,
            "BUILDING_CODE": txtBuildingCodeController.text,
            "DESCP": txtBuildingNameController.text,
            "APARTMENT_CODE": txtApartmentCodeController.text,
            "LAST_READING": txtLastReadingController.text,
            "LAST_READING_DATE": Helper.convertDateFormat3(
                dateTime: lastReadingDate.value ?? "  "),
            "CURR_READING": txtCurrentReadingController.text,
            "CURR_READING_DATE":
                Helper.convertDateTime(dateTime: DateTime.now().toString()),
            "ESTIMATE_YN": "N",
            "TOTAL_UNIT": txtConsumptionController.text,
            "UNIT_PRICE": txtUnitPriceController.text,
            "AMOUNT": totalCurrAmount.value,
            "OTHER_AMT": chargeRows[9].txtCurrentAmt.text,
            "MONTHLY_FEE": chargeRows[1].txtCurrentAmt.text, //service
            "TOTAL_READCHARGE":
                chargeRows[0].txtCurrentAmt.text, //consumptioncharge
            "CONTRACT_NO": txtContractNoController.text,
            "PARTYCODE": selectedApartmentData.table2?[0].partycode ?? "",
            "PARTYNAME": txtTenantNameController.text,
            "GAS_METER_NO": txtGasMeterController.text,
            "READING_CONVERSION": txtConvertionFactorController.text,
            "MAINTENANCE_AMT": chargeRows[2].txtCurrentAmt.text,
            "BRNCODE": "",
            "DIVCODE": "",
            "CCCODE": "",

            "TAXPERC_READCHARGE":
                chargeRows[0].taxPerc.value, //consumptionTaxVatPerc
            "TAXAMT_READCHARGE":
                chargeRows[0].currTaxAmount.value, //consumptionTaxAmount
            "READINGTAX_ACCODE": "",
            "TAXPERC_OTHER_AMT": chargeRows[9].taxPerc.value,
            "TAXAMT_OTHER_AMT": chargeRows[9].txtCurrentAmt.text,
            "OTHERTAX_ACCODE": "",
            "TAXPERC_MONTHLY_FEE": chargeRows[1].taxPerc.value,
            "TAXAMT_MONTHLY_FEE": chargeRows[1].currTaxAmount.value,
            "MONTHLYTAX_ACCODE": "",
            "TAXPERC_MAINTENANCE_AMT": chargeRows[2].taxPerc.value,
            "TAXAMT_MAINTENANCE_AMT": chargeRows[2].currTaxAmount.value,
            "MAINTENANCETAX_ACCODE": "",
            "TAX_AMOUNT": totalCurrTaxAmount.value,
            "NET_AMOUNT": netAmount.value,
            "CURR_READING_TIME": "",
            "APP_SYNCH_STATUS": "1",
            "ONLINE_SYNCH_STATUS": "1",
            "BILL_METER_READING_AMT": chargeRows[4].txtCurrentAmt.text,
            "BILL_METER_READING_TAX_PERC": chargeRows[4].taxPerc.value,
            "BILL_METER_READING_TAX_AMT": chargeRows[4].currTaxAmount.value,
            "ADMINISTRATION_AMT": chargeRows[3].txtCurrentAmt.text,
            "ADMINISTRATION_TAX_PERC": chargeRows[3].taxPerc.value,
            "ADMINISTRATION_TAX_AMT": chargeRows[3].currTaxAmount.value,
            "FACILITY_MANAGE_AMT": chargeRows[5].txtCurrentAmt.text,
            "FACILITY_MANAGE_TAX_PERC": chargeRows[5].taxPerc.value,
            "FACILITY_MANAGE_TAX_AMT": chargeRows[5].currTaxAmount.value,
            "BOILER_GAS_CONSUMPTION_AMT": chargeRows[6].txtCurrentAmt.text,
            "BOILER_GAS_CONSUMPTION_TAX_PERC": chargeRows[6].taxPerc.value,
            "BOILER_GAS_CONSUMPTION_TAX_AMT": chargeRows[6].currTaxAmount.value,
            "DELAY_PAYMENT_AMT": chargeRows[7].txtCurrentAmt.text,
            "DELAY_PAYMENT_TAX_PERC": chargeRows[7].taxPerc.value,
            "DELAY_PAYMENT_TAX_AMT": chargeRows[7].currTaxAmount.value,
            "SECURITY_DEP_RETURN_AMT": chargeRows[8].txtCurrentAmt.text,
            "SECURITY_DEP_RETURN_TAX_PERC": chargeRows[8].taxPerc.value,
            "SECURITY_DEP_RETURN_TAX_AMT": chargeRows[8].currTaxAmount.value,
            "METER_PRESSURE": "0",
            "FUEL_SURCHARGE": Global.enableFuelSurcharge == "Y"
                ? chargeRows[10].txtCurrentAmt.value.toString()
                : "0",
            "FUEL_SURCHARGE_AMT": Global.enableFuelSurcharge == "Y"
                ? chargeRows[10].txtCurrentAmt.value.toString()
                : "0",
            "FUEL_SURCHARGE_TAX_PERC": Global.enableFuelSurcharge == "Y"
                ? chargeRows[10].taxPerc.value.toString()
                : "0",
            "FUEL_SURCHARGE_TAX_AMT": Global.enableFuelSurcharge == "Y"
                ? chargeRows[10].currTaxAmount.value.toString()
                : "0",
          }
        ];
        final Map<String, dynamic> payLoad = {
          "TBL_GREADING": tblGReading,
          "TBL_GREADINGDET": tblGReadingDet,
          "MODE": saveMode.value.value
        };
        Helper.fngetTocken().then((token) {
          if (token != null) {
            gasReadingRepository
                .saveGasMeterReading(
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

  fnGetLastGasMeterReading({required String docNo, required String mode}) {
    //  fnclear();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        gasReadingRepository
            .getLastContractReceiptDetails(
                token: token,
                docno: docNo,
                mode: mode,
                docType: contractReadingDocType)
            .then((selectedLastMeterReading) {
          if (selectedLastMeterReading != null) {
            // selectMeterReadingModel = selectedLastMeterReading;
            // Get.back();
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
    logger.e(selectedLastMeterReading);
    viewModel.ReadingViewModel readingViewModel = selectedLastMeterReading;

    if (readingViewModel.table1!.isEmpty || readingViewModel.table1 == null) {
      return;
    }

    viewModel.Table2 t2ViewValue = readingViewModel.table2![0];
    Rx<viewModel.Table1> t1ViewValue = readingViewModel.table1![0].obs;

    lastDocdate.value = t1ViewValue.value.docdate ?? "";

    txtContractNoController.text = t2ViewValue.contractNo ?? "0";
    txtGasMeterController.text = t2ViewValue.gasMeterNo ?? "0";
    txtLastReadingController.text = t2ViewValue.lastReading ?? "0";
    txtUnitPriceController.text = t2ViewValue.unitPrice ?? "0";
    txtTenantNameController.text = t2ViewValue.partyname ?? "";
    txtPartyCodeController.text = t2ViewValue.partycode ?? "";
    txtConvertionFactorController.text = t2ViewValue.readingConversion ?? "";
    txtBuildingCodeController.text = t2ViewValue.buildingCode.toString();
    txtBuildingNameController.text = t2ViewValue.descp.toString();
    txtApartmentCodeController.text = t2ViewValue.apartmentCode.toString();
    txtCurrentReadingController.text = t2ViewValue.currReading.toString();
    txtLastReadingController.text = t2ViewValue.lastReading.toString();
    txtConsumptionController.text = t2ViewValue.totalUnit.toString();
    txtDocNumController.text = t2ViewValue.docno.toString();
     
    lastReadingDate.value =
        Helper.convertDateFormat1(dateTime: t2ViewValue.lastReadingDate ?? "0");
    docdate.value = t2ViewValue.currReadingDate ?? "0";
    isFinalReading.value =
        t1ViewValue.value.finalReadingYn == "Y" ? true : false;
    lstrSignature.value = base64.decode(t1ViewValue.value.signature ?? "");
    frontImage.value = base64.decode(t1ViewValue.value.imgEidFront ?? "");
    backImage.value = base64.decode(t1ViewValue.value.imgEidBack ?? "");

    meterImage.value = base64.decode(t1ViewValue.value.imgMeter ?? "");
    int totalMonth = calculateMonthCount(Helper.dateDifferance(
        previousDateString: t2ViewValue.lastReadingDate ?? "0"));

    ///AMOUNT///
    ///Consumption charge///
    chargeRows[0].txtCurrentAmt.text =
        Helper.mfnDbl(t1ViewValue.value.readingChargeTotal).toString();
    chargeRows[0].taxPerc.value = Helper.mfnDbl(t2ViewValue.taxpercReadcharge);
    chargeRows[0].currTaxAmount.value =
        Helper.mfnDbl(t1ViewValue.value.readingChargeTaxTotal);

    ///Service charge/MONTHLY///

    chargeRows[1].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.monthlyFee).toString();
    chargeRows[1].taxPerc.value = Helper.mfnDbl(t2ViewValue.taxpercMonthlyFee);
    chargeRows[1].currTaxAmount.value =
        Helper.mfnDbl(t1ViewValue.value.monthlyFeeTaxTotal);

    ///Maintenance charge///
    chargeRows[2].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.maintenanceAmt).toString();
    chargeRows[2].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.taxpercMaintenanceAmt);
    chargeRows[2].currTaxAmount.value =
        Helper.mfnDbl(t1ViewValue.value.maintenanceAmtTaxTotal);

    ///Administration///
    chargeRows[3].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.administrationAmt).toString();
    chargeRows[3].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.administrationTaxPerc);
    chargeRows[3].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.administrationTaxAmt);

    ///Bill & Meter Reading fee///
    chargeRows[4].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.billMeterReadingAmt).toString();
    chargeRows[4].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.billMeterReadingTaxPerc);
    chargeRows[4].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.billMeterReadingTaxAmt);

    ///Facility Management fee///
    chargeRows[5].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.facilityManageAmt).toString();
    chargeRows[5].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.facilityManageTaxPerc);
    chargeRows[5].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.facilityManageTaxAmt);

    ///Boiler gas Consumption///
    chargeRows[6].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.boilerGasConsumptionAmt).toString();
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.boilerGasConsumptionTaxPerc);
    chargeRows[6].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.boilerGasConsumptionTaxAmt);

    ///Delay payment fee///
    chargeRows[7].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.delayPaymentAmt).toString();
    chargeRows[7].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.delayPaymentTaxPerc);
    chargeRows[7].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.delayPaymentTaxAmt);

    ///Security fee///
    chargeRows[8].txtCurrentAmt.text =
        Helper.mfnDbl(t2ViewValue.securityDepReturnAmt).toString();
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(t2ViewValue.securityDepReturnTaxPerc);
    chargeRows[8].currTaxAmount.value =
        Helper.mfnDbl(t2ViewValue.securityDepReturnTaxAmt);

    ///Other charge///

    chargeRows[9].taxPerc.value = Helper.mfnDbl(t2ViewValue.otherAmt);

    chargeRows[9].txtCurrentAmt.text =
        (Helper.mfnDbl(t1ViewValue.value.otherAmtTaxTotal) / 100).toString();
    chargeRows[9].currTaxAmount.value =
        Helper.mfnDbl(t1ViewValue.value.otherAmtTaxTotal);
    // fnCalculateValues();
    fnTotalAmount();
  }

  _fnSaveSuccess() {
    successPopup();
    fnGetLastGasMeterReading(mode: "LAST", docNo: "");
    isEditModeEnabled.value = false;
  }

  fnDeleteGasReading() {
    Helper.fngetTocken().then((token) {
      showLoadingDialog();

      if (token != null) {
        gasReadingRepository
            .deleteGasReadingDetails(
                docNo: txtDocNumController.text, token: token)
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

  fnValidateApartment() {
    showLoadingDialog();
    Helper.fngetTocken().then((token) {
      if (token != null) {
        gasReadingRepository
            .validateApartment(
                token: token,
                apartmentCode: txtApartmentCodeController.text,
                buildingCode: txtBuildingCodeController.text)
            .then((value) {
          if (value != null) {
            selectedApartmentData = value;
            if (Get.isDialogOpen == true) {
              Get.back();
            }
            if (Global.monthlyFeeYn == true) {
              fnFillApartmentDetailsDailyBasis();
            } else {
              fnFillApartmentDetails();
            }
            if (Get.isDialogOpen == true) {
              Get.back();
            }
          }

          // isEditModeEnabled.value = true;
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

  fnSaveValidate() async {
    if (txtBuildingCodeController.text.isEmpty) {
      errorMsg(msg: "Building code is not selected");
      return false;
    }
    if (txtApartmentCodeController.text.isEmpty) {
      errorMsg(msg: "Apartment is not selected");
      return false;
    }
    if (lstrByteSignature.isEmpty) {
      errorMsg(msg: "Signature cant be empty");
      return false;
    }
    if (txtCurrentReadingController.text.isEmpty) {
      errorMsg(msg: "Current Reading cant be empty");
      return false;
    }
    if (double.parse(txtConsumptionController.text) < 0) {
      errorMsg(msg: "Invalid reading: previous exceeds current.");
      return false;
    }
    return true;
  }

  fnCalculateValues() {
    chargeRows[0].txtCurrentAmt.text =
        ((Helper.mfnDbl(txtConsumptionController.text)) *
                Helper.mfnDbl(txtConvertionFactorController.text) *
                Helper.mfnDbl(txtUnitPriceController.text))
            .toString();
    chargeRows[0].currTaxAmount.value =
        Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text) *
            (chargeRows[0].taxPerc.value / 100);
    if (selectedApartmentData.table2![0].otherRequiredYN == "Y" &&
        selectedApartmentData.table2![0].otherAmtCalcType == "L") {
      chargeRows[0].txtCurrentAmt.text =
          ((Helper.mfnDbl(txtConsumptionController.text)) *
                  Helper.mfnDbl(txtConvertionFactorController.text) *
                  Helper.mfnDbl(txtUnitPriceController.text))
              .toString();
      chargeRows[9].currTaxAmount.value =
          Helper.mfnDbl(chargeRows[9].txtCurrentAmt.text) *
              (chargeRows[9].taxPerc.value / 100);
    }

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
    logger.f("${totalCurrAmount.value}+ " "+${totalCurrTaxAmount.value}");
    netAmount.value = totalCurrAmount.value + totalCurrTaxAmount.value;
  }

  void fnConsumptionCalculator(value) {
    double lastReadingValue = Helper.mfnDbl(txtLastReadingController.text);
    double consumption = Helper.mfnDbl(value) - lastReadingValue;
    txtConsumptionController.text = consumption.toStringAsFixed(3);

    fnCalculateValues();
  }

  int calculateMonthCount(int value) {
    int quotient = value ~/ 30; // Integer division
    int remainder = value % 30; // Remainder

    if (remainder >= 15) {
      quotient += 1;
    }

    return quotient;
  }

  _taxAmt({required int index}) {
    return Helper.mfnDbl(chargeRows[index].txtCurrentAmt.text) *
        (chargeRows[index].taxPerc.value / 100);
  }

  fnFillApartmentDetails() {
        if (selectedApartmentData.table2!.isEmpty || selectedApartmentData.table2 == null) {
      return;
    }
    Table2? t2Data = selectedApartmentData.table2?[0];

    ///DATA/////
    txtContractNoController.text = t2Data!.lastContractNo ?? "0";
    txtGasMeterController.text = t2Data.gasMeterNo ?? "0";
    txtLastReadingController.text = t2Data.lastReading ?? "0";
    txtUnitPriceController.text = t2Data.unitPrice ?? "0";
    txtTenantNameController.text = t2Data.partyname ?? "";
    txtPartyCodeController.text = t2Data.partycode ?? "";
    txtConvertionFactorController.text = t2Data.readingConversion ?? "";
    lastReadingDate.value =
        Helper.convertDateFormat1(dateTime: t2Data.lastReadingDate ?? "0");
    int totalMonth = calculateMonthCount(Helper.dateDifferance(
        previousDateString: t2Data.lastReadingDate ?? "0"));
    txtConvertionFactorController.text = t2Data.readingConversion ?? "";
    lastReadingDate.value =
        Helper.convertDateFormat1(dateTime: t2Data.lastReadingDate ?? "0");
    txtOutStantingAmtController.text = t2Data.outStandingAmount ?? "0.0";
    txtlastPaidController.text = t2Data.lastPaidAmount ?? "0.0";

    ///AMOUNT///
    ///Consumption charge///
    chargeRows[0].txtCurrentAmt.text = "0.00";
    chargeRows[0].taxPerc.value = Helper.mfnDbl(t2Data.readingVat);
    chargeRows[0].currTaxAmount.value = 0.00;

    ///Service charge/MONTHLY///

    chargeRows[1].dailyBasicsAmt.value = Helper.mfnDbl(t2Data.monthlyFee);
    chargeRows[1].taxPerc.value = Helper.mfnDbl(t2Data.monthlyVat);
    chargeRows[1].txtCurrentAmt.text =
        (chargeRows[1].dailyBasicsAmt.value * totalMonth).toString();
    chargeRows[1].currTaxAmount.value = _taxAmt(index: 1);

    ///Maintenance charge///
    chargeRows[2].dailyBasicsAmt.value =
        Helper.mfnDbl(t2Data.maintenanceAmt.toString());
    chargeRows[2].taxPerc.value = Helper.mfnDbl(t2Data.maintenanceVat);
    chargeRows[2].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[2].dailyBasicsAmt.value) * totalMonth)
            .toString();
    chargeRows[2].currTaxAmount.value = _taxAmt(index: 2);

    ///Administration///
    chargeRows[3].dailyBasicsAmt.value =
        Helper.mfnDbl(t2Data.administrationAmt.toString());
    chargeRows[3].taxPerc.value = Helper.mfnDbl(t2Data.administrationTaxPerc);
    chargeRows[3].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[3].dailyBasicsAmt.value) * totalMonth)
            .toString();
    chargeRows[3].currTaxAmount.value = _taxAmt(index: 3);

    ///Bill & Meter Reading fee///
    chargeRows[4].dailyBasicsAmt.value =
        Helper.mfnDbl(t2Data.billMeterReadingAmt.toString());
    chargeRows[4].taxPerc.value = Helper.mfnDbl(t2Data.billMeterReadingTaxPerc);
    chargeRows[4].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[4].dailyBasicsAmt.value) * totalMonth)
            .toString();
    chargeRows[4].currTaxAmount.value = _taxAmt(index: 4);

    ///Facility Management fee///
    chargeRows[5].dailyBasicsAmt.value =
        Helper.mfnDbl(t2Data.facilityManageAmt.toString());
    chargeRows[5].taxPerc.value = Helper.mfnDbl(t2Data.facilityManageTaxPerc);
    chargeRows[5].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[5].dailyBasicsAmt.value) * totalMonth)
            .toString();
    chargeRows[5].currTaxAmount.value = _taxAmt(index: 5);

    ///Boiler gas Consumption///
    chargeRows[6].dailyBasicsAmt.value =
        Helper.mfnDbl(t2Data.boilerGasConsumptionAmt.toString());
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(t2Data.boilerGasConsumptionTaxPerc);
    chargeRows[6].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[6].dailyBasicsAmt.value) * totalMonth)
            .toString();
    chargeRows[6].currTaxAmount.value = _taxAmt(index: 6);

    ///Delay payment fee///
    chargeRows[7].dailyBasicsAmt.value =
        Helper.mfnDbl(t2Data.delayPaymentAmt.toString());
    chargeRows[7].taxPerc.value = Helper.mfnDbl(t2Data.delayPaymentTaxPerc);
    chargeRows[7].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[7].dailyBasicsAmt.value) * totalMonth)
            .toString();
    chargeRows[7].currTaxAmount.value = _taxAmt(index: 7);

    ///Security fee///
    chargeRows[8].dailyBasicsAmt.value =
        Helper.mfnDbl(t2Data.securityDepReturnAmt.toString());
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(t2Data.securityDepReturnTaxPerc);
    chargeRows[8].txtCurrentAmt.text =
        (Helper.mfnDbl(chargeRows[8].dailyBasicsAmt.value) * totalMonth)
            .toString();
    chargeRows[8].currTaxAmount.value = _taxAmt(index: 8);

    ///Other charge///

    chargeRows[9].taxPerc.value = Helper.mfnDbl(t2Data.otheramtVat);
    if (t2Data.otherRequiredYN == "Y") {
      /// "A"=OtherAmtCalcAmt=txtCurrentAmt///
      /// "P"=Consumption Amt*OtherAmtCalcAmt=txtCurrentAmt///
      /// "L"=Total Unit*OtherAmtCalcAmt=txtCurrentAmt///
      if (t2Data.otherAmtCalcType == "A") {
        chargeRows[9].txtCurrentAmt.text =
            (Helper.mfnDbl(t2Data.otherAmtCalcAmt) / 30).toString();
        chargeRows[9].currTaxAmount.value =
            Helper.mfnDbl(chargeRows[9].txtCurrentAmt.text) *
                (chargeRows[9].taxPerc.value / 100);
      } else if (t2Data.otherAmtCalcType == "P") {
        chargeRows[9].txtCurrentAmt.text =
            (Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text) *
                    (Helper.mfnDbl(t2Data.otherAmtCalcAmt) / 100))
                .toString();
        chargeRows[9].currTaxAmount.value =
            Helper.mfnDbl(chargeRows[9].txtCurrentAmt.text) *
                (chargeRows[9].taxPerc.value / 100);
      } else if (t2Data.otherAmtCalcType == "L") {
        chargeRows[9].txtCurrentAmt.text =
            Helper.mfnDbl(txtConsumptionController.text) *
                Helper.mfnDbl(t2Data.otherAmtCalcAmt);
        chargeRows[9].currTaxAmount.value =
            Helper.mfnDbl(chargeRows[9].txtCurrentAmt.text) *
                (chargeRows[9].taxPerc.value / 100);
      }
    } else {
      chargeRows[9].txtCurrentAmt.text = "0.00";
      chargeRows[9].currTaxAmount.value = 0.00;
    }

    ///Fuel Surcharge fee///
    if (Global.enableFuelSurcharge == "Y") {
      chargeRows[10].dailyBasicsAmt.value =
          Helper.mfnDbl(t2Data.fuelSurchargeAmtfc.toString());
      chargeRows[10].taxPerc.value = Helper.mfnDbl(t2Data.fuelSurchargeTaxPerc);
      chargeRows[10].txtCurrentAmt.text =
          (Helper.mfnDbl(chargeRows[8].dailyBasicsAmt.value) * totalMonth)
              .toString();
      chargeRows[10].currTaxAmount.value = _taxAmt(index: 8);
    }

    fnCalculateValues();
  }

  fnFillApartmentDetailsDailyBasis() {
     if (selectedApartmentData.table2!.isEmpty || selectedApartmentData.table2 == null) {
      return;
    }
    Table2? t2Data = selectedApartmentData.table2?[0];

    ///DATA/////
    txtContractNoController.text = t2Data!.lastContractNo ?? "0";
    txtGasMeterController.text = t2Data.gasMeterNo ?? "0";
    txtLastReadingController.text = t2Data.lastReading ?? "0";
    txtUnitPriceController.text = t2Data.unitPrice ?? "0";
    txtTenantNameController.text = t2Data.partyname ?? "";
    txtPartyCodeController.text = t2Data.partycode ?? "";
    txtConvertionFactorController.text = t2Data.readingConversion ?? "";
    lastReadingDate.value =
        Helper.convertDateFormat1(dateTime: t2Data.lastReadingDate ?? "0");
    txtOutStantingAmtController.text = t2Data.outStandingAmount ?? "0.0";
    txtlastPaidController.text = t2Data.lastPaidAmount ?? "0.0";

    ///AMOUNT///
    ///Consumption charge///
    chargeRows[0].txtCurrentAmt.text = "0.00";
    chargeRows[0].taxPerc.value = Helper.mfnDbl(t2Data.readingVat);
    chargeRows[0].currTaxAmount.value = 0.00;

    ///Service charge/MONTHLY///

    chargeRows[1].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.monthlyFee) / 30);
    chargeRows[1].txtCurrentAmt.text = (chargeRows[1].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[1].taxPerc.value = Helper.mfnDbl(t2Data.monthlyVat);
    chargeRows[1].currTaxAmount.value = _taxAmt(index: 1);

    ///Maintenance charge///
    chargeRows[2].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.maintenanceAmt) / 30);
    chargeRows[2].taxPerc.value = Helper.mfnDbl(t2Data.maintenanceVat);
    chargeRows[2].txtCurrentAmt.text = (chargeRows[2].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[2].currTaxAmount.value = _taxAmt(index: 2);

    ///Administration///
    chargeRows[3].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.administrationAmt) / 30);
    chargeRows[3].taxPerc.value = Helper.mfnDbl(t2Data.administrationTaxPerc);
    chargeRows[3].txtCurrentAmt.text = (chargeRows[3].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[3].currTaxAmount.value = _taxAmt(index: 3);

    ///Bill & Meter Reading fee///
    chargeRows[4].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.billMeterReadingAmt) / 30);
    chargeRows[4].txtCurrentAmt.text = (chargeRows[4].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[4].taxPerc.value = Helper.mfnDbl(t2Data.billMeterReadingTaxPerc);
    chargeRows[4].currTaxAmount.value = _taxAmt(index: 4);

    ///Facility Management fee///
    chargeRows[5].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.facilityManageAmt) / 30);
    chargeRows[5].taxPerc.value = Helper.mfnDbl(t2Data.facilityManageTaxPerc);
    chargeRows[5].txtCurrentAmt.text = (chargeRows[5].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[5].currTaxAmount.value = _taxAmt(index: 5);

    ///Boiler gas Consumption///
    chargeRows[6].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.boilerGasConsumptionAmt) / 30);
    chargeRows[6].taxPerc.value =
        Helper.mfnDbl(t2Data.boilerGasConsumptionTaxPerc);
    chargeRows[6].txtCurrentAmt.text = (chargeRows[6].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[6].currTaxAmount.value = _taxAmt(index: 6);

    ///Delay payment fee///
    chargeRows[7].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.delayPaymentAmt) / 30);
    chargeRows[7].taxPerc.value = Helper.mfnDbl(t2Data.delayPaymentTaxPerc);
    chargeRows[7].txtCurrentAmt.text = (chargeRows[7].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[7].currTaxAmount.value = _taxAmt(index: 7);

    ///Security fee///
    chargeRows[8].dailyBasicsAmt.value =
        (Helper.mfnDbl(t2Data.securityDepReturnAmt) / 30);
    chargeRows[8].txtCurrentAmt.text = (chargeRows[8].dailyBasicsAmt.value *
            Helper.dateDifferance(
                previousDateString: t2Data.lastReadingDate ?? "0"))
        .toString();
    chargeRows[8].taxPerc.value =
        Helper.mfnDbl(t2Data.securityDepReturnTaxPerc);
    chargeRows[8].currTaxAmount.value = _taxAmt(index: 8);

    ///Other charge///
    chargeRows[9].taxPerc.value = Helper.mfnDbl(t2Data.otheramtVat);
    if (t2Data.otherRequiredYN == "Y") {
      /// "A"=OtherAmtCalcAmt=txtCurrentAmt///
      /// "P"=Consumption Amt*OtherAmtCalcAmt=txtCurrentAmt///
      /// "L"=Total Unit*OtherAmtCalcAmt=txtCurrentAmt///
      if (t2Data.otherAmtCalcType == "A") {
        chargeRows[9].txtCurrentAmt.text =
            (Helper.mfnDbl(t2Data.otherAmtCalcAmt) / 30).toString();
        chargeRows[9].currTaxAmount.value =
            Helper.mfnDbl(chargeRows[9].txtCurrentAmt.text) *
                (chargeRows[9].taxPerc.value / 100);
      } else if (t2Data.otherAmtCalcType == "P") {
        chargeRows[9].txtCurrentAmt.text =
            (Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text) *
                    (Helper.mfnDbl(t2Data.otherAmtCalcAmt) / 100))
                .toString();
        chargeRows[9].currTaxAmount.value =
            Helper.mfnDbl(chargeRows[9].txtCurrentAmt.text) *
                (chargeRows[9].taxPerc.value / 100);
      } else if (t2Data.otherAmtCalcType == "L") {
        chargeRows[9].dailyBasicsAmt = Helper.mfnDbl(t2Data.otherAmtCalcAmt);
      }
    } else {
      chargeRows[9].txtCurrentAmt.text = "0.00";
      chargeRows[9].currTaxAmount.value = 0.00;
    }

    ///Fuel Surcharge fee///
    if (Global.enableFuelSurcharge == "Y") {
      chargeRows[10].dailyBasicsAmt.value =
          (Helper.mfnDbl(t2Data.fuelSurchargeAmtfc) / 30);
      chargeRows[10].txtCurrentAmt.text = (chargeRows[10].dailyBasicsAmt.value *
              Helper.dateDifferance(
                  previousDateString: t2Data.lastReadingDate ?? "0"))
          .toString();
      chargeRows[10].taxPerc.value = Helper.mfnDbl(t2Data.fuelSurchargeTaxPerc);
      chargeRows[10].currTaxAmount.value = _taxAmt(index: 8);
    }
    fnCalculateValues();
  }
}
