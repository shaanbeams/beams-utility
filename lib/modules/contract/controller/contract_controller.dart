import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/contract/models/contract_model.dart';
import 'package:gas_utility_app/modules/contract/repository/contract_repository.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/save_pop_up.dart';
import 'package:gas_utility_app/support/enums.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:signature/signature.dart';

import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/custom_theme.dart';

class ContractController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool floatingIsExpanded = true.obs;

  final Rx<PageController> pageController = PageController(initialPage: 0).obs;

  RxInt selectedTabExe = 0.obs;
  RxString? selectedOption;
  RxString selectedTabString = "Connection Request Details".obs;

  RxBool isEditModeEnabled = false.obs;
  Rx<SaveModes> saveMode = SaveModes.add.obs;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: ThemeColors.black,
    exportBackgroundColor: Colors.white,
  );
  Rx<ContractModel?> selectedContract = ContractModel().obs;
  // RxString contractDate = DateTime.now().toString().obs;
  RxnString contractDate = RxnString();
  RxnString connectionDate = RxnString();
  // RxString connectionDate = DateTime.now().toString().obs;
  RxString lastReadingDate = DateTime.now().toString().obs;
  RxBool otherAmountReq = false.obs;
  RxString otherAmountCalcType = "".obs;

  //===========txtControllers===================================//
  //===========connection Req===================================//

  TextEditingController txtReqDocTypeController =
      TextEditingController(text: "");
  TextEditingController txtReqNoController = TextEditingController(text: "");

  TextEditingController txtcontractNoController =
      TextEditingController(text: "");

  TextEditingController txtPriorityController = TextEditingController(text: "");
  TextEditingController txtBuildingCodeController =
      TextEditingController(text: "");
  TextEditingController txtAppartmentCodeController =
      TextEditingController(text: "");
  TextEditingController txtBillingCustomerController =
      TextEditingController(text: "");
  TextEditingController txtStockLocationController =
      TextEditingController(text: "");
  TextEditingController txtMeterPressureController =
      TextEditingController(text: "");
  TextEditingController txtBranchController = TextEditingController(text: "");
  TextEditingController txtDivisionController = TextEditingController(text: "");
  TextEditingController txtCostCenterController =
      TextEditingController(text: "");
  TextEditingController txtSalesManController = TextEditingController(text: "");
  TextEditingController txtOtherRequiredAmountController =
      TextEditingController(text: "");
  TextEditingController txtCustomerIdController =
      TextEditingController(text: "");

  //===========others===================================//
  TextEditingController txtCityController = TextEditingController(text: "");
  TextEditingController txtCountryController = TextEditingController(text: "");
  TextEditingController txtNameController = TextEditingController(text: "");
  TextEditingController txtArabicNameController =
      TextEditingController(text: "");
  TextEditingController txtEmailController = TextEditingController(text: "");
  TextEditingController txtAddressController = TextEditingController(text: "");
  TextEditingController txtArabicAddressController =
      TextEditingController(text: "");
  TextEditingController txtWhatsappNoController =
      TextEditingController(text: "");
  TextEditingController txtMobileNoController = TextEditingController(text: "");
  TextEditingController txtTel1Controller = TextEditingController(text: "");
  TextEditingController txtTel2Controller = TextEditingController(text: "");
  TextEditingController txtPOBoxnoController = TextEditingController(text: "");
  TextEditingController txtTINNoController = TextEditingController(text: "");
  TextEditingController txtCRDayController = TextEditingController(text: "");
  TextEditingController txtACGP1Controller = TextEditingController(text: "");
  TextEditingController txtACGP2Controller = TextEditingController(text: "");
  TextEditingController txtACGP3Controller = TextEditingController(text: "");
  TextEditingController txtACGP4Controller = TextEditingController(text: "");
  TextEditingController txtACGP5Controller = TextEditingController(text: "");
  TextEditingController txtACGP6Controller = TextEditingController(text: "");
  //===========main===================================//
  TextEditingController txtStatusController = TextEditingController(text: "");
  TextEditingController txtGasMeterNoController =
      TextEditingController(text: "");
  TextEditingController txtReadingConvController =
      TextEditingController(text: "");
  TextEditingController txtConsumptionConvController =
      TextEditingController(text: "");
  TextEditingController txtTotalAmountController =
      TextEditingController(text: "00.00");
      final RxString totalAmountString = "00.00".obs;
  TextEditingController txtUnitPriceController =
      TextEditingController(text: "");
  TextEditingController txtStartReadingController =
      TextEditingController(text: "");
  TextEditingController txtLastReadingController =
      TextEditingController(text: "");
  TextEditingController txtRemarksController = TextEditingController(text: "");
  TextEditingController txtDepositController = TextEditingController(text: "");
  TextEditingController txtDepositVATController =
      TextEditingController(text: "");

  TextEditingController txtInsuranceController =
      TextEditingController(text: "");
  TextEditingController txtInsuranceVATController =
      TextEditingController(text: "");
  TextEditingController txtMonthlyController = TextEditingController(text: "");
  TextEditingController txtMonthlyVATController =
      TextEditingController(text: "");
  TextEditingController txtBoilerGasController =
      TextEditingController(text: "");
  TextEditingController txtBoilerGasVATController =
      TextEditingController(text: "");
  // TextEditingController txtDepositController = TextEditingController(text: "");

  TextEditingController txtConnectionController =
      TextEditingController(text: "");
  TextEditingController txtConnectionVATController =
      TextEditingController(text: "");
  TextEditingController txtMaintananceController =
      TextEditingController(text: "");
  TextEditingController txtMaintananceVATController =
      TextEditingController(text: "");
  TextEditingController txtDisconnectionController =
      TextEditingController(text: "");
  TextEditingController txtDisconnectionVATController =
      TextEditingController(text: "");
  TextEditingController txtRegistrationController =
      TextEditingController(text: "");
  TextEditingController txtRegistrationVATController =
      TextEditingController(text: "");
  TextEditingController txtClearanceController =
      TextEditingController(text: "");
  TextEditingController txtClearanceVATController =
      TextEditingController(text: "");
  TextEditingController txtOther1Controller = TextEditingController(text: "");
  TextEditingController txtOther2Controller = TextEditingController(text: "");
  TextEditingController txtOther3Controller = TextEditingController(text: "");
  TextEditingController txtOtherVAT1Controller =
      TextEditingController(text: "");
  TextEditingController txtOtherVAT2Controller =
      TextEditingController(text: "");
  TextEditingController txtOtherVAT3Controller =
      TextEditingController(text: "");
  TextEditingController txtAdministrationController =
      TextEditingController(text: "");
  TextEditingController txtAdministrationVATController =
      TextEditingController(text: "");
  TextEditingController txtBillMeterReadingController =
      TextEditingController(text: "");
  TextEditingController txtBillMeterReadingVATController =
      TextEditingController(text: "");
  TextEditingController txtFacilityController = TextEditingController(text: "");
  TextEditingController txtFacilityVATController =
      TextEditingController(text: "");
  TextEditingController txtDelayController = TextEditingController(text: "");
  TextEditingController txtDelayVATController = TextEditingController(text: "");
  TextEditingController txtSecurityController = TextEditingController(text: "");
  TextEditingController txtSecurityVATController =
      TextEditingController(text: "");

  //==============================================================
  ContractRepository contractRepository = ContractRepository();

////////////////////////////////////////////IMAGE
  var lstrByte64Img1 = "";
  var lbytesImage1 = Uint8List(0).obs;
  var lstrByte64Img2 = "";
  var lbytesImage2 = Uint8List(0).obs;
  var lstrByteSignature = "";
  var lstrSignature = Uint8List(0).obs;

  fngetContractDetails() {
    Helper.fngetTocken().then((token) {
      if (token != null) {
        contractRepository
            .getContractDetails(token: token)
            .then((selectedContract) {
          logger.i(selectedContract?.email);
          _fnGetAssignUserListSuccess(
              contract: selectedContract ?? ContractModel());
        });
      }
    });
  }

  fngetLastContractDetails({required String docNo, required String mode}) {
    Helper.fngetTocken().then((token) {
      if (token != null) {
        contractRepository
            .getLastContractDetails(token: token, docno: docNo, mode: mode)
            .then((selectedContract) {
          _fnGetAssignUserListSuccess(
              contract: selectedContract ?? ContractModel());
        });
      }
    });
  }

  _fnGetAssignUserListSuccess({required ContractModel contract}) {
    selectedContract.value = contract;
    _fillData();
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
  // Calculate total amount + VAT dynamically using your existing controllers
void calculateAndSetTotalAmount() {
  double total = 0.0;

  // Map your actual controller instances into a list of pairs
  final List<Map<String, TextEditingController>> amountPairs = [
    {"amt": txtMonthlyController, "vat": txtMonthlyVATController},
    {"amt": txtBoilerGasController, "vat": txtBoilerGasVATController},
    {"amt": txtInsuranceController, "vat": txtInsuranceVATController},
    {"amt": txtDepositController, "vat": txtDepositVATController},
    {"amt": txtConnectionController, "vat": txtConnectionVATController},
    {"amt": txtMaintananceController, "vat": txtMaintananceVATController},
    {"amt": txtDisconnectionController, "vat": txtDisconnectionVATController},
    {"amt": txtClearanceController, "vat": txtClearanceVATController},
    {"amt": txtRegistrationController, "vat": txtRegistrationVATController},
    {"amt": txtAdministrationController, "vat": txtAdministrationVATController},
    {"amt": txtBillMeterReadingController, "vat": txtBillMeterReadingVATController},
    {"amt": txtFacilityController, "vat": txtFacilityVATController},
    {"amt": txtDelayController, "vat": txtDelayVATController},
    {"amt": txtSecurityController, "vat": txtSecurityVATController},
    {"amt": txtOther1Controller, "vat": txtOtherVAT1Controller},
    {"amt": txtOther2Controller, "vat": txtOtherVAT2Controller},
    {"amt": txtOther3Controller, "vat": txtOtherVAT3Controller},
  ];

  for (var pair in amountPairs) {
    double amount = double.tryParse(pair["amt"]?.text ?? "") ?? 0.0;
    double vatPercent = double.tryParse(pair["vat"]?.text ?? "") ?? 0.0;

    // Add amount plus its calculated VAT portion
    double itemTotal = amount + (amount * (vatPercent / 100));
    total += itemTotal;
  }

  String formattedTotal = total.toStringAsFixed(2);
  
  // Update your total controllers
  txtTotalAmountController.text = formattedTotal;
  totalAmountString.value = formattedTotal;
}

String _formatDecimal(dynamic value, {int decimalPlaces = 2}) {
  if (value == null) return '';
  final strValue = value.toString().trim();
  if (strValue.isEmpty) return '';
  
  final number = double.tryParse(strValue);
  if (number == null) return strValue; // Return original string if it's not a valid number
  
  return number.toStringAsFixed(decimalPlaces);
}

  // _fillData() {
  //   logger.i(
  //       "selectedContract.value?.reqDocNo: ${selectedContract.value?.contractDate}");
  //   logger.i(
  //       "selectedContract.value?.reqDocNo: ${selectedContract.value?.connectionDate}");
  //   //====================connection req=========================

  //   txtReqNoController.text = selectedContract.value?.reqDocNo == null
  //       ? selectedContract.value?.contractNo ?? ""
  //       : selectedContract.value?.reqDocNo ?? "";
  //   txtcontractNoController.text = selectedContract.value?.reqDocNo == null
  //       ? ""
  //       : selectedContract.value?.contractNo ?? "";

  //   txtReqDocTypeController.text = selectedContract.value?.doctype ?? "";
  //   txtPriorityController.text = selectedContract.value?.contractPriority ?? "";
  //   txtBuildingCodeController.text = selectedContract.value?.buildingCode ?? "";
  //   txtAppartmentCodeController.text =
  //       selectedContract.value?.apartmentCode ?? "";
  //   txtBillingCustomerController.text =
  //       selectedContract.value?.billingCustomer ?? "";
  //   txtStockLocationController.text = selectedContract.value?.loc ?? "";
  //   txtMeterPressureController.text =
  //       selectedContract.value?.meterPressure ?? "";
  //   txtBranchController.text = selectedContract.value?.brncode ?? "";
  //   txtDivisionController.text = selectedContract.value?.divcode ?? "";
  //   txtCostCenterController.text = selectedContract.value?.cccode ?? "";
  //   txtSalesManController.text = selectedContract.value?.sman ?? "";
  //   otherAmountReq.value =
  //       selectedContract.value?.otherRequiredYn == "Y" ? true : false;

  //   contractDate.value =
  //       selectedContract.value?.contractDate ?? DateTime.now().toString();
  //   connectionDate.value =
  //       selectedContract.value?.connectionDate ?? DateTime.now().toString();

  //   //===================other=====================================

  //   txtCityController.text = selectedContract.value?.city ?? "";
  //   txtCountryController.text = selectedContract.value?.country ?? "";
  //   txtNameController.text = selectedContract.value?.partyname ?? "";
  //   txtArabicNameController.text =
  //       selectedContract.value?.arabicPartyname ?? "";
  //   txtEmailController.text = selectedContract.value?.email ?? "";
  //   txtAddressController.text = selectedContract.value?.address1 ?? "";
  //   txtArabicAddressController.text =
  //       selectedContract.value?.arabicAddress1 ?? "";
  //   // txtWhatsappNoController.text = ;
  //   txtMobileNoController.text = selectedContract.value?.mobile ?? "";
  //   txtTel1Controller.text = selectedContract.value?.tel1 ?? "";
  //   txtTel2Controller.text = selectedContract.value?.tel2 ?? "";
  //   txtPOBoxnoController.text = selectedContract.value?.pobox ?? "";
  //   txtTINNoController.text = selectedContract.value?.tinno ?? "";
  //   //  txtCRDay .text = selectedContract.value?.cr??"";
  //   txtACGP1Controller.text = selectedContract.value?.acgp1 ?? "";
  //   txtACGP2Controller.text = selectedContract.value?.acgp2 ?? "";
  //   txtACGP3Controller.text = selectedContract.value?.acgp3 ?? "";
  //   txtACGP4Controller.text = selectedContract.value?.acgp4 ?? "";
  //   txtACGP5Controller.text = selectedContract.value?.acgp5 ?? "";
  //   txtACGP6Controller.text = selectedContract.value?.acgp6 ?? "";

  //   //=====================main=================================
  //   txtStatusController.text = selectedContract.value?.status ?? "";
  //   txtGasMeterNoController.text = selectedContract.value?.gasMeterNo ?? "";
  //   txtReadingConvController.text =
  //       selectedContract.value?.readingConversion ?? "";
  //   txtConsumptionConvController.text =
  //       selectedContract.value?.consumptionConversion ?? "";
  //   txtTotalAmountController.text = selectedContract.value?.amtfc ?? "";
  //   totalAmountString.value = selectedContract.value?.amtfc ?? "00.00";
  //   txtUnitPriceController.text = selectedContract.value?.unitPrice ?? "";
  //   txtStartReadingController.text = selectedContract.value?.startReading ?? "";
  //   txtLastReadingController.text = selectedContract.value?.lastReading ?? "";
  //   txtRemarksController.text = selectedContract.value?.remarks ?? "";

  //   //==================amount detaild===========================
  //   txtInsuranceController.text = selectedContract.value?.insAmtfc ?? "";
  //   txtInsuranceVATController.text =
  //       selectedContract.value?.insuranceVatperc ?? "";
  //   txtMonthlyController.text = selectedContract.value?.monthlyFee ?? "";
  //   txtMonthlyVATController.text = selectedContract.value?.monthlyVatperc?? "";
  //   txtBoilerGasController.text =
  //       selectedContract.value?.boilerGasConsumptionAmtfc ?? "";
  //   txtBoilerGasVATController.text =
  //       selectedContract.value?.boilerGasConsumptionTaxPerc ?? "";
  //   txtDepositController.text = selectedContract.value?.depositAmtfc ?? "";
  //   txtDepositVATController.text = selectedContract.value?.depositVatperc ?? "";
  //   txtConnectionController.text =
  //       selectedContract.value?.connectionAmtfc ?? "";
  //   txtConnectionVATController.text =
  //       selectedContract.value?.connectionVatperc ?? "";
  //   txtMaintananceController.text =
  //       selectedContract.value?.maintenanceAmtfc ?? "";
  //   txtMaintananceVATController.text =
  //       selectedContract.value?.maintenanceVatperc ?? "";
  //   txtDisconnectionController.text =
  //       selectedContract.value?.disconnectionAmtfc ?? "";
  //   txtDisconnectionVATController.text =
  //       selectedContract.value?.disconnectionVatperc ?? "";
  //   txtClearanceController.text = selectedContract.value?.clearanceAmtfc ?? "";
  //   txtClearanceVATController.text =
  //       selectedContract.value?.clearanceVatperc ?? "";
  //   txtRegistrationController.text =
  //       selectedContract.value?.registrationAmtfc ?? "";
  //   txtRegistrationVATController.text =
  //       selectedContract.value?.registrationVatperc ?? "";
  //   txtAdministrationController.text =
  //       selectedContract.value?.administrationAmtfc ?? "";
  //   txtAdministrationVATController.text =
  //       selectedContract.value?.administrationTaxPerc ?? "";
  //   txtBillMeterReadingController.text =
  //       selectedContract.value?.billMeterReadingAmtfc ?? "";
  //   txtBillMeterReadingVATController.text =
  //       selectedContract.value?.billMeterReadingTaxPerc ?? "";
  //   txtFacilityController.text =
  //       selectedContract.value?.facilityManageAmtfc ?? "";
  //   txtFacilityVATController.text =
  //       selectedContract.value?.facilityManageTaxPerc ?? "";
  //   txtDelayController.text = selectedContract.value?.delayPaymentAmtfc ?? "";
  //   txtDelayVATController.text =
  //       selectedContract.value?.delayPaymentTaxPerc ?? "";
  //   txtSecurityController.text =
  //       selectedContract.value?.securityDepReturnAmtfc ?? "";
  //   txtSecurityVATController.text =
  //       selectedContract.value?.securityDepReturnTaxPerc ?? "";
  //   txtDepositController.text = selectedContract.value?.depositAmtfc ?? "";
  //   txtDepositVATController.text = selectedContract.value?.depositVatperc ?? "";
  //   txtOther1Controller.text = selectedContract.value?.other1Amtfc ?? "";
  //   txtOther2Controller.text = selectedContract.value?.other2Amtfc ?? "";
  //   txtOther3Controller.text = selectedContract.value?.other3Amtfc ?? "";
  //   txtOtherVAT1Controller.text = selectedContract.value?.otheramtVatperc ?? "";
  //   txtOtherVAT2Controller.text =
  //       selectedContract.value?.otheramt2Vatperc ?? "";
  //   txtOtherVAT3Controller.text =
  //       selectedContract.value?.otheramt3Vatperc ?? "";
  //   txtCustomerIdController.text = selectedContract.value?.customerId ?? "";
  //   lbytesImage1.value =
  //       base64.decode(selectedContract.value?.imageEidFront ?? "");

  //   lbytesImage2.value =
  //       base64.decode(selectedContract.value?.imageEidBack ?? "");
  //   lstrSignature.value =
  //       base64.decode(selectedContract.value?.signature ?? "");
  //       calculateAndSetTotalAmount();
  // }

  _fillData() {
  logger.i("selectedContract.value?.reqDocNo: ${selectedContract.value?.contractDate}");
  logger.i("selectedContract.value?.reqDocNo: ${selectedContract.value?.connectionDate}");
  //====================connection req=========================

  txtReqNoController.text = selectedContract.value?.reqDocNo == null
      ? selectedContract.value?.contractNo ?? ""
      : selectedContract.value?.reqDocNo ?? "";
  txtcontractNoController.text = selectedContract.value?.reqDocNo == null
      ? ""
      : selectedContract.value?.contractNo ?? "";

  txtReqDocTypeController.text = selectedContract.value?.doctype ?? "";
  txtPriorityController.text = selectedContract.value?.contractPriority ?? "";
  txtBuildingCodeController.text = selectedContract.value?.buildingCode ?? "";
  txtAppartmentCodeController.text =
      selectedContract.value?.apartmentCode ?? "";
  txtBillingCustomerController.text =
      selectedContract.value?.billingCustomer ?? "";
  txtStockLocationController.text = selectedContract.value?.loc ?? "";
  txtMeterPressureController.text =
      selectedContract.value?.meterPressure ?? "";
  txtBranchController.text = selectedContract.value?.brncode ?? "";
  txtDivisionController.text = selectedContract.value?.divcode ?? "";
  txtCostCenterController.text = selectedContract.value?.cccode ?? "";
  txtSalesManController.text = selectedContract.value?.sman ?? "";
  otherAmountReq.value =
      selectedContract.value?.otherRequiredYn == "Y" ? true : false;

  contractDate.value =
      selectedContract.value?.contractDate ?? DateTime.now().toString();
  connectionDate.value =
      selectedContract.value?.connectionDate ?? DateTime.now().toString();

  //===================other=====================================

  txtCityController.text = selectedContract.value?.city ?? "";
  txtCountryController.text = selectedContract.value?.country ?? "";
  txtNameController.text = selectedContract.value?.partyname ?? "";
  txtArabicNameController.text =
      selectedContract.value?.arabicPartyname ?? "";
  txtEmailController.text = selectedContract.value?.email ?? "";
  txtAddressController.text = selectedContract.value?.address1 ?? "";
  txtArabicAddressController.text =
      selectedContract.value?.arabicAddress1 ?? "";
  txtMobileNoController.text = selectedContract.value?.mobile ?? "";
  txtTel1Controller.text = selectedContract.value?.tel1 ?? "";
  txtTel2Controller.text = selectedContract.value?.tel2 ?? "";
  txtPOBoxnoController.text = selectedContract.value?.pobox ?? "";
  txtTINNoController.text = selectedContract.value?.tinno ?? "";
  txtACGP1Controller.text = selectedContract.value?.acgp1 ?? "";
  txtACGP2Controller.text = selectedContract.value?.acgp2 ?? "";
  txtACGP3Controller.text = selectedContract.value?.acgp3 ?? "";
  txtACGP4Controller.text = selectedContract.value?.acgp4 ?? "";
  txtACGP5Controller.text = selectedContract.value?.acgp5 ?? "";
  txtACGP6Controller.text = selectedContract.value?.acgp6 ?? "";

  //=====================main=================================
  txtStatusController.text = selectedContract.value?.status ?? "";
  txtGasMeterNoController.text = selectedContract.value?.gasMeterNo ?? "";
  txtReadingConvController.text = _formatDecimal(selectedContract.value?.readingConversion);
  txtConsumptionConvController.text = _formatDecimal(selectedContract.value?.consumptionConversion);
  
  // Format amounts to 2 decimals
  txtTotalAmountController.text = _formatDecimal(selectedContract.value?.amtfc);
  totalAmountString.value = _formatDecimal(selectedContract.value?.amtfc);
  if (totalAmountString.value.isEmpty) totalAmountString.value = "00.00";

  txtUnitPriceController.text = _formatDecimal(selectedContract.value?.unitPrice);
  txtStartReadingController.text = _formatDecimal(selectedContract.value?.startReading);
  txtLastReadingController.text = _formatDecimal(selectedContract.value?.lastReading);
  txtRemarksController.text = selectedContract.value?.remarks ?? "";

  //==================amount detailed===========================
  txtInsuranceController.text = _formatDecimal(selectedContract.value?.insAmtfc);
  txtInsuranceVATController.text = _formatDecimal(selectedContract.value?.insuranceVatperc);
  txtMonthlyController.text = _formatDecimal(selectedContract.value?.monthlyFee);
  txtMonthlyVATController.text = _formatDecimal(selectedContract.value?.monthlyVatperc);
  txtBoilerGasController.text = _formatDecimal(selectedContract.value?.boilerGasConsumptionAmtfc);
  txtBoilerGasVATController.text = _formatDecimal(selectedContract.value?.boilerGasConsumptionTaxPerc);
  txtDepositController.text = _formatDecimal(selectedContract.value?.depositAmtfc);
  txtDepositVATController.text = _formatDecimal(selectedContract.value?.depositVatperc);
  txtConnectionController.text = _formatDecimal(selectedContract.value?.connectionAmtfc);
  txtConnectionVATController.text = _formatDecimal(selectedContract.value?.connectionVatperc);
  txtMaintananceController.text = _formatDecimal(selectedContract.value?.maintenanceAmtfc);
  txtMaintananceVATController.text = _formatDecimal(selectedContract.value?.maintenanceVatperc);
  txtDisconnectionController.text = _formatDecimal(selectedContract.value?.disconnectionAmtfc);
  txtDisconnectionVATController.text = _formatDecimal(selectedContract.value?.disconnectionVatperc);
  txtClearanceController.text = _formatDecimal(selectedContract.value?.clearanceAmtfc);
  txtClearanceVATController.text = _formatDecimal(selectedContract.value?.clearanceVatperc);
  txtRegistrationController.text = _formatDecimal(selectedContract.value?.registrationAmtfc);
  txtRegistrationVATController.text = _formatDecimal(selectedContract.value?.registrationVatperc);
  txtAdministrationController.text = _formatDecimal(selectedContract.value?.administrationAmtfc);
  txtAdministrationVATController.text = _formatDecimal(selectedContract.value?.administrationTaxPerc);
  txtBillMeterReadingController.text = _formatDecimal(selectedContract.value?.billMeterReadingAmtfc);
  txtBillMeterReadingVATController.text = _formatDecimal(selectedContract.value?.billMeterReadingTaxPerc);
  txtFacilityController.text = _formatDecimal(selectedContract.value?.facilityManageAmtfc);
  txtFacilityVATController.text = _formatDecimal(selectedContract.value?.facilityManageTaxPerc);
  txtDelayController.text = _formatDecimal(selectedContract.value?.delayPaymentAmtfc);
  txtDelayVATController.text = _formatDecimal(selectedContract.value?.delayPaymentTaxPerc);
  txtSecurityController.text = _formatDecimal(selectedContract.value?.securityDepReturnAmtfc);
  txtSecurityVATController.text = _formatDecimal(selectedContract.value?.securityDepReturnTaxPerc);
  
  txtOther1Controller.text = _formatDecimal(selectedContract.value?.other1Amtfc);
  txtOther2Controller.text = _formatDecimal(selectedContract.value?.other2Amtfc);
  txtOther3Controller.text = _formatDecimal(selectedContract.value?.other3Amtfc);
  txtOtherVAT1Controller.text = _formatDecimal(selectedContract.value?.otheramtVatperc);
  txtOtherVAT2Controller.text = _formatDecimal(selectedContract.value?.otheramt2Vatperc);
  txtOtherVAT3Controller.text = _formatDecimal(selectedContract.value?.otheramt3Vatperc);
  
  txtCustomerIdController.text = selectedContract.value?.customerId ?? "";
  
  lbytesImage1.value = base64.decode(selectedContract.value?.imageEidFront ?? "");
  lbytesImage2.value = base64.decode(selectedContract.value?.imageEidBack ?? "");
  lstrSignature.value = base64.decode(selectedContract.value?.signature ?? "");
  
  calculateAndSetTotalAmount();
}

  fnclear() {
    // AssignUserController assignUserController = Get.put(AssignUserController());
    // assignUserController.selectedAssignedUser = AssignUserModel();
    selectedContract.value = ContractModel();
    txtReqNoController.clear();
    txtReqDocTypeController.clear();
    signatureController.clear();
  }

  fnSignToBase64() async {
    lstrByteSignature = '';
    final Uint8List? data = await signatureController.toPngBytes();
    if (data != null && data.isNotEmpty) {
      lstrByteSignature = base64.encode(data as List<int>);
    }
  }

  fnSaveContract() async {
    await fnSignToBase64();
    if (lstrByteSignature.isEmpty) {
      errorMsg(msg: "Signature cant be empty");
      return 0;
    }

    showLoadingDialog();
    List<Map<String, dynamic>> tblGgasContract = [
      {
        "COMPANY": Global.selectedCompanyCode,
        "YEARCODE": Global.selectedCompanyYear,
        "CONTRACT_NO": "",
        "DOCTYPE": Global.selectedDocType,
        // "CONNECTION_DATE": Helper.convertDateTime(
        //     dateTime: Helper.convertDateFormat4(
        //         dateTime: connectionDate.value ?? "")),
        "CONNECTION_DATE": Helper.convertDateTime(
          dateTime: connectionDate.value ?? "",
        ),

        "DISCONNECTION_DATE": "",
        "PARTYCODE": "",
        "PARTYNAME": txtNameController.text,
        "PARTYNAME_ARABIC": txtArabicNameController.text,
        "BUILDING_CODE": txtBuildingCodeController.text,
        "APARTMENT_CODE": txtAppartmentCodeController.text,
        "STATUS": txtStatusController.text,
        "CONTRACT_PRIORITY": txtPriorityController.text,
        "UNIT_PRICE": Helper.mfnDbl(txtUnitPriceController.text),
        "START_READING": Helper.mfnDbl(txtStartReadingController.text),
        "LAST_READING": Helper.mfnDbl(txtLastReadingController.text),
        "LAST_READING_DATE":
            Helper.convertDateTime(dateTime: lastReadingDate.value),
        // "CONTRACT_DATE":
        //     Helper.convertDateTime(dateTime:Helper.convertDateFormat4(
        //         dateTime:contractDate.value ?? "") ),
        "CONTRACT_DATE": Helper.convertDateTime(
          dateTime: contractDate.value ?? "",
        ),
        "SMAN": txtSalesManController.text,
        "CURR": "AED",
        "CURRATE": "1",
        "INS_AMTFC": Helper.mfnDbl(txtInsuranceController.text),
        "DEPOSIT_AMTFC": Helper.mfnDbl(txtDepositController.text),
        "CONNECTION_AMTFC": Helper.mfnDbl(txtConnectionController.text),
        "MONTHLY_FEEFC": Helper.mfnDbl(txtMonthlyController.text),
        "MAINTENANCE_AMTFC": Helper.mfnDbl(txtMaintananceController.text),
        "AMTFC": Helper.mfnDbl(txtTotalAmountController.text),
        "INS_AMT": Helper.mfnDbl(txtInsuranceController.text),
        "DEP_AMT": Helper.mfnDbl(txtDepositController.text),
        "CONNECTION_AMT": Helper.mfnDbl(txtConnectionController.text),
        "MONTHLY_FEE": Helper.mfnDbl(txtMonthlyController.text),
        "MAINTENANCE_AMT": Helper.mfnDbl(txtMaintananceController.text),
        "AMT": Helper.mfnDbl(txtTotalAmountController.text),
        "REMARKS": txtRemarksController.text,
        "CONDITION1": "",
        "CONDITION2": "",
        "CONDITION3": "",
        "CONDITION4": "",
        "CONDITION5": "",
        "CONDITION6": "",
        "TERMS_CODE": "",
        "TERMS_DESCP": "",
        "LAST_INVDOCNO": "",
        "LAST_INVDOCTYPE": "",
        "LAST_YEARCODE": "",
        "LAST_INVDATE": "",
        "PRV_CONTRACT_NO": "",
        "PRV_CUSTOMER": "",
        "PRV_CONNECTION_DATE": "",
        "PRV_DISCONNECTION_DATE": "",
        "PRV_CONTRACT_DATE": "",
        "PRV_STATUS": "",
        "FINAL_INVOICE_YN": "",
        "CITY": txtCityController.text,
        "COUNTRY": txtCountryController.text,
        "ADDRESS1": txtAddressController.text,
        "ADDRESS2": "",
        "ADDRESS3": "",
        "ARABIC_PARTYNAME": "",
        "ARABIC_ADDRESS1": "",
        "ARABIC_ADDRESS2": "",
        "ARABIC_ADDRESS3": "",
        "POBOX": "",
        "TEL1": txtTel1Controller.text,
        "TEL2": txtTel2Controller.text,
        "MOBILE": txtMobileNoController.text,
        "FAX": "",
        "EMAIL": txtEmailController.text,
        "OTHER_REQUIRED_YN": otherAmountReq.value == true ? "Y" : "N",
        "OTHER_AMT_CALC_TYPE": otherAmountCalcType.value,
        "OTHER_AMT_CALC_AMT":
            Helper.mfnDbl(txtOtherRequiredAmountController.text),
        "LAST_READING_MONTH":
            double.parse(txtLastReadingController.text).toInt(),
        // int.parse(double. parse(
        //   txtLastReadingController.text,
        // ).round().toString()),
        "LAST_READING_YEAR": "",
        "READING_CONVERSION": Helper.mfnDbl(txtReadingConvController.text),
        "BILLING_CUSTOMER": txtBillingCustomerController.text,
        "METER_PRESSURE": Helper.mfnDbl(txtMeterPressureController.text),
        "GAS_METER_NO": txtGasMeterNoController.text,
        "CREATE_USER": Global.userCD,
        "CREATE_DATE":
            Helper.convertDateTime(dateTime: DateTime.now().toString()),
        "EDIT_USER": "",
        "EDIT_DATE": "",
        "GAS_CUSTOMER_CTRL_AC": "",
        "CONSUMPTION_CONVERSION":
            Helper.mfnDbl(txtConsumptionConvController.text),
        "LOC": txtStockLocationController.text,
        "EDIT_AFTER_UPDATE_YN": "Y",
        "EMIRATES_ID": "",
        "PDA_GRD_DOCNO": "",
        "PDA_GRD_DOCTYPE": "",
        "PDA_GRD_YEARCODE": "",
        "PDA_GRD_SRNO": "1",
        "PDA_GRD_LAST_READING": Helper.mfnDbl("0"),
        "PDA_GRD_LAST_READING_DATE": "",
        "PDA_GINV_DOCNO": "",
        "PDA_GINV_DOCTYPE": "",
        "PDA_GINV_YEARCODE": "",
        "PDA_GINV_SRNO": int.parse("0"),
        "PDA_GINV_LAST_INVDATE": "",
        "PDA_GREC_DOCNO": "",
        "PDA_GREC_DOCTYPE": "",
        "PDA_GREC_YEARCODE": "",
        "PDA_GREC_SRNO": int.parse("1"),
        "BRNCODE": txtBranchController.text,
        "DIVCODE": txtDivisionController.text,
        "CCCODE": txtCostCenterController.text,
        "DISCONNECTION_AMTFC": Helper.mfnDbl(txtDisconnectionController.text),
        "DISCONNECTION_AMT": Helper.mfnDbl(txtDisconnectionController.text),
        "REGISTRATION_AMTFC": Helper.mfnDbl(txtRegistrationController.text),
        "REGISTRATION_AMT": Helper.mfnDbl(txtRegistrationController.text),
        "CLEARANCE_AMTFC": Helper.mfnDbl(txtClearanceController.text),
        "CLEARANCE_AMT": Helper.mfnDbl(txtClearanceController.text),
        "OTHER1_AMTFC": Helper.mfnDbl(txtOther1Controller.text),
        "OTHER2_AMTFC": Helper.mfnDbl(txtOther2Controller.text),
        "OTHER3_AMTFC": Helper.mfnDbl(txtOther3Controller.text),
        "OTHER1_AMT": Helper.mfnDbl(txtOther1Controller.text),
        "OTHER2_AMT": Helper.mfnDbl(txtOther2Controller.text),
        "OTHER3_AMT": Helper.mfnDbl(txtOther3Controller.text),
        "INSURANCE_VATPERC": Helper.mfnDbl(txtInsuranceVATController.text),
        "DEPOSIT_VATPERC": Helper.mfnDbl(txtDepositVATController.text),
        "CONNECTION_VATPERC": Helper.mfnDbl(txtConnectionVATController.text),
        "MAINTENANCE_VATPERC": Helper.mfnDbl(txtMaintananceVATController.text),
        "DISCONNECTION_VATPERC":
            Helper.mfnDbl(txtDisconnectionVATController.text),
        "REGISTRATION_VATPERC":
            Helper.mfnDbl(txtRegistrationVATController.text),
        "CLEARANCE_VATPERC": Helper.mfnDbl(txtClearanceVATController.text),
        "OTHERAMT_VATPERC": Helper.mfnDbl(txtOtherVAT1Controller.text),
        "OTHERAMT2_VATPERC": Helper.mfnDbl(txtOtherVAT2Controller.text),
        "OTHERAMT3_VATPERC": Helper.mfnDbl(txtOtherVAT3Controller.text),
        "MONTHLY_VATPERC": Helper.mfnDbl(txtMonthlyVATController.text),
        "TINNO": txtTINNoController.text,
        "APP_SYNCH_STATUS": "",
        "NON_INV_YS": "",
        "OPERATING_PRESSURE": Helper.mfnDbl("0"),
        "CCB_ACCOUNT_ID": "",
        "BULK_SMS_SEND_YN": "",
        "BULK_EMAIL_SEND_YN": "",
        "REQUEST_NO": txtcontractNoController.text,
        "REQUEST_DOCTYPE": txtReqDocTypeController.text,
        "LAST_INVSRNO": int.parse("1"),
        "ONLINE_SYNCH_STATUS": "",
        "ONLINE_LAST_PAYMENT_DT": "",
        "ONLINE_LAST_PAYMENT_AMT": Helper.mfnDbl("0"),
        "ONLINE_LAST_PAYMENT_DOCNO": "",
        "ONLINE_LAST_PAYMENT_DOCTYPE": "",
        "ONLINE_LAST_PAYMENT_YEARCODE": "",
        "ONLINE_BALANCEAMT_": Helper.mfnDbl("0"),
        "TRADELICENSE": "",
        "OTHERID": "",
        "BILL_METER_READING_AMTFC": Helper.mfnDbl(
            txtBillMeterReadingController.text.isNotEmpty
                ? txtBillMeterReadingController.text
                : "0"),
        "ADMINISTRATION_AMTFC": Helper.mfnDbl(
            txtAdministrationController.text.isNotEmpty
                ? txtAdministrationController.text
                : "0"),
        "FACILITY_MANAGE_AMTFC": Helper.mfnDbl(
            txtFacilityController.text.isNotEmpty
                ? txtFacilityController.text
                : "0"),
        "BOILER_GAS_CONSUMPTION_AMTFC": Helper.mfnDbl(
            txtBoilerGasController.text.isNotEmpty
                ? txtBoilerGasController.text
                : "0"),
        "DELAY_PAYMENT_AMTFC": Helper.mfnDbl(
            txtDelayController.text.isNotEmpty ? txtDelayController.text : "0"),
        "SECURITY_DEP_RETURN_AMTFC": Helper.mfnDbl(
            txtSecurityController.text.isNotEmpty
                ? txtSecurityController.text
                : "0"),
        "BILL_METER_READING_AMT": Helper.mfnDbl("0"),
        "ADMINISTRATION_AMT": Helper.mfnDbl("0"),
        "FACILITY_MANAGE_AMT": Helper.mfnDbl("0"),
        "BOILER_GAS_CONSUMPTION_AMT": Helper.mfnDbl("0"),
        "DELAY_PAYMENT_AMT": Helper.mfnDbl("0"),
        "SECURITY_DEP_RETURN_AMT": Helper.mfnDbl("0"),
        "BILL_METER_READING_TAX_PERC": Helper.mfnDbl(
            txtBillMeterReadingVATController.text.isNotEmpty
                ? txtBillMeterReadingVATController.text
                : "0"),
        "ADMINISTRATION_TAX_PERC": Helper.mfnDbl(
            txtAdministrationVATController.text.isNotEmpty
                ? txtAdministrationVATController.text
                : "0"),
        "FACILITY_MANAGE_TAX_PERC": Helper.mfnDbl(
            txtFacilityVATController.text.isNotEmpty
                ? txtFacilityVATController.text
                : "0"),
        "BOILER_GAS_CONSUMPTION_TAX_PERC": Helper.mfnDbl(
            txtBoilerGasVATController.text.isNotEmpty
                ? txtBoilerGasVATController.text
                : "0"),
        "DELAY_PAYMENT_TAX_PERC": Helper.mfnDbl(
            txtDelayVATController.text.isNotEmpty
                ? txtDelayVATController.text
                : "0"),
        "SECURITY_DEP_RETURN_TAX_PERC": Helper.mfnDbl(
            txtSecurityVATController.text.isNotEmpty
                ? txtSecurityVATController.text
                : "0"),
        "ONLINE_DEP_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_BOOKED_DEPOSIT_AMT": Helper.mfnDbl("0"),
        "ONLINE_PRV_BALANCE": Helper.mfnDbl("0"),
        "ONLINE_OUTSTANDING_AMT": Helper.mfnDbl("0"),
        "ONLINE_TOTAL_OUTSTANDING": Helper.mfnDbl("0"),
        "ONLINE_LAST_RECAMT": Helper.mfnDbl("0"),
        "ONLINE_TOTAL_DEDUCTION_AMT": Helper.mfnDbl("0"),
        "ONLINE_TOTAL_DEDUCTION_TAXAMT": Helper.mfnDbl("0"),
        "ONLINE_INVOICE_AMT": Helper.mfnDbl("0"),
        "ONLINE_INVOICE_TAX_AMT": Helper.mfnDbl("0"),
        "ONLINE_INV_MAINTENANCE_AMT": Helper.mfnDbl("0"),
        "ONLINE_INV_MAINTENANCE_AMT_TAX": Helper.mfnDbl("0"),
        "ONLINE_AMT_PAID": Helper.mfnDbl("0"),
        "ONLINE_RECEIVED_AMT": Helper.mfnDbl("0"),
        "ONLINE_LAST_RECDATE": "",
        "ONLINE_INS_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_C_DEP_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_CONNECTION_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_MAINTENANCE_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_DISCONNECTION_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_REGISTRATION_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_OTHER1_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_OTHER2_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_OTHER3_AMT_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_INS_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_DEP_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_CONNECTION_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_MAINTENANCE_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_DISCONNECTION_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_REGISTRATION_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_OTHER1_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_OTHER2_TAX_RECEIVED": Helper.mfnDbl("0"),
        "ONLINE_OTHER3_TAX_RECEIVED": Helper.mfnDbl("0"),
        "POST_YN": "",
        "REF1": "",
        "REF2": "",
        "REF3": "",
        "REF4": "",
        "REF5": "",
        "REF6": "",
        "APT_TYPE": "",
        "APT_CATEGORY": "",
        "APT_FLOORTYPE": "",
        "APT_LOCATION": "",
        "APT_GP1": "",
        "APT_GP2": "",
        "APT_GP3": "",
        "APT_GP4": "",
        "APT_GP5": "",
        "REFUND_AMT": Helper.mfnDbl("0"),
        "SYNCH_STATUS": "1",
        "OUTSTANDING_AMT": Helper.mfnDbl("0"),
        "LAST_RECDOCNO": "",
        "LAST_RECDOCTYPE": "",
        "LAST_RECYEARCODE": "",
        "LAST_RECSRNO": int.parse("0"),
        "LAST_RECDATE": "",
        "METER_NO": "",
        "PRV_BALANCE": Helper.mfnDbl("0"),
        "MOBILENO_IMEI_EDITER": "",
        "MOBILENO_EDITER_LATITUDE": "",
        "MOBILENO_EDITER_LONGTITUDE": "",
        "MOBILENO_EDITED_DATE": "",
        "MOBILENO_EDITER_USERID": "",
        "NON_INV_YN": "",
        "STATE": "",
        "LAST_REC_DOCNO": "",
        "LAST_REC_DOCTYPE": "",
        "LAST_REC_YEARCODE": "",
        "LAST_REC_SRNO": int.parse("1"),
        "LAST_REC_DATE": "",
        "EMIRATE": "",
        "TAX_RETURN_SUBMITTED_YN": "",
        "TAXRET_DOCNO": "",
        "TAXRET_DOCTYPE": "",
        "TAXRET_YEARCODE": "",
        "TAXRET_SRNO": int.parse("1"),
        "UNPOST_YN": "",
        "WEBONLINE_SYNCH_STATUS": "",
        "CRDAYS": int.parse("0"),
        "CONTRACT_NO_BASE64": "",
        "NATIONALITY": "",
        "FIXED_TYPE": "",
        "FIXED_AMT": Helper.mfnDbl("0"),
        "FIXED_INV_YN": "",
        "FUEL_SURCHARGE_AMTFC": Helper.mfnDbl("0"),
        "FUEL_SURCHARGE_AMT": Helper.mfnDbl("0"),
        "FUEL_SURCHARGE_TAX_PERC": Helper.mfnDbl("0"),
        "GP1": txtACGP1Controller.text,
        "GP2": txtACGP2Controller.text,
        "GP3": txtACGP3Controller.text,
        "GP4": txtACGP4Controller.text,
        "GP5": txtACGP5Controller.text,
        "GP6": txtACGP6Controller.text,
        "GP7": "",
        "GP8": "",
        "GP9": "",
        "GP10": "",
        "REQ_DOCNO": txtReqNoController.text,
        "REQ_DOCTYPE": txtReqDocTypeController.text,
        "REQ_YEARCODE": selectedContract.value?.yearcode,
        "IMG_EID_FRONT": base64.encode(lbytesImage1.value),
        "IMG_EID_BACK": base64.encode(lbytesImage2.value),
        "IMG_SIGNATURE": lstrByteSignature,
        "CUSTOMER_ID": txtCustomerIdController.text
      }
    ];

    List<Map<String, dynamic>> tblSlcontactDet = [
      {
        "COMPANY": Global.selectedCompanyCode,
        "SLCODE": "",
        "SRNO": "1",
        "CONTACT_PERSON": "",
        "CONTACT_DETAILS": "",
        "CONTACT_TELNO1": "",
        "CONTACT_TELNO2": "",
        "CONTACT_FAXNO": "",
        "MOBILENO": "",
        "EMAIL": "",
        "REMARKS": "",
        "DESIGNATION": "",
        "CONTACT_TEL1": "",
        "EXTENTION": "",
        "MOBILE": "",
        "CONTACT_FAX": "",
        "NATIONALITY_CODE": "",
        "DESGN_CODE": "",
        "PASSPORT": "",
        "PASSPORT_EXPIRY_DATE": ""
      }
    ];

    Map<String, dynamic> payLoad = {
      "TBL_GGASCONTRACT": tblGgasContract,
      "TBL_SLCONTACTDET": tblSlcontactDet,
      "TBL_GGASCONTRACT_CUSTOMER": [],
      "TBL_GGASCONTRACT_TELDETAILS": txtMobileNoController.text.isEmpty
          ? []
          : [
              {
                "COMPANY": "01",
                "CONTRACT_NO": "",
                "DOCTYPE": "GCT",
                "SRNO": "1",
                "AREACODE": "1",
                "NUMBER": "1",
                "SMS_YN": "N"
              }
            ],
      "MODE": "ADD"
    };
    Helper.fngetTocken().then((token) {
      if (token != null) {
        contractRepository
            .saveContractDetails(token: token, payload: payLoad)
            .then((response) {
          logger.e(response);
          if (Get.isDialogOpen == true) {
            Get.back();
          }

          if (response[0]["STATUS"] == "1") {
            _fnSaveSuccess();
          } else {
            errorMsg(msg: response[0]["MSG"]);
          }
        });
      }
      //   contractRepository
      //       .getContractDetails(token: token)
      //       .then((selectedContract) {
      //     _fnGetAssignUserListSuccess(
      //         contract: selectedContract ?? ContractModel());
      //   });
      // }
    });
  }

  fnDelete({docNo}) {
    Get.back();
    Helper.fngetTocken().then((token) {
      showLoadingDialog();
      if (token != null) {
        contractRepository
            .deleteContractDetails(docNo: docNo.text.toString(), token: token)
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

  _fnSaveSuccess() {
    fngetLastContractDetails(mode: "LAST", docNo: "");
    successPopup();
    isEditModeEnabled.value = false;
  }
}
