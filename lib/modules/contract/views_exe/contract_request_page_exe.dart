import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue_exe.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/custom_date_picker.dart';
import '../../../support/common_widgets/gap.dart';
import '../../../support/common_widgets/lookup_search_field.dart';
import '../../../support/common_widgets/primary_text_field.dart';
import '../../../support/custom_theme.dart';
import '../../../support/helper.dart';
import '../controller/contract_controller.dart';

class ContractRequestPageExe extends StatelessWidget {
  ContractController contractController = Get.find();
  ContractRequestPageExe({super.key});
  @override
  Widget build(BuildContext context) {
    String? selectedOption;
    return Container(
      margin: EdgeInsets.only(right: Get.width * .07, bottom: Get.height * .02, top: Get.height * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Request No",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: PrimaryInputField(
                                hintText: "Request No",
                                enablests: false,
                                txtController: contractController.txtReqNoController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                              "Customer Id",
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: PrimaryInputField(
                                hintText: "Customer Id",
                                enablests: false,
                                txtController: contractController.txtCustomerIdController,
                              )),
                        ],
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 15.0, bottom: 5),
                      //       child: Text(
                      //         "Contract No.",
                      //         style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: EdgeInsets.only(right: 70.0),
                      //       child: SizedBox(
                      //           width: Get.width * .3,
                      //           child: CustomSearchField(
                      //             hintLabel: "Contract No.",
                      //             controller: contractController.txtcontractNoController,
                      //             onSearchTap: () {
                      //               if (contractController.isEditModeEnabled.value) {
                      //                 List searchColumn = [
                      //                   {"showItem": true, "columnName": "CONTRACT_NO", "showName": "Contract No"},
                      //                   {"showItem": true, "columnName": "PARTYNAME", "showName": "Party Name"},
                      //                   {"showItem": true, "columnName": "BUILDING_CODE", "showName": "Building Code"},
                      //                   {"showItem": true, "columnName": "APARTMENT_CODE", "showName": "Apartment Code"},
                      //                 ];
                      //                 Get.dialog(
                      //                   barrierDismissible: false,
                      //                   lookUpDialogueExe(
                      //                     tableName: "GGASCONTRACT",
                      //                     filter: [],
                      //                     callBackFn: (value) {},
                      //                     searchColumn: searchColumn,
                      //                   ),
                      //                 );
                      //               }
                      //             },
                      //             marginM: EdgeInsets.zero,
                      //             fieldColor: ThemeColors.primaryBlueColor,
                      //             hintSize: 12,
                      //           )),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        width: 200,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Bounce(
                            duration: Duration(milliseconds: 100),
                            onPressed: () {
                              showCustomDatePickerExe();
                            },
                            child: Obx(
                              () => Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Contract Date",
                                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                            contractController.connectionDate.value == null || contractController.connectionDate.value == ""
                                                ? Helper.convertDateFormat2(dateTime: DateTime.now().toString())
                                                : Helper.convertDateFormat1(dateTime: contractController.contractDate.value!),
                                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Bounce(
                                      onPressed: () async {
                                        // Helper.convertDateFormat1(dateTime: "");
                                        var date = await showCustomDatePicker(date: contractController.contractDate.value);
                                        contractController.contractDate.value = date;
                                      },
                                      duration: const Duration(milliseconds: 100),
                                      child: const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: ThemeColors.primaryBlueColor,
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
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Connection Date",
                                    style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text("01-10-2024", style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Padding(
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
                      ),
                      gapWC(Get.width * .1 < 170 ? 0 : Get.width * .1),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Priority",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: PrimaryInputField(
                                hintText: "Priority",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtPriorityController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Building Code",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: PrimaryInputField(
                                hintText: "Building Code",
                                enablests: false,
                                txtController: contractController.txtBuildingCodeController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Apartment Code",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: PrimaryInputField(
                                onChanged: (p0) {},
                                hintText: "Apartment Code",
                                enablests: false,
                                txtController: contractController.txtAppartmentCodeController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Billing Customer",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: PrimaryInputField(
                                hintText: "Billing Customer",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtBillingCustomerController,
                                onChanged: (p0) {},
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Stock Location",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: CustomSearchField(
                                hintLabel: "Stock Location",
                                controller: contractController.txtStockLocationController,
                                fieldColor: ThemeColors.primaryBlueColor,
                                enablests: contractController.isEditModeEnabled.value,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "LOCMAST",
                                        callBackFn: (value) {
                                          contractController.txtStockLocationController.text = value["CODE"].toString();
                                          Get.back();
                                        },
                                        filter: [
                                          {'Column': "COMPANY", 'Operator': '=', 'Value': Global.selectedCompanyCode, 'JoinType': 'AND'},
                                        ],
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                onChanged: (p0) {},
                                hintSize: 12,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Meter Pressure",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: PrimaryInputField(
                                enablests: contractController.isEditModeEnabled.value,
                                hintText: "Meter Pressure",
                                txtController: contractController.txtMeterPressureController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Branch",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: CustomSearchField(
                                hintLabel: "Branch",
                                fieldColor: ThemeColors.primaryBlueColor,
                                enablests: contractController.isEditModeEnabled.value,
                                hintSize: 12,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "BRANCHMAST",
                                        filter: [],
                                        callBackFn: (value) {
                                          contractController.txtBranchController.text = value["CODE"].toString();
                                          Get.back();
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                controller: contractController.txtBranchController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5),
                            child: Text(
                              "Division",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: CustomSearchField(
                                hintLabel: "Division",
                                fieldColor: ThemeColors.primaryBlueColor,
                                enablests: contractController.isEditModeEnabled.value,
                                hintSize: 12,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "DIVISIONMASTER",
                                        filter: [],
                                        callBackFn: (value) {
                                          contractController.txtDivisionController.text = value["CODE"].toString();
                                          Get.back();
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                controller: contractController.txtDivisionController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Cost Center",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: CustomSearchField(
                                enablests: contractController.isEditModeEnabled.value,
                                hintLabel: "Cost Center",
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "CCMAST",
                                        callBackFn: (value) {
                                          contractController.txtCostCenterController.text = value["CODE"].toString();
                                          Get.back();
                                        },
                                        filter: [
                                          {'Column': "CCTYPE", 'Operator': '=', 'Value': "D", 'JoinType': 'AND'},
                                        ],
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                fieldColor: ThemeColors.primaryBlueColor,
                                hintSize: 12,
                                controller: contractController.txtCostCenterController,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "Sales Man",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                              child: CustomSearchField(
                                hintLabel: "Sales Man",
                                enablests: contractController.isEditModeEnabled.value,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "SMANMAST",
                                        callBackFn: (value) {
                                          contractController.txtSalesManController.text = value["CODE"].toString();
                                          Get.back();
                                        },
                                        filter: [],
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                controller: contractController.txtSalesManController,
                                fieldColor: ThemeColors.primaryBlueColor,
                                hintSize: 12,
                              )),
                        ],
                      ),
                    ],
                  ),
                  gapHC(15),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Row(
                          children: [
                            Obx(
                              () => CupertinoCheckbox(
                                value: contractController.otherAmountReq.value,
                                onChanged: (s) {
                                  contractController.otherAmountReq.value = !contractController.otherAmountReq.value;
                                },
                                activeColor: ThemeColors.primaryBlueColor,
                              ),
                            ),
                            const Text("Other amount Required"),
                          ],
                        ),
                      ),
                      Obx(
                        () => Visibility(
                            visible: contractController.otherAmountReq.value,
                            child: SizedBox(
                                width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0, bottom: 10, right: 11.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.0, bottom: 5),
                                        child: Text(
                                          "Other Amount",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      PrimaryInputField(
                                        enablests: contractController.isEditModeEnabled.value,
                                        txtController: contractController.txtOtherRequiredAmountController,
                                        hintText: "Other Amount",
                                      ),
                                    ],
                                  ),
                                ))),
                      ),
                      Obx(
                        () => SizedBox(
                          height: 30,
                          width: 180,
                          child: RadioMenuButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: const Text("Percentage"),
                            value: "P",
                            onChanged: (value) {
                              contractController.otherAmountCalcType.value = value!;
                            },
                            groupValue: contractController.otherAmountCalcType.value,
                          ),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          height: 30,
                          width: 180,
                          child: RadioMenuButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            value: "A",
                            onChanged: (value) {
                              // setState(() {
                              contractController.otherAmountCalcType.value = value!;

                              // });
                            },
                            groupValue: contractController.otherAmountCalcType.value,
                            child: const Text("Amount"),
                          ),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          height: 30,
                          width: 180,
                          child: RadioMenuButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            value: "L",
                            onChanged: (value) {
                              contractController.otherAmountCalcType.value = value!;

                              // setState(() {
                              //   selectedOption = value.toString();
                              // });
                            },
                            groupValue: contractController.otherAmountCalcType.value,
                            child: const Text("Monthly"),
                          ),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          height: 30,
                          width: 180,
                          child: RadioMenuButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: const Text("Multiple"),
                            value: "M",
                            onChanged: (value) {
                              contractController.otherAmountCalcType.value = value!;
                            },
                            groupValue: contractController.otherAmountCalcType.value,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
