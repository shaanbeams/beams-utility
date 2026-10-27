import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/controller/temp_disconnection_controller.dart';
import 'package:gas_utility_app/modules/finalSettlement/controller/final_settlement_controller.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/controller/gas_meter_receipt_controller.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/custom_date_picker.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalSettlementPage extends StatefulWidget {
  FinalSettlementPage({
    super.key,
  });

  @override
  State<FinalSettlementPage> createState() => _FinalSettlementPageState();
}

class _FinalSettlementPageState extends State<FinalSettlementPage> {
  FinalSettlementController finalSettlementController =
      FinalSettlementController();
  FocusNode focusNode = FocusNode();
  // finalSettlementController finalSettlementController =
  //     Get.put(finalSettlementController());
  // finalSettlementController finalSettlementController =
  //     Get.put(finalSettlementController());

  // String? selectedOption;

  @override
  void initState() {
    super.initState();

    // if (widget.isFromInvoicePage == false) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog();
    });
    finalSettlementController.fnGetLastFinalSettlement(docNo: "", mode: "LAST");
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    // }
    fnGetGasDocMaster(docType: Global.selectedDocType).then(
      (value) {
        logger.i(value);
        Global.ccCode = value[0]["CCCODE"];
        Global.divCode = value[0]["DIVCODE"];
        Global.brnCode = value[0]["BRNCODE"];
      },
    );
    finalSettlementController.txtCostCenterController.text = Global.ccCode;
    finalSettlementController.txtDivisionController.text = Global.divCode;
    finalSettlementController.txtBranchController.text = Global.brnCode;
  }

  @override
  void dispose() {
    finalSettlementController.isEditModeEnabled.value = false;
    // Get.delete<GasMeterReadingInvoiceController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: Obx(() => CustomBottomNavBar(
              fnonFirstButtonPressed: () {
                finalSettlementController.fnGetLastFinalSettlement(
                    mode: "FIRST", docNo: "");
              },
              fnonPreviousButtonPressed: () {
                finalSettlementController.fnGetLastFinalSettlement(
                    mode: "PREVIOUS",
                    docNo: finalSettlementController.txtDocNumController.text);
              },
              fnonLastButtonPressed: () {
                finalSettlementController.fnGetLastFinalSettlement(
                    mode: "LAST", docNo: "");
              },
              fnonNextButtonPressed: () {
                finalSettlementController.fnGetLastFinalSettlement(
                    mode: "NEXT",
                    docNo: finalSettlementController.txtDocNumController.text);
              },
              fnonSaveButtonPressed: () {
                finalSettlementController.fnSaveFinalSettlement();
              },
              fnonCancelPressed: () {
                finalSettlementController.isEditModeEnabled.value = false;
                finalSettlementController.fnClear();
                finalSettlementController.fnGetLastFinalSettlement(
                    docNo: "", mode: "LAST");
              },
              fnonAddButtonPressed: () {
                finalSettlementController.fnClear();
                finalSettlementController.isEditModeEnabled.value =
                    !finalSettlementController.isEditModeEnabled.value;
                fnGetGasDocMaster(docType: Global.selectedDocType).then(
                  (value) {
                    finalSettlementController.txtCostCenterController.text =
                        value[0]["CCCODE"];
                    finalSettlementController.txtDivisionController.text =
                        value[0]["DIVCODE"];
                    finalSettlementController.txtBranchController.text =
                        value[0]["BRNCODE"];
                  },
                );
              },
              isEditIconEnabled:
                  finalSettlementController.isEditModeEnabled.value,
              isAddButtonRequired: true,
            )),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: Get.size.height / 3.5,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  gradient: ThemeGradient.gradient,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 10),
                    child: Row(
                      children: [
                        Bounce(
                          onPressed: () {
                            Get.back();
                          },
                          duration: const Duration(milliseconds: 100),
                          child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: ThemeColors.white,
                              )),
                        ),
                        Image.asset(
                          "assets/icons/settlement.png",
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Final  \n Settlement",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: ThemeColors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3, //
                            child: CustomSearchField(
                              labelColor: Colors.white,
                              label: "Request Doc No",
                              labelYn: true,
                              hintLabel: "Request Doc No",
                              controller:
                                  finalSettlementController.txtDocNumController,
                              onSearchTap: () {
                                List searchColumn = [
                                  {
                                    "showItem": true,
                                    "columnName": "DOCNO",
                                    "showName": "Document No"
                                  },
                                  {
                                    "showItem": true,
                                    "columnName": "DOCTYPE",
                                    "showName": "DocType"
                                  },
                                ];
                                Get.dialog(lookUpDialogue(
                                  callBackFn: (value) {
                                    finalSettlementController
                                        .txtDocNumController
                                        .text = value["DOCNO"];
                                    finalSettlementController
                                        .fnGetLastFinalSettlement(
                                            mode: "VIEW",
                                            docNo: value["DOCNO"]);
                                    Get.back();
                                  },
                                  tableName: "GPAY",
                                  filter: [],
                                  searchColumn: searchColumn,
                                ));
                              },
                            )),
                        gapWC(10),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              _tHead(
                                title: "Date : ",
                              ),
                              _tValue(
                                  value: Helper.convertDateFormat2(
                                      dateTime: DateTime.now().toString())),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "Tenant Details ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.info_outline),
                            // Spacer(),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 10),
                            //   child: CircleAvatar(
                            //     backgroundColor: ThemeColors.primaryBlueColor,
                            //     child: Image.asset(
                            //       "assets/icons/sent.png",
                            //       color: ThemeColors.white,
                            //       height: 25,
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 10),
                            //   child: CircleAvatar(
                            //     backgroundColor: ThemeColors.primaryBlueColor,
                            //     child: Image.asset(
                            //       "assets/icons/Printer.png",
                            //       color: ThemeColors.white,
                            //       height: 30,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests:
                            finalSettlementController.isEditModeEnabled.value,
                        labelYn: true,
                        label: "Contract No",
                        hintLabel: "Contract No",
                        
                        hintSize: 11,
                        onSearchTap: () {
                          if (finalSettlementController
                              .isEditModeEnabled.value) {
                            List searchColumn = [
                              {
                                "showItem": true,
                                "columnName": "CONTRACT_NO",
                                "showName": "Contract No"
                              },
                              {
                                "showItem": true,
                                "columnName": "BUILDING_CODE",
                                "showName": "Buildng code"
                              },
                              {
                                "showItem": true,
                                "columnName": "APARTMENT_CODE",
                                "showName": "Appartment code"
                              },
                              {
                                "showItem": true,
                                "columnName": "PARTYNAME",
                                "showName": "Party Name"
                              },
                              {
                                "showItem": false,
                                "columnName": "LAST_READING_DATE",
                                "showName": "Last Reading Date"
                              },
                            ];
                            Get.dialog(
                              barrierDismissible: false,
                              lookUpDialogue(
                                tableName:
                                    "(SELECT * FROM GGASCONTRACT WHERE (status = 'C' OR status = 'V')AND CONTRACT_NO NOT IN (SELECT CONTRACT_NO FROM GPAY) )as table1",
                                // tableName: "GGASCONTRACT",
                                callBackFn: (value) {
                                  Get.back();
                                  finalSettlementController
                                      .fnValidateContractDisconnection(
                                          contractNo: value["CONTRACT_NO"]);
                                  Get.back();
                                },
                                filter: [
                                  {
                                    'Column': "STATUS",
                                    'Operator': '=',
                                    'Value': 'C',
                                    'JoinType': 'OR'
                                  },
                                  {
                                    'Column': "STATUS",
                                    'Operator': '=',
                                    'Value': 'V',
                                    'JoinType': 'OR'
                                  },
                                ],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                        controller:
                            finalSettlementController.txtContractNoController,
                      ),
                      gapHC(10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: PrimaryInputField(
                                enablests: false,
                                labelYn: true,
                                hintText: "Building code",
                                txtController: finalSettlementController
                                    .txtBuildingCodeController,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: PrimaryInputField(
                                enablests: false,
                                labelYn: true,
                                hintText: "Appartment code",
                                txtController: finalSettlementController
                                    .txtApartmentCodeController,
                              ),
                            ),
                          )
                        ],
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,
                          labelYn: true,
                          hintText: "Building Name",
                          txtController: finalSettlementController
                              .txtBuildingNameController,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,
                          labelYn: true,
                          hintText: "Tenant Name",
                          txtController:
                              finalSettlementController.txtTenantNameController,
                        ),
                      ),
                      gapHC(10),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests:
                            finalSettlementController.isEditModeEnabled.value,
                        hintLabel: "Branch",
                        label: "Branch",
                        labelYn: true,
                         
                        hintSize: 12,
                        controller:
                            finalSettlementController.txtBranchController,
                        onSearchTap: () {
                          if (finalSettlementController
                              .isEditModeEnabled.value) {
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
                              lookUpDialogue(
                                callBackFn: (value) {
                                  finalSettlementController.txtBranchController
                                      .text = value["CODE"].toString();
                                  Get.back();
                                },
                                tableName: "BRANCHMAST",
                                filter: [],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                      ),
                      gapHC(10),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests:
                            finalSettlementController.isEditModeEnabled.value,
                        hintLabel: "Division",
                        label: "Division",
                        labelYn: true,
                       
                        hintSize: 12,
                        controller:
                            finalSettlementController.txtDivisionController,
                        onSearchTap: () {
                          if (finalSettlementController
                              .isEditModeEnabled.value) {
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
                              lookUpDialogue(
                                callBackFn: (value) {
                                  finalSettlementController
                                      .txtDivisionController
                                      .text = value["CODE"].toString();
                                  Get.back();
                                },
                                tableName: "DIVISIONMASTER",
                                filter: [],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                      ),
                      gapHC(10),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests:
                            finalSettlementController.isEditModeEnabled.value,
                        hintLabel: "Cost center",
                        label: "Cost center",
                        labelYn: true,
                       
                        hintSize: 12,
                        controller:
                            finalSettlementController.txtCostCenterController,
                        onSearchTap: () {
                          if (finalSettlementController
                              .isEditModeEnabled.value) {
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
                              lookUpDialogue(
                                callBackFn: (value) {
                                  finalSettlementController
                                      .txtCostCenterController
                                      .text = value["CODE"].toString();
                                  Get.back();
                                },
                                tableName: "CCMAST",
                                filter: [
                                  {
                                    'Column': "CCTYPE",
                                    'Operator': '=',
                                    'Value': "D",
                                    'JoinType': 'AND'
                                  },
                                ],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Amount details",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: finalSettlementController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Net Payable",
                          txtController:
                              finalSettlementController.txtNetPayable,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: finalSettlementController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Net receivable",
                          txtController:
                              finalSettlementController.txtNetReceivable,
                        ),
                      ),
                      // gapHC(10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5),
                      //   child: PrimaryInputField(
                      //     enablests: false,

                      //     // enablests: finalSettlementController
                      //     //     .isEditModeEnabled.value,
                      //     labelYn: true,
                      //     hintText: "Net Payable",
                      //     txtController:
                      //         finalSettlementController.txtNetPayable,
                      //   ),
                      // ),

                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: finalSettlementController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Total deduction",
                          txtController:
                              finalSettlementController.txtotalDeduction,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: finalSettlementController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Amount paid",
                          txtController:
                              finalSettlementController.txtamountpaid,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: finalSettlementController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Net balance",
                          txtController:
                              finalSettlementController.txtNetBalance,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          focusNode: focusNode,
                          // enablests: false,

                          enablests:
                              finalSettlementController.isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Amount paid/receivable",
                          txtController: finalSettlementController
                              .txtAmountPaidOrReceivable,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Payment Method",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests:
                            finalSettlementController.isEditModeEnabled.value,
                        hintLabel: "Choose payment method",
                        label: "Payment Mode",
                        labelYn: true,
                       
                        hintSize: 12,
                        controller: finalSettlementController.txtPaymentMode,
                        onSearchTap: () {
                          if (finalSettlementController
                              .isEditModeEnabled.value) {
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
                              lookUpDialogue(
                                callBackFn: (value) {
                                  focusNode.unfocus();
                                  finalSettlementController.txtPaymentMode
                                      .text = value["CODE"].toString();
                                  finalSettlementController.selectedpaymentMode
                                      .value = value["CODE"].toString();

                                  Get.back();
                                },
                                tableName: "PAYMODE",
                                filter: [],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                      ),
                      gapHC(10),

                      Obx(() => Column(
                            children: [
                              Visibility(
                                visible: finalSettlementController
                                        .selectedpaymentMode.value ==
                                    "CREDITCARD",
                                child: CustomSearchField(
                                   labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                                  enablests: finalSettlementController
                                      .isEditModeEnabled.value,
                                  label: "Credit Card",
                                  labelYn: true,
                                  hintLabel: "Credit Card",
                                   
                                  hintSize: 11,
                                  onSearchTap: () {
                                    if (finalSettlementController
                                            .isEditModeEnabled.value ==
                                        true) {
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
                                        lookUpDialogue(
                                          tableName: "CREDITCARDMASTER",
                                          filter: [],
                                          callBackFn: (value) {
                                            if (value != null) {
                                              Get.back();
                                              finalSettlementController
                                                      .txtCreditCard.text =
                                                  value["CODE"].toString();
                                            }
                                          },
                                          searchColumn: searchColumn,
                                        ),
                                      );
                                    }
                                  },
                                  controller:
                                      finalSettlementController.txtCreditCard,
                                ),
                              ),
                              Visibility(
                                visible: finalSettlementController
                                        .selectedpaymentMode.value ==
                                    "CHEQUE",
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: PrimaryInputField(
                                        // enablests: false,

                                        enablests: finalSettlementController
                                            .isEditModeEnabled.value,
                                        labelYn: true,
                                        hintText: "Cheque No",
                                        txtController: finalSettlementController
                                            .txtChequeNo,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Cheque date",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Obx(
                                                () => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                      finalSettlementController
                                                          .chequeDate.value,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 13),
                                            child: Bounce(
                                              onPressed:
                                                  finalSettlementController
                                                          .isEditModeEnabled
                                                          .value
                                                      ? () async {
                                                          var date =
                                                              await showCustomDatePicker(
                                                                  date: finalSettlementController
                                                                      .chequeDate
                                                                      .value);
                                                          finalSettlementController
                                                              .chequeDate
                                                              .value = date;
                                                        }
                                                      : () {},
                                              duration: const Duration(
                                                  milliseconds: 100),
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    finalSettlementController
                                                            .isEditModeEnabled
                                                            .value
                                                        ? ThemeColors
                                                            .primaryBlueColor
                                                        : ThemeColors.grey,
                                                child: Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: ThemeColors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    CustomSearchField(
                                       labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                                      enablests: finalSettlementController
                                          .isEditModeEnabled.value,
                                      label: "Cheque bank",
                                      labelYn: true,
                                      hintLabel: "Choose cheque Bank",
                                       
                                      hintSize: 11,
                                      onSearchTap: () {
                                        if (finalSettlementController
                                                .isEditModeEnabled.value ==
                                            true) {
                                          List searchColumn = [
                                            {
                                              "showItem": true,
                                              "columnName": "CODE",
                                              "showName": "Code"
                                            },
                                            {
                                              "showItem": true,
                                              "columnName": "BANKNAME",
                                              "showName": "Description"
                                            },
                                          ];
                                          Get.dialog(
                                            barrierDismissible: false,
                                            lookUpDialogue(
                                              tableName: "BANKMASTER",
                                              filter: [],
                                              callBackFn: (value) {
                                                if (value != null) {
                                                  Get.back();
                                                  finalSettlementController
                                                          .txtChequeBank.text =
                                                      value["CODE"].toString();
                                                  finalSettlementController
                                                          .txtBankDetails.text =
                                                      value["BANKNAME"]
                                                          .toString();
                                                }
                                              },
                                              searchColumn: searchColumn,
                                            ),
                                          );
                                        }
                                      },
                                      controller: finalSettlementController
                                          .txtChequeBank,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: PrimaryInputField(
                                        // enablests: false,

                                        enablests: finalSettlementController
                                            .isEditModeEnabled.value,
                                        labelYn: true,
                                        hintText: "Cheque Bank Description",
                                        txtController: finalSettlementController
                                            .txtBankDetails,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CupertinoCheckbox(
                                          side: const BorderSide(
                                              width: 2,
                                              color:
                                                  ThemeColors.primaryBlueColor),
                                          value: finalSettlementController
                                              .isPDC.value,
                                          // value: gasMeterReadingInvoiceController.otherAmountReq.value,
                                          onChanged: finalSettlementController
                                                  .isEditModeEnabled.value
                                              ? (_) {
                                                  finalSettlementController
                                                          .isPDC.value =
                                                      !finalSettlementController
                                                          .isPDC.value;
                                                }
                                              : (_) {},
                                          activeColor:
                                              ThemeColors.primaryBlueColor,
                                        ),
                                        // ),
                                        const Text(
                                          "PDC (Post Date Cheque)",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Visibility(
                              //   visible: finalSettlementController
                              //           .selectedpaymentMode.value ==
                              //       "CHEQUE",
                              //   child: CustomSearchField(
                              //     enablests: finalSettlementController
                              //         .isEditModeEnabled.value,
                              //     label: "Cheque bank",
                              //     labelYn: true,
                              //     hintLabel: "Choose cheque Bank",
                              //     fieldColor: ThemeColors.primaryBlueColor,
                              //     hintSize: 11,
                              //     onSearchTap: () {
                              //       if (finalSettlementController
                              //               .isEditModeEnabled.value ==
                              //           true) {
                              //         List searchColumn = [
                              //           {
                              //             "showItem": true,
                              //             "columnName": "CODE",
                              //             "showName": "Code"
                              //           },
                              //           {
                              //             "showItem": true,
                              //             "columnName": "BANKNAME",
                              //             "showName": "Description"
                              //           },
                              //         ];
                              //         Get.dialog(
                              //           barrierDismissible: false,
                              //           lookUpDialogue(
                              //             tableName: "BANKMASTER",
                              //             filter: [],
                              //             callBackFn: (value) {
                              //               if (value != null) {
                              //                 Get.back();
                              //                 finalSettlementController
                              //                         .txtChequeBank.text =
                              //                     value["CODE"].toString();
                              //                 finalSettlementController
                              //                         .txtBankDetails.text =
                              //                     value["BANKNAME"].toString();
                              //               }
                              //             },
                              //             searchColumn: searchColumn,
                              //           ),
                              //         );
                              //       }
                              //     },
                              //     controller: finalSettlementController
                              //         .txtChequeBank,
                              //   ),
                              // ),
                              // Visibility(
                              //   visible: finalSettlementController
                              //           .selectedpaymentMode.value ==
                              //       "CHEQUE",
                              //   child: Padding(
                              //     padding: EdgeInsets.symmetric(
                              //         horizontal: 5, vertical: 5),
                              //     child: PrimaryInputField(
                              //       // enablests: false,

                              //       enablests: finalSettlementController
                              //           .isEditModeEnabled.value,
                              //       labelYn: true,
                              //       hintText: "Cheque Bank Description",
                              //       txtController: finalSettlementController
                              //           .txtBankDetails,
                              //     ),
                              //   ),
                              // ),
                            ],
                          )),
                      gapHC(70)
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Text _tHead({required String title, Color? color}) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          color: color ?? ThemeColors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Text _tValue({required String value, Color? color}) {
    return Text(
      value,
      style: GoogleFonts.poppins(
        color: color ?? ThemeColors.white,
        fontSize: 13,
      ),
      textAlign: TextAlign.center,
    );
  }
}
