import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/controller/contract_controller.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/custom_date_picker.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/enums.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/global.dart';

class ConnectionRequestPage extends StatelessWidget {
  ConnectionRequestPage({
    super.key,
  });

  ContractController contractController = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(() => Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Connection Request Details",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.info_outline),
                    const Spacer(),
                    Bounce(
                      onPressed: () {
                        contractController.isEditModeEnabled.value = true;
                        contractController.saveMode.value = SaveModes.edit;
                      },
                      duration: Duration(milliseconds: 100),
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: ThemeColors.primaryBlueColor,
                        child: Icon(Icons.edit_outlined,
                            color: ThemeColors.white, size: 20),
                      ),
                    )
                  ],
                ),
                PrimaryInputField(
                  labelYn: true,
                  hintText: "Request No.",
                  txtController: contractController.txtReqNoController,
                  enablests: contractController.isEditModeEnabled.value,
                ),
                SizedBox(
                  height: 10,
                ),
                PrimaryInputField(
                  labelYn: true,
                  hintText: "Customer id",
                  txtController: contractController.txtCustomerIdController,
                  enablests: contractController.isEditModeEnabled.value,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contract Date",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 10),
                                //   child: Text(
                                //       contractController.connectionDate.value ==
                                //                   null ||
                                //               contractController
                                //                       .connectionDate.value ==
                                //                   ""
                                //           ? Helper.convertDateFormat2(
                                //               dateTime:
                                //                   DateTime.now().toString())
                                //           : Helper.convertDateFormat1(
                                //               dateTime: contractController
                                //                   .contractDate.value!),
                                //       style: GoogleFonts.poppins(
                                //           color: Colors.black,
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.bold)),
                                // ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    contractController.contractDate.value ==
                                                null ||
                                            contractController
                                                    .contractDate.value ==
                                                ""
                                        ? Helper.convertDateFormat2(
                                            dateTime: DateTime.now()
                                                .toIso8601String(),
                                          )
                                        : Helper.convertDateFormat2(
                                            // <-- Use convertDateFormat2 or 5 here!
                                            dateTime: contractController
                                                .contractDate.value!,
                                          ),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Bounce(
                                onPressed: contractController
                                        .isEditModeEnabled.value
                                    ? () async {
                                        var date = await showCustomDatePicker2(
                                            date: contractController
                                                    .contractDate.value ??
                                                "");
                                        contractController.contractDate.value =
                                            date;
                                      }
                                    : () {},
                                duration: const Duration(milliseconds: 100),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      contractController.isEditModeEnabled.value
                                          ? ThemeColors.primaryBlueColor
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
                      Obx(
                        () => Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Connection Date",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                      contractController.connectionDate.value ==
                                                  null ||
                                              contractController
                                                      .connectionDate.value ==
                                                  ""
                                          ? Helper.convertDateFormat2(
                                              dateTime:
                                                  DateTime.now().toString())
                                          : Helper.convertDateFormat2(
                                              dateTime: contractController
                                                      .connectionDate.value ??
                                                  ""),
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Bounce(
                                onPressed: contractController
                                        .isEditModeEnabled.value
                                    ? () async {
                                        var date = await showCustomDatePicker2(
                                            date: contractController
                                                .connectionDate.value);
                                        contractController
                                            .connectionDate.value = date;
                                      }
                                    : () {},
                                duration: const Duration(milliseconds: 100),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      contractController.isEditModeEnabled.value
                                          ? ThemeColors.primaryBlueColor
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
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryInputField(
                        labelYn: true,
                        hintText: "Priority",
                        txtController: contractController.txtPriorityController,
                        enablests: contractController.isEditModeEnabled.value,
                      ),
                    ),
                    gapWC(10),
                    Expanded(
                      child: PrimaryInputField(
                        labelYn: true,
                        hintText: "Bulding Code",
                        txtController:
                            contractController.txtBuildingCodeController,
                        enablests: contractController.isEditModeEnabled.value,
                      ),
                    ),
                  ],
                ),
                gapHC(5),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryInputField(
                        labelYn: true,
                        hintText: "Apartment code",
                        enablests: false,
                        txtController:
                            contractController.txtAppartmentCodeController,
                      ),
                    ),
                    gapWC(10),
                    Expanded(
                      child: PrimaryInputField(
                        labelYn: true,
                        hintText: "Billing customer",
                        txtController:
                            contractController.txtBillingCustomerController,
                        enablests: contractController.isEditModeEnabled.value,
                      ),
                    ),
                  ],
                ),
                CustomSearchField(
                  labelColor: ThemeColors.primaryBlueColor,
                  borderColor: Colors.grey.withOpacity(0.9),
                  enablests: contractController.isEditModeEnabled.value,
                  hintLabel: "Stock location",
                  label: "Stock location",
                  labelYn: true,
                  fieldColor: ThemeColors.white,
                  hintSize: 12,
                  controller: contractController.txtStockLocationController,
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
                        lookUpDialogue(
                          callBackFn: (value) {
                            contractController.txtStockLocationController.text =
                                value["CODE"].toString();
                            Get.back();
                          },
                          tableName: "LOCMAST",
                          filter: [
                            {
                              'Column': "COMPANY",
                              'Operator': '=',
                              'Value': Global.selectedCompanyCode,
                              'JoinType': 'AND'
                            },
                          ],
                          searchColumn: searchColumn,
                        ),
                      );
                    }
                  },
                ),
                gapHC(5),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryInputField(
                        formatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,3}')),
                        ],
                        textType:
                            TextInputType.numberWithOptions(decimal: true),
                        labelYn: true,
                        hintText: "Meter Pressure",
                        txtController:
                            contractController.txtMeterPressureController,
                        enablests: contractController.isEditModeEnabled.value,
                      ),
                    ),
                    gapWC(10),
                    Expanded(
                      child: CustomSearchField(
                        labelColor: ThemeColors.primaryBlueColor,
                        borderColor: Colors.grey.withOpacity(0.8),
                        enablests: contractController.isEditModeEnabled.value,
                        hintLabel: "Branch",
                        label: "Branch",
                        labelYn: true,
                        fieldColor: ThemeColors.white,
                        hintSize: 12,
                        controller: contractController.txtBranchController,
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
                              lookUpDialogue(
                                callBackFn: (value) {
                                  contractController.txtBranchController.text =
                                      value["CODE"].toString();
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
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        labelColor: ThemeColors.primaryBlueColor,
                        borderColor: Colors.grey.withOpacity(0.8),
                        enablests: contractController.isEditModeEnabled.value,
                        hintLabel: "Division",
                        label: "Division",
                        labelYn: true,
                        fieldColor: ThemeColors.white,
                        hintSize: 12,
                        controller: contractController.txtDivisionController,
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
                              lookUpDialogue(
                                callBackFn: (value) {
                                  contractController.txtDivisionController
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
                    ),
                    gapWC(10),
                    Expanded(
                      child: CustomSearchField(
                        labelColor: ThemeColors.primaryBlueColor,
                        borderColor: Colors.grey.withOpacity(0.8),
                        enablests: contractController.isEditModeEnabled.value,
                        hintLabel: "Cost center",
                        label: "Cost center",
                        labelYn: true,
                        fieldColor: ThemeColors.white,
                        hintSize: 12,
                        controller: contractController.txtCostCenterController,
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
                              lookUpDialogue(
                                callBackFn: (value) {
                                  contractController.txtCostCenterController
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
                    ),
                  ],
                ),
                CustomSearchField(
                  labelColor: ThemeColors.primaryBlueColor,
                  borderColor: Colors.grey.withOpacity(0.8),
                  enablests: contractController.isEditModeEnabled.value,
                  label: "Sales Man",
                  labelYn: true,
                  hintLabel: "Sales Man",
                  controller: contractController.txtSalesManController,
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
                        lookUpDialogue(
                          callBackFn: (value) {
                            contractController.txtSalesManController.text =
                                value["CODE"].toString();
                            Get.back();
                          },
                          tableName: "SMANMAST",
                          filter: [],
                          searchColumn: searchColumn,
                        ),
                      );
                    }
                  },
                  fieldColor: ThemeColors.white,
                  hintSize: 11,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => CupertinoCheckbox(
                            side: BorderSide(width: 2),
                            value: contractController.otherAmountReq.value,
                            onChanged: contractController
                                    .isEditModeEnabled.value
                                ? (_) {
                                    contractController.otherAmountReq.value =
                                        !contractController
                                            .otherAmountReq.value;
                                  }
                                : (_) {},
                            activeColor: ThemeColors.primaryBlueColor,
                          ),
                        ),
                        const Text("Other amount Required"),
                      ],
                    ),
                    Obx(
                      () => Visibility(
                          visible: contractController.otherAmountReq.value,
                          child: PrimaryInputField(
                              txtController: contractController
                                  .txtOtherRequiredAmountController,
                              labelYn: true,
                              enablests:
                                  contractController.isEditModeEnabled.value,
                              hintText: "Other Amount")),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 30,
                        child: RadioMenuButton(
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text("Percentage"),
                          value: "P",
                          onChanged: contractController.isEditModeEnabled.value
                              ? (String? value) {
                                  contractController.otherAmountCalcType.value =
                                      value!;
                                }
                              : (_) {},
                          groupValue:
                              contractController.otherAmountCalcType.value,
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 30,
                        child: RadioMenuButton(
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text("Amount"),
                          value: "A",
                          onChanged: contractController.isEditModeEnabled.value
                              ? (String? value) {
                                  contractController.otherAmountCalcType.value =
                                      value!;
                                }
                              : (_) {},
                          groupValue:
                              contractController.otherAmountCalcType.value,
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 30,
                        child: RadioMenuButton(
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text("Monthly"),
                          value: "L",
                          onChanged: contractController.isEditModeEnabled.value
                              ? (String? value) {
                                  contractController.otherAmountCalcType.value =
                                      value!;
                                }
                              : (_) {},
                          groupValue:
                              contractController.otherAmountCalcType.value,
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 30,
                        child: RadioMenuButton(
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: const Text("Multiple"),
                          value: "M",
                          onChanged: contractController.isEditModeEnabled.value
                              ? (String? value) {
                                  contractController.otherAmountCalcType.value =
                                      value!;
                                }
                              : (_) {},
                          groupValue:
                              contractController.otherAmountCalcType.value,
                        ),
                      ),
                    ),
                    gapHC(20)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
