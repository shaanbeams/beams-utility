import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/disconnectionRequest/controller/disconnection_request_controller.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/controller/temp_disconnection_controller.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
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

class DisconnectionRequestPage extends StatefulWidget {
  DisconnectionRequestPage({super.key, this.isFromInvoicePage = false});

  final bool? isFromInvoicePage;

  @override
  State<DisconnectionRequestPage> createState() =>
      _DisconnectionRequestPageState();
}

class _DisconnectionRequestPageState extends State<DisconnectionRequestPage> {
  DisconnectionRequestController disconnectionRequestController =
      Get.put(DisconnectionRequestController());

  String? selectedOption;

  @override
  void initState() {
    super.initState();

    if (widget.isFromInvoicePage == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showLoadingDialog();
      });
      disconnectionRequestController.fnGetLastDisconnectionRequest(
          docNo: "", mode: "LAST");
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  @override
  void dispose() {
    disconnectionRequestController.isEditModeEnabled.value = false;
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
                disconnectionRequestController.fnGetLastDisconnectionRequest(
                    mode: "FIRST", docNo: "");
              },
              fnonPreviousButtonPressed: () {
                disconnectionRequestController.fnGetLastDisconnectionRequest(
                    mode: "PREVIOUS",
                    docNo: disconnectionRequestController
                        .txtDocNumController.text);
              },
              fnonLastButtonPressed: () {
                disconnectionRequestController.fnGetLastDisconnectionRequest(
                    mode: "LAST", docNo: "");
              },
              fnonNextButtonPressed: () {
                disconnectionRequestController.fnGetLastDisconnectionRequest(
                    mode: "NEXT",
                    docNo: disconnectionRequestController
                        .txtDocNumController.text);
              },
              fnonSaveButtonPressed: () {
                disconnectionRequestController.fnSaveDisconnectionRequest();
              },
              fnonCancelPressed: () {
                disconnectionRequestController.isEditModeEnabled.value = false;
                disconnectionRequestController.fnClear();
                disconnectionRequestController.fnGetLastDisconnectionRequest(
                    docNo: "", mode: "LAST");
              },
              fnonAddButtonPressed: () {
                disconnectionRequestController.fnClear();

                disconnectionRequestController.isEditModeEnabled.value =
                    !disconnectionRequestController.isEditModeEnabled.value;
                // fnGetGasDocMaster(docType: Global.selectedDocType).then(
                //   (value) {
                //     print(value);
                //     disconnectionRequestController.txtCostCenter.text =
                //         value[0]["CCCODE"];
                //     disconnectionRequestController.txtDivision.text =
                //         value[0]["DIVCODE"];
                //     disconnectionRequestController.txtBranch.text =
                //         value[0]["BRNCODE"];
                //   },
                // );
              },
              isEditIconEnabled:
                  disconnectionRequestController.isEditModeEnabled.value,
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
                          "assets/icons/disconnection_req.png",
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Disconnection \n Request",
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
                              controller: disconnectionRequestController
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
                                    disconnectionRequestController
                                        .txtDocNumController
                                        .text = value["DOCNO"];
                                    disconnectionRequestController
                                        .fnGetLastDisconnectionRequest(
                                            mode: "VIEW",
                                            docNo: value["DOCNO"]);
                                    Get.back();
                                  },
                                  tableName: "GGASDISCONNECTION_REQUEST",
                                  filter: const [],
                                  searchColumn: searchColumn,
                                ));
                              },
                            )
                          
                            ),
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
                        enablests: disconnectionRequestController
                            .isEditModeEnabled.value,
                        labelYn: true,
                        label: "Contract No",
                        hintLabel: "Contract No",
                    
                        hintSize: 11,
                        onSearchTap: () {
                          if (disconnectionRequestController
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
                                "columnName": "CONNECTION_DATE",
                                "showName": "Connection Date"
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
                                    disconnectionRequestController
                                        .txtBuildingNameController
                                        .text = value[0]["DESCP"];
                                  });
                                  disconnectionRequestController
                                      .txtContractNoController
                                      .text = value["CONTRACT_NO"];
                                  disconnectionRequestController
                                      .txtBuildingCodeController
                                      .text = value["BUILDING_CODE"];
                                  disconnectionRequestController
                                      .txtApartmentCodeController
                                      .text = value["APARTMENT_CODE"];
                                  disconnectionRequestController
                                      .txtTenantNameController
                                      .text = value["PARTYNAME"];

                                  Get.back();
                                },
                                filter: [
                                  {
                                    'Column': "STATUS",
                                    'Operator': '=',
                                    'Value': 'A',
                                    'JoinType': 'AND'
                                  },
                                ],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                        controller: disconnectionRequestController
                            .txtContractNoController,
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
                                txtController: disconnectionRequestController
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
                                txtController: disconnectionRequestController
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
                          txtController: disconnectionRequestController
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
                          txtController: disconnectionRequestController
                              .txtTenantNameController,
                        ),
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
                                  "Expected Disconnection Date",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                        disconnectionRequestController
                                                        .expctedDate.value !=
                                                    null &&
                                                disconnectionRequestController
                                                    .expctedDate
                                                    .value!
                                                    .isNotEmpty
                                            ? Helper.convertDateFormat5(
                                                dateTime:
                                                    disconnectionRequestController
                                                        .expctedDate.value!)
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
                                    //         disconnectionRequestController
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
                                onPressed: disconnectionRequestController
                                        .isEditModeEnabled.value
                                    ? () async {
                                        var date = await showCustomDatePicker(
                                            date: disconnectionRequestController
                                                    .expctedDate.value ??
                                                DateTime.now().toString());

                                        disconnectionRequestController
                                            .expctedDate.value = date;
                                      }
                                    : () {},

                                // disconnectionRequestController.contractDate.value =
                                //     date;
                                // }
                                // : () {},
                                duration: const Duration(milliseconds: 100),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      disconnectionRequestController
                                              .isEditModeEnabled.value
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
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          // enablests: false,

                          enablests: disconnectionRequestController
                              .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "IBAN",
                          txtController:
                              disconnectionRequestController.txtIBANNo,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: disconnectionRequestController
                              .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Account No.",
                          txtController:
                              disconnectionRequestController.txtAccountNo,
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   child: Text(
                      //     "Remarks",
                      //     style: GoogleFonts.poppins(
                      //         color: Colors.black,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // gapHC(10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5),
                      //   child: PrimaryInputField(
                      //     hintText: "Remarks",
                      //     enablests: disconnectionRequestController
                      //         .isEditModeEnabled.value,
                      //     txtController:
                      //         disconnectionRequestController.txtRemark,
                      //     isTextArea: true,
                      //   ),
                      // ),
                      // gapHC(10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5),
                      //   child: PrimaryInputField(
                      //     // enablests: false,

                      //     enablests: disconnectionRequestController
                      //         .isEditModeEnabled.value,
                      //     labelYn: true,
                      //     hintText: "Referece 1",
                      //     txtController: disconnectionRequestController.ref1,
                      //   ),
                      // ),
                      // gapHC(10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5),
                      //   child: PrimaryInputField(
                      //     // enablests: false,

                      //     enablests: disconnectionRequestController
                      //         .isEditModeEnabled.value,
                      //     labelYn: true,
                      //     hintText: "Referece 2",
                      //     txtController: disconnectionRequestController.ref2,
                      //   ),
                      // ),
                      // gapHC(10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 5),
                      //   child: PrimaryInputField(
                      //     // enablests: false,

                      //     enablests: disconnectionRequestController
                      //         .isEditModeEnabled.value,
                      //     labelYn: true,
                      //     hintText: "Referece 3",
                      //     txtController: disconnectionRequestController.ref3,
                      //   ),
                      // ),
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
