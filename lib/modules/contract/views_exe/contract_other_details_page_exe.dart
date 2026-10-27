import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/custom_phone_input.dart';
import '../../../support/common_widgets/lookup_search_field.dart';
import '../../../support/common_widgets/primary_text_field.dart';
import '../../../support/custom_theme.dart';
import '../../lookup/view/look_up_dialogue_exe.dart';
import '../controller/contract_controller.dart';

class ContractOtherDetailsPageExe extends StatelessWidget {
  ContractController contractController = Get.find();
  ContractOtherDetailsPageExe({super.key});

  @override
  Widget build(BuildContext context) {
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
                            padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "City",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: CustomSearchField(
                                hintLabel: "City",
                                enablests: contractController.isEditModeEnabled.value,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                      {"showItem": true, "columnName": "COUNTRY", "showName": "Country Code"},
                                      {"showItem": true, "columnName": "COUNTRY_NAME", "showName": "Country Name"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "CITYMASTER",
                                        filter: [],
                                        callBackFn: (value) {
                                          contractController.txtCityController.text = value["CODE"].toString();
                                          contractController.txtCountryController.text = value["COUNTRY_NAME"].toString();
                                          Get.back();
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                marginM: EdgeInsets.zero,
                                controller: contractController.txtCityController,
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
                              "Country",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: CustomSearchField(
                                hintLabel: "Country",
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
                                        tableName: "COUNTRYMAST",
                                        filter: [],
                                        callBackFn: (value) {
                                          if (value != null) {
                                            Get.back();
                                            contractController.txtCityController.clear();
                                            contractController.txtCountryController.text = value["DESCP"].toString();
                                          }
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                controller: contractController.txtCountryController,
                                marginM: EdgeInsets.zero,
                                fieldColor: ThemeColors.primaryBlueColor,
                                hintSize: 12,
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
                              "Name",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PrimaryInputField(
                                hintText: "Name",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtNameController,
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
                              "Arabic Name",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PrimaryInputField(
                                hintText: "Arabic Name",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtArabicNameController,
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
                              "Email",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PrimaryInputField(
                                hintText: "Email",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtEmailController,
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
                              "Address",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PrimaryInputField(
                                hintText: "Address",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtAddressController,
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
                              "Arabic Address",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PrimaryInputField(
                                hintText: "Arabic Address",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtArabicAddressController,
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
                              "Whatsapp No.",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                            child: PhoneNumberField(
                              hintLabel: " Whatsapp No.",
                              enablests: contractController.isEditModeEnabled.value,
                              controller: contractController.txtWhatsappNoController,
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
                              "Mobile No.",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PhoneNumberField(
                                hintLabel: "Mobile No.",
                                enablests: contractController.isEditModeEnabled.value,
                                controller: contractController.txtMobileNoController,
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
                              "Tel 1",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PrimaryInputField(
                                hintText: "Tel 1",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtTel1Controller,
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
                              "Tel 2",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                              child: PrimaryInputField(
                                hintText: "Tel 2",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtTel2Controller,
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
                              "PO Box No.",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: PrimaryInputField(
                                hintText: "PO Box No.",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtPOBoxnoController,
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
                              "TIN No.",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: PrimaryInputField(
                                hintText: "TIN No.",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtTINNoController,
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
                              "CR Days",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: PrimaryInputField(
                                hintText: "CR Days",
                                enablests: contractController.isEditModeEnabled.value,
                                txtController: contractController.txtCRDayController,
                              )),
                        ],
                      ),
                    ],
                  ),
                  gapHC(30),
                  Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: AutoSizeText(
                        "Groups",
                        maxLines: 1,
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                      )

                      ///WITH EXPANDED

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
                              "ACGP 1",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: CustomSearchField(
                                hintLabel: "ACGP 1",
                                enablests: contractController.isEditModeEnabled.value,
                                controller: contractController.txtACGP1Controller,
                                marginM: EdgeInsets.zero,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "ACGP1",
                                        filter: [],
                                        callBackFn: (value) {
                                          if (value != null) {
                                            Get.back();
                                            contractController.txtACGP1Controller.clear();
                                            contractController.txtACGP1Controller.text = value["CODE"].toString();
                                          }
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
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
                              "ACGP 2",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: CustomSearchField(
                                hintLabel: "ACGP 2",
                                enablests: contractController.isEditModeEnabled.value,
                                controller: contractController.txtACGP2Controller,
                                marginM: EdgeInsets.zero,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "ACGP2",
                                        filter: [],
                                        callBackFn: (value) {
                                          if (value != null) {
                                            Get.back();
                                            contractController.txtACGP2Controller.clear();
                                            contractController.txtACGP2Controller.text = value["CODE"].toString();
                                          }
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
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
                              "ACGP 3",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: CustomSearchField(
                                hintLabel: "ACGP 3",
                                enablests: contractController.isEditModeEnabled.value,
                                controller: contractController.txtACGP3Controller,
                                marginM: EdgeInsets.zero,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "ACGP3",
                                        filter: [],
                                        callBackFn: (value) {
                                          if (value != null) {
                                            Get.back();
                                            contractController.txtACGP3Controller.clear();
                                            contractController.txtACGP3Controller.text = value["CODE"].toString();
                                          }
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                fieldColor: ThemeColors.primaryBlueColor,
                                hintSize: 12,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "ACGP 4",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: CustomSearchField(
                                hintLabel: "ACGP 4",
                                enablests: contractController.isEditModeEnabled.value,
                                controller: contractController.txtACGP4Controller,
                                marginM: EdgeInsets.zero,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "ACGP4",
                                        filter: [],
                                        callBackFn: (value) {
                                          if (value != null) {
                                            Get.back();
                                            contractController.txtACGP4Controller.clear();
                                            contractController.txtACGP4Controller.text = value["CODE"].toString();
                                          }
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                fieldColor: ThemeColors.primaryBlueColor,
                                hintSize: 12,
                              ))
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
                              "ACGP 5",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: CustomSearchField(
                                hintLabel: "ACGP 5",
                                enablests: contractController.isEditModeEnabled.value,
                                controller: contractController.txtACGP5Controller,
                                marginM: EdgeInsets.zero,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "ACGP5",
                                        filter: [],
                                        callBackFn: (value) {
                                          if (value != null) {
                                            Get.back();
                                            contractController.txtACGP5Controller.clear();
                                            contractController.txtACGP5Controller.text = value["CODE"].toString();
                                          }
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                fieldColor: ThemeColors.primaryBlueColor,
                                hintSize: 12,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Text(
                              "ACGP 6",
                              style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                              width: Get.width * .15 < 200 ? 200 : Get.width * .15,
                              child: CustomSearchField(
                                hintLabel: "ACGP 6",
                                enablests: contractController.isEditModeEnabled.value,
                                controller: contractController.txtACGP6Controller,
                                marginM: EdgeInsets.zero,
                                onSearchTap: () {
                                  if (contractController.isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                      {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogueExe(
                                        tableName: "ACGP6",
                                        filter: [],
                                        callBackFn: (value) {
                                          if (value != null) {
                                            Get.back();
                                            contractController.txtACGP6Controller.clear();
                                            contractController.txtACGP6Controller.text = value["CODE"].toString();
                                          }
                                        },
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                fieldColor: ThemeColors.primaryBlueColor,
                                hintSize: 12,
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
