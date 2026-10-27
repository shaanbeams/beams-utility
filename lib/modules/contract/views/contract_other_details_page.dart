import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/controller/contract_controller.dart';
import 'package:gas_utility_app/support/common_widgets/custom_phone_input.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/enums.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../lookup/view/look_up_dialogue.dart';

class ContractOtherPage extends StatelessWidget {
  ContractOtherPage({
    super.key,
  });
  TextEditingController txtwhatsAppController = TextEditingController();
  TextEditingController txtmobileController = TextEditingController();
  ContractController contractController = Get.put(ContractController());
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Customer Details",
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
            Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
                  borderColor: Colors.grey.withOpacity(0.8),

                    enablests: contractController.isEditModeEnabled.value,
                    label: "City",
                    labelYn: true,
                    hintLabel: "City",
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
                          {
                            "showItem": true,
                            "columnName": "COUNTRY",
                            "showName": "Country Code"
                          },
                          {
                            "showItem": true,
                            "columnName": "COUNTRY_NAME",
                            "showName": "Country Name"
                          },
                        ];
                        Get.dialog(
                          barrierDismissible: false,
                          lookUpDialogue(
                            tableName: "CITYMASTER",
                            filter: [],
                            callBackFn: (value) {
                              contractController.txtCityController.text =
                                  value["CODE"].toString();
                              contractController.txtCountryController.text =
                                  value["COUNTRY_NAME"].toString();
                              Get.back();
                            },
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
                    controller: contractController.txtCityController,
                  ),
                ),
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
                 borderColor: Colors.grey.withOpacity(0.8),
                    enablests: contractController.isEditModeEnabled.value,
                    label: "Country",
                    labelYn: true,
                    hintLabel: "Country",
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
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
                            tableName: "COUNTRYMAST",
                            filter: [],
                            callBackFn: (value) {
                              if (value != null) {
                                Get.back();
                                contractController.txtCityController.clear();
                                contractController.txtCountryController.text =
                                    value["DESCP"].toString();
                              }
                            },
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtCountryController,
                  ),
                ),
              ],
            ),
            gapHC(5),
            // Row(
            //   children: [
            //     Expanded(
            //       child: PrimaryInputField(
            //         enablests: contractController.isEditModeEnabled.value,
            //         labelYn: true,
            //         hintText: "Name",
            //         txtController: contractController.txtNameController,
            //       ),
            //     ),
            //     gapWC(10),
            //     Expanded(
            //       child: PrimaryInputField(
            //         enablests: contractController.isEditModeEnabled.value,
            //         labelYn: true,
            //         hintText: "Arabic Name",
            //         txtController: contractController.txtArabicNameController,
            //       ),
            //     ),
            //   ],
            // ),
            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintText: "Name",
              txtController: contractController.txtNameController,
            ),
            gapHC(5),

            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintText: "Arabic Name",
              txtController: contractController.txtArabicNameController,
            ),
            gapHC(5),
            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintText: "Email",
              txtController: contractController.txtEmailController,
            ),
            gapHC(5),
            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintText: "Address",
              txtController: contractController.txtAddressController,
            ),
            gapHC(5),
            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              txtController: contractController.txtArabicAddressController,
              hintText: "Arabic address",
            ),
            gapHC(5),
            PhoneNumberField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintLabel: " Whatsapp No.",
              controller: txtwhatsAppController,
            ),
            PhoneNumberField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintLabel: " Mobile No.",
              controller: txtmobileController,
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryInputField(
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    hintText: "Tel 1",
                    txtController: contractController.txtTel1Controller,
                    textType: TextInputType.number,
                  ),
                ),
                gapWC(10),
                Expanded(
                  child: PrimaryInputField(
                      enablests: contractController.isEditModeEnabled.value,
                      labelYn: true,
                      hintText: "Tel 2",
                      txtController: contractController.txtTel2Controller,
                      textType: TextInputType.number),
                ),
              ],
            ),
            gapHC(5),
            Row(
              children: [
                Expanded(
                  child: PrimaryInputField(
                      enablests: contractController.isEditModeEnabled.value,
                      labelYn: true,
                      hintText: "PO Box No.",
                      txtController: contractController.txtPOBoxnoController,
                      textType: TextInputType.number),
                ),
                gapWC(10),
                Expanded(
                  child: PrimaryInputField(
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    hintText: "TIN No.",
                    txtController: contractController.txtTINNoController,
                  ),
                ),
              ],
            ),
            gapHC(5),
            PrimaryInputField(
                enablests: contractController.isEditModeEnabled.value,
                labelYn: true,
                hintText: "CR Days",
                textType: TextInputType.number
                // txtController: contractController.cr,
                ),
            gapHC(10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Groups",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            gapHC(10),
            Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
               borderColor: Colors.grey.withOpacity(0.8),
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    label: "ACGP 1",
                    hintLabel: "ACGP 1",
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
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
                            tableName: "ACGP1",
                            callBackFn: (value) {
                              contractController.txtACGP1Controller.text =
                                  value["CODE"].toString();
                              Get.back();
                            },
                            filter: [],
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtACGP1Controller,
                  ),
                ),
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
                  borderColor: Colors.grey.withOpacity(0.8),
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    label: "ACGP 2",
                    hintLabel: "ACGP 2",
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
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
                            tableName: "ACGP2",
                            callBackFn: (value) {
                              contractController.txtACGP2Controller.text =
                                  value["CODE"].toString();
                              Get.back();
                            },
                            filter: [],
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtACGP2Controller,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
                  borderColor: Colors.grey.withOpacity(0.8),

                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    label: "ACGP 3",
                    hintLabel: "ACGP 3",
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
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
                            tableName: "ACGP3",
                            callBackFn: (value) {
                              contractController.txtACGP3Controller.text =
                                  value["CODE"].toString();
                              Get.back();
                            },
                            filter: [],
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtACGP3Controller,
                  ),
                ),
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
              borderColor: Colors.grey.withOpacity(0.8),
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    label: "ACGP 4",
                    hintLabel: "ACGP 4",
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
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
                            tableName: "ACGP4",
                            callBackFn: (value) {
                              contractController.txtACGP4Controller.text =
                                  value["CODE"].toString();
                              Get.back();
                            },
                            filter: [],
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtACGP4Controller,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    label: "ACGP 5",
                    hintLabel: "ACGP 5",
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
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
                            tableName: "ACGP5",
                            callBackFn: (value) {
                              contractController.txtACGP5Controller.text =
                                  value["CODE"].toString();
                              Get.back();
                            },
                            filter: [],
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtACGP5Controller,
                  ),
                ),
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    label: "ACGP 6",
                    hintLabel: "ACGP 6",
                    fieldColor: ThemeColors.white,
                    hintSize: 11,
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
                            tableName: "ACGP6",
                            callBackFn: (value) {
                              contractController.txtACGP6Controller.text =
                                  value["CODE"].toString();
                              Get.back();
                            },
                            filter: [],
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtACGP6Controller,
                  ),
                ),
              ],
            ),
            gapHC(60),
          ],
        ),
      ),
    );
  }
}
