import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/modules/recconnectionTemp/controller/temp_reconnection_controller.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReconnectionTemporaryPage extends StatefulWidget {
  ReconnectionTemporaryPage({
    super.key,
  });

  @override
  State<ReconnectionTemporaryPage> createState() =>
      _ReconnectionTemporaryPageState();
}

class _ReconnectionTemporaryPageState extends State<ReconnectionTemporaryPage> {
  TempReconnectionController tempReconnectionController =
      Get.put(TempReconnectionController());

  String? selectedOption;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog();
    });
    tempReconnectionController.fnGetLastTempContractReconnection(
        docNo: "", mode: "LAST");
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  @override
  void dispose() {
    tempReconnectionController.isEditModeEnabled.value = false;
    Get.delete<GasMeterReadingInvoiceController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: Obx(() => CustomBottomNavBar(
              fnonFirstButtonPressed: () {
                tempReconnectionController.fnGetLastTempContractReconnection(
                    mode: "FIRST", docNo: "");
              },
              fnonPreviousButtonPressed: () {
                tempReconnectionController.fnGetLastTempContractReconnection(
                    mode: "PREVIOUS",
                    docNo: tempReconnectionController.txtDocNumController.text);
              },
              fnonLastButtonPressed: () {
                tempReconnectionController.fnGetLastTempContractReconnection(
                    mode: "LAST", docNo: "");
              },
              fnonNextButtonPressed: () {
                tempReconnectionController.fnGetLastTempContractReconnection(
                    mode: "NEXT",
                    docNo: tempReconnectionController.txtDocNumController.text);
              },
              fnonSaveButtonPressed: () {
                tempReconnectionController.fnSaveTemporaryReconnection();
              },
              fnonCancelPressed: () {
                tempReconnectionController.isEditModeEnabled.value = false;
                tempReconnectionController.fnClear();
                tempReconnectionController.fnGetLastTempContractReconnection(
                    docNo: "", mode: "LAST");
              },
              fnonAddButtonPressed: () {
                tempReconnectionController.fnClear();

                tempReconnectionController.isEditModeEnabled.value =
                    !tempReconnectionController.isEditModeEnabled.value;
                fnGetGasDocMaster(docType: Global.selectedDocType).then(
                  (value) {
                    print(value);
                    tempReconnectionController.txtCostCenter.text =
                        value[0]["CCCODE"];
                    tempReconnectionController.txtDivision.text =
                        value[0]["DIVCODE"];
                    tempReconnectionController.txtBranch.text =
                        value[0]["BRNCODE"];
                  },
                );
              },
              isEditIconEnabled:
                  tempReconnectionController.isEditModeEnabled.value,
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
                          "assets/icons/connected.png",
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Temporary \n Reconnection",
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
                            flex: 3,
                            child: CustomSearchField(
                              labelColor: Colors.white,
                              label: "Request Doc No",
                              labelYn: true,
                              hintLabel: "Request Doc No",
                              controller: tempReconnectionController
                                  .txtDocNumController,
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
                                    tempReconnectionController
                                        .txtDocNumController
                                        .text = value["DOCNO"];
                                    tempReconnectionController
                                        .fnGetLastTempContractReconnection(
                                            mode: "VIEW",
                                            docNo: value["DOCNO"]);
                                    Get.back();
                                  },
                                  tableName: "GGASTEMPORARY_RECONNECTION",
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
                          ],
                        ),
                      ),
                      CustomSearchField(
                        labelColor: ThemeColors.primaryBlueColor,
                        borderColor: Colors.grey.withOpacity(0.8),
                        fieldColor: ThemeColors.white,
                        enablests:
                            tempReconnectionController.isEditModeEnabled.value,
                        labelYn: true,
                        label: "Contract No",
                        hintLabel: "Contract No",
                        hintSize: 11,
                        onSearchTap: () {
                          if (tempReconnectionController
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
                              {
                                "showItem": false,
                                "columnName": "CONNECTION_DATE",
                                "showName": "Connection Date"
                              },
                              {
                                "showItem": false,
                                "columnName": "TEMPORARY_DISCONNECT_DATE",
                                "showName": "temp disconnection Date"
                              },
                            ];
                            Get.dialog(
                              barrierDismissible: false,
                              lookUpDialogue(
                                tableName: "GGASCONTRACT",
                                callBackFn: (value) {
                                  // Get.back();

                                  getBuildingName(
                                          buildingCode: value["BUILDING_CODE"])
                                      .then((value) {
                                    tempReconnectionController
                                        .txtBuildingNameController
                                        .text = value[0]["DESCP"];
                                  });
                                  tempReconnectionController
                                      .txtContractNoController
                                      .text = value["CONTRACT_NO"];
                                  tempReconnectionController
                                      .txtBuildingCodeController
                                      .text = value["BUILDING_CODE"];
                                  tempReconnectionController
                                      .txtApartmentCodeController
                                      .text = value["APARTMENT_CODE"];
                                  tempReconnectionController
                                      .txtTenantNameController
                                      .text = value["PARTYNAME"];
                                  tempReconnectionController.lastReadingDate
                                      .value = value["LAST_READING_DATE"];
                                  tempReconnectionController.connectionDate =
                                      value["CONNECTION_DATE"];
                                  tempReconnectionController
                                          .tempDisconnectionDate.value =
                                      value["TEMPORARY_DISCONNECT_DATE"];

                                  // tempReconnectionController
                                  //     .fnValidateContractDisconnection(
                                  //         contractNo: value["CONTRACT_NO"]);
                                  Get.back();
                                },
                                filter: [
                                  {
                                    'Column': "STATUS",
                                    'Operator': '=',
                                    'Value': 'A',
                                    'JoinType': 'AND'
                                  },
                                  {
                                    'Column': "TEMPORARY_DISCONNECT_YN",
                                    'Operator': '=',
                                    'Value': 'Y',
                                    'JoinType': 'AND'
                                  },
                                ],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                        controller:
                            tempReconnectionController.txtContractNoController,
                      ),
                      gapHC(10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: PrimaryInputField(
                                enablests: false,
                                labelYn: true,
                                hintText: "Building code",
                                txtController: tempReconnectionController
                                    .txtBuildingCodeController,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: PrimaryInputField(
                                enablests: false,
                                labelYn: true,
                                hintText: "Appartment code",
                                txtController: tempReconnectionController
                                    .txtApartmentCodeController,
                              ),
                            ),
                          )
                        ],
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,
                          labelYn: true,
                          hintText: "Building Name",
                          txtController: tempReconnectionController
                              .txtBuildingNameController,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,
                          labelYn: true,
                          hintText: "Tenant Name",
                          txtController: tempReconnectionController
                              .txtTenantNameController,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last reading date",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                            tempReconnectionController
                                                            .lastReadingDate
                                                            .value !=
                                                        null &&
                                                    tempReconnectionController
                                                        .lastReadingDate
                                                        .value!
                                                        .isNotEmpty
                                                ? Helper.convertDateFormat1(
                                                    dateTime:
                                                        tempReconnectionController
                                                            .lastReadingDate
                                                            .value!)
                                                : Helper.convertDateFormat2(
                                                    dateTime: DateTime.now()
                                                        .toString()),
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold))
                                        //            Text(
                                        // Helper.convertDateFormat2(
                                        //     dateTime:
                                        //         tempReconnectionController
                                        //                 .lastReadingDate
                                        //                 .value ??
                                        //             DateTime.now()
                                        //                 .toString()),
                                        // style: GoogleFonts.poppins(
                                        //     color: Colors.black,
                                        //     fontSize: 14,
                                        //     fontWeight: FontWeight.bold)),
                                        ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 3),
                                  child: Bounce(
                                    onPressed: () {},
                                    // tempReconnectionController.contractDate.value =
                                    //     date;
                                    //   }
                                    // : () {},
                                    duration: const Duration(milliseconds: 100),
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: ThemeColors.grey,
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Temp. disconnection date",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                        tempReconnectionController
                                                        .tempDisconnectionDate
                                                        .value !=
                                                    null &&
                                                tempReconnectionController
                                                    .tempDisconnectionDate
                                                    .value!
                                                    .isNotEmpty
                                            ? Helper.convertDateFormat2(
                                                dateTime:
                                                    tempReconnectionController
                                                        .tempDisconnectionDate
                                                        .value!)
                                            : Helper.convertDateFormat2(
                                                dateTime:
                                                    DateTime.now().toString()),
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold))
                                    //            Text(
                                    // Helper.convertDateFormat2(
                                    //     dateTime:
                                    //         tempReconnectionController
                                    //                 .lastReadingDate
                                    //                 .value ??
                                    //             DateTime.now()
                                    //                 .toString()),
                                    // style: GoogleFonts.poppins(
                                    //     color: Colors.black,
                                    //     fontSize: 14,
                                    //     fontWeight: FontWeight.bold)),
                                    ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 3),
                              child: Bounce(
                                onPressed: () {},
                                // tempReconnectionController.contractDate.value =
                                //     date;
                                //   }
                                // : () {},
                                duration: const Duration(milliseconds: 100),
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ThemeColors.grey,
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
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: tempReconnectionController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Branch",
                          txtController: tempReconnectionController.txtBranch,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: tempReconnectionController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Division",
                          txtController: tempReconnectionController.txtDivision,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: tempReconnectionController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Cost center",
                          txtController:
                              tempReconnectionController.txtCostCenter,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Remarks",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          hintText: "Remarks",
                          // enablests: contractController.isEditModeEnabled.value,
                          txtController: tempReconnectionController.remarks,
                          isTextArea: true,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          // enablests: false,

                          enablests: tempReconnectionController
                              .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Referece 1",
                          txtController: tempReconnectionController.ref1,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          // enablests: false,

                          enablests: tempReconnectionController
                              .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Referece 2",
                          txtController: tempReconnectionController.ref2,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          // enablests: false,

                          enablests: tempReconnectionController
                              .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Referece 3",
                          txtController: tempReconnectionController.ref3,
                        ),
                      ),
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
