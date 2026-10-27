import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/controller/contract_controller.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/image_picker.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/common_widgets/signature_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../lookup/view/look_up_dialogue_exe.dart';
import '../functions/contract_functions.dart';

class ContractMainPageExe extends StatelessWidget {
  ContractMainPageExe({
    super.key,
  });

  ContractController contractController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: Get.width * .07,
          bottom: Get.height * .02,
          top: Get.height * .04),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 30,
              spacing: 15,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Status",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                        width: Get.width * .25 < 200 ? 200 : Get.width * .25,
                        child: CustomSearchField(
                          hintLabel: "Status",
                          marginM: EdgeInsets.zero,
                          enablests: contractController.isEditModeEnabled.value,
                          onSearchTap: () {
                            if (contractController.isEditModeEnabled.value) {
                              List searchColumn = [
                                {
                                  "showItem": true,
                                  "columnName": "CODE",
                                  "showName": "Code"
                                },
                                {
                                  "showItem": true,
                                  "columnName": "DESCP",
                                  "showName": "Description"
                                },
                              ];
                              Get.dialog(
                                barrierDismissible: false,
                                lookUpDialogueExe(
                                  tableName: "GCONNECTION_STATUS",
                                  callBackFn: (value) {
                                    contractController.txtStatusController
                                        .text = value["CODE"].toString();
                                    Get.back();
                                  },
                                  filter: [],
                                  searchColumn: searchColumn,
                                ),
                              );
                            }
                          },
                          controller: contractController.txtStatusController,
                          fieldColor: ThemeColors.primaryBlueColor,
                          hintSize: 12,
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Gas Meter No.",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                        width: Get.width * .30 < 200 ? 200 : Get.width * .30,
                        child: PrimaryInputField(
                          hintText: "Gas Meter No.",
                          // marginM: EdgeInsets.zero,
                          enablests: contractController.isEditModeEnabled.value,

                          // fieldColor: ThemeColors.primaryBlueColor,
                          txtController:
                              contractController.txtGasMeterNoController,
                        )),
                  ],
                ),
              ],
            ),
            gapHC(30),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 30,
              spacing: 15,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Reading Conversion",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .25 < 200 ? 200 : Get.width * .25,
                      child: PrimaryInputField(
                        hintText: "Reading Conversion",
                        enablests: contractController.isEditModeEnabled.value,
                        txtController:
                            contractController.txtReadingConvController,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Consumption conversion",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .30 < 200 ? 200 : Get.width * .30,
                      child: PrimaryInputField(
                        txtController:
                            contractController.txtConsumptionConvController,
                        enablests: contractController.isEditModeEnabled.value,
                        hintText: "Consumption conversion",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            gapHC(30),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 30,
              spacing: 15,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Total Amount",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .25 < 200 ? 200 : Get.width * .25,
                      child: PrimaryInputField(
                        hintText: "Total Amount",
                        enablests: contractController.isEditModeEnabled.value,
                        txtController:
                            contractController.txtTotalAmountController,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Unit Price ( AED )",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .30 < 200 ? 200 : Get.width * .30,
                      child: PrimaryInputField(
                        hintText: "Unit Price ( AED )",
                        enablests: contractController.isEditModeEnabled.value,
                        txtController:
                            contractController.txtUnitPriceController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            gapHC(30),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 30,
              spacing: 15,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "Start Reading",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .25 < 200 ? 200 : Get.width * .25,
                      child: PrimaryInputField(
                        hintText: "Start Reading",
                        enablests: contractController.isEditModeEnabled.value,
                        txtController:
                            contractController.txtStartReadingController,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                      child: Text(
                        "End Reading",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.primaryBlueColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .30 < 200 ? 200 : Get.width * .30,
                      child: PrimaryInputField(
                        hintText: "End Reading",
                        formatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                          RangeInputFormatterForMonth(),
                        ],
                        enablests: contractController.isEditModeEnabled.value,
                        txtController:
                            contractController.txtLastReadingController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            gapHC(30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last Reading Date",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text("01-10-2024",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: ThemeColors.primaryBlueColor,
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: ThemeColors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            gapHC(30),
            SizedBox(
              width: Get.width * .30 < 200 ? 200 : 55 + Get.width * .53,
              child: PrimaryInputField(
                hintText: "Remarks",
                enablests: contractController.isEditModeEnabled.value,
                txtController: contractController.txtRemarksController,
                isTextArea: true,
              ),
            ),
            gapHC(30),
            Obx(
              () => Wrap(
                spacing: 40,
                runSpacing: 30,
                children: [
                  SizedBox(
                      width: Get.width * .2 < 200 ? 250 : Get.width * .2,
                      child: SignatureField(
                        isEnabled: contractController.isEditModeEnabled.value,
                        lstrSignature: contractController.lstrSignature,
                        signatureController:
                            contractController.signatureController,
                      )),
                  SizedBox(
                    width: Get.width * .1 < 200 ? 200 : Get.width * .1,
                    child: Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: () async {
                        if (contractController.isEditModeEnabled.value) {
                          Helper.fnImageToBase64().then(
                            (bytes) {
                              contractController.lbytesImage1.value = bytes??Uint8List(0);
                            },
                          );
                        }
                      },
                      child: CustomImagePicker(
                        label: "Front image",
                        image: contractController.lbytesImage1.value,
                        enable: contractController.isEditModeEnabled.value,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .1 < 200 ? 200 : Get.width * .1,
                    child: Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: () async {
                        if (contractController.isEditModeEnabled.value) {
                          Helper.fnImageToBase64().then(
                            (bytes) {
                              contractController.lbytesImage2.value = bytes??Uint8List(0);
                            },
                          );
                        }
                      },
                      child: CustomImagePicker(
                        label: "Back image",
                        image: contractController.lbytesImage2.value,
                        enable: contractController.isEditModeEnabled.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            gapHC(30),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ThemeColors.primaryBlueColor,
                      borderRadius: BorderRadius.circular(30)),
                  height: 60,
                ),
                _detailsExpansion(),
              ],
            ),
            gapHC(60),
          ],
        ),
      ),
    );
  }
}

class _detailsExpansion extends StatelessWidget {
  ContractController contractController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        enabled: true,
        initiallyExpanded: true,
        controller: ExpansionTileController(),
        title: Text("Amount Details",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        children: [
          gapHC(30),
          Row(
            children: [
              Expanded(flex: 9, child: Container()),
              Expanded(
                  flex: 4,
                  child: Center(
                    child: Text("Amount",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  )),
              Expanded(
                  flex: 4,
                  child: Center(
                    child: Text("VAT %",
                        style: GoogleFonts.poppins(
                            color: ThemeColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ))
            ],
          ),
          _amountDetailsItem(
            headValue: "Monthly Amount",
            amountValueController: contractController.txtMonthlyController,
            vatAmountController: contractController.txtMonthlyVATController,
          ),
          _amountDetailsItem(
            headValue: "Boiler gas Amount",
            amountValueController: contractController.txtBoilerGasController,
            vatAmountController: contractController.txtBoilerGasVATController,
          ),
          _amountDetailsItem(
            headValue: "Insurance Amount",
            amountValueController: contractController.txtInsuranceController,
            vatAmountController: contractController.txtInsuranceVATController,
          ),
          _amountDetailsItem(
            headValue: "Deposit Amount",
            amountValueController: contractController.txtDepositController,
            vatAmountController: contractController.txtDepositVATController,
          ),
          _amountDetailsItem(
            headValue: "Connection Amount",
            amountValueController: contractController.txtConnectionController,
            vatAmountController: contractController.txtConnectionVATController,
          ),
          _amountDetailsItem(
            headValue: "Maintenance Amount",
            amountValueController: contractController.txtMaintananceController,
            vatAmountController: contractController.txtMaintananceVATController,
          ),
          _amountDetailsItem(
            headValue: "Disconnection Amount",
            amountValueController:
                contractController.txtDisconnectionController,
            vatAmountController:
                contractController.txtDisconnectionVATController,
          ),
          _amountDetailsItem(
            headValue: "Clearance Amount",
            amountValueController: contractController.txtClearanceController,
            vatAmountController: contractController.txtClearanceVATController,
          ),
          _amountDetailsItem(
            headValue: "Registration Amount",
            amountValueController: contractController.txtRegistrationController,
            vatAmountController:
                contractController.txtRegistrationVATController,
          ),
          _amountDetailsItem(
            headValue: "Administration Amount",
            amountValueController:
                contractController.txtAdministrationController,
            vatAmountController:
                contractController.txtAdministrationVATController,
          ),
          _amountDetailsItem(
            headValue: "Bill meter Reading Amount",
            amountValueController:
                contractController.txtBillMeterReadingController,
            vatAmountController:
                contractController.txtBillMeterReadingVATController,
          ),
          _amountDetailsItem(
            headValue: "Facility Amount",
            amountValueController: contractController.txtFacilityController,
            vatAmountController: contractController.txtFacilityVATController,
          ),
          _amountDetailsItem(
            headValue: "Delay Payment Amount",
            amountValueController: contractController.txtDelayController,
            vatAmountController: contractController.txtDelayVATController,
          ),
          _amountDetailsItem(
            headValue: "Security Amount",
            amountValueController: contractController.txtSecurityController,
            vatAmountController: contractController.txtSecurityVATController,
          ),
          _amountDetailsItem(
            headValue: "Other Amount 1",
            amountValueController: contractController.txtOther1Controller,
            vatAmountController: contractController.txtOtherVAT1Controller,
          ),
          _amountDetailsItem(
            headValue: "Other Amount 2",
            amountValueController: contractController.txtOther2Controller,
            vatAmountController: contractController.txtOtherVAT2Controller,
          ),
          _amountDetailsItem(
            headValue: "Other Amount 3",
            amountValueController: contractController.txtOther3Controller,
            vatAmountController: contractController.txtOtherVAT3Controller,
          ),
        ],
      ),
    );
  }
}

class _amountDetailsItem extends StatelessWidget {
  _amountDetailsItem({
    super.key,
    required this.headValue,
    required this.amountValueController,
    required this.vatAmountController,
  });

  final String headValue;
  final TextEditingController amountValueController, vatAmountController;
  ContractController contractController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Text(headValue),
              )),
          Expanded(
              flex: 3,
              child: PrimaryInputField(
                hintText: "",
                txtRadius: 10,
                txtController: amountValueController,
                enablests: contractController.isEditModeEnabled.value,
              )),
          gapWC(2),
          Expanded(
              flex: 2,
              child: PrimaryInputField(
                hintText: "",
                txtRadius: 10,
                txtController: vatAmountController,
                enablests: contractController.isEditModeEnabled.value,
              ))
        ],
      ),
    );
  }
}
