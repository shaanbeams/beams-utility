import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import 'package:gas_utility_app/modules/home/view/widgets/select_doc_type_widget.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/modules/readingCorrection/controller/reading_correction_controller.dart';
import 'package:gas_utility_app/support/common_widgets/commonDialog.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/custom_date_picker.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/image_picker.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/common_widgets/signature_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ReadingCorrectionPage extends StatefulWidget {
  ReadingCorrectionPage({Key? key}) : super(key: key);

  @override
  State<ReadingCorrectionPage> createState() => _ReadingCorrectionPageState();
}

class _ReadingCorrectionPageState extends State<ReadingCorrectionPage>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<TabController> tabController;

  PageController pageController = PageController();
  ReadingCorrectionController readingCorrectionController =
      Get.put(ReadingCorrectionController());
  GasMeterReadingInvoiceController gasMeterReadingInvoiceController =
      Get.put(GasMeterReadingInvoiceController());

  @override
  void initState() {
    super.initState();
    readingCorrectionController.fnGetLastReadingCorrection;
    tabController = ValueNotifier(TabController(length: 2, vsync: this));
  }

  @override
  void dispose() {
    tabController.value.dispose(); // Dispose the TabController
    tabController.dispose(); // Dispose the ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Obx(
        () => readingCorrectionController.isEditModeEnabled.value == false
            ? Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: PrimaryButton(
                  buttonLabel: "Generate Invoice",
                  onPressed: () {
                    selectDoctTypeDialogueNext(prvDocType: "GIN").then((value) {
                      if (value.isNotEmpty) {
                        gasMeterReadingInvoiceController
                            .fnValidateReadingInvoice(
                                readingDocNo: readingCorrectionController
                                    .txtDocNumController.text,
                                readingDocType: readingCorrectionController
                                    .contractReadingDocType,
                                readingYearCode: Global.selectedCompanyYear);
                      }

                      // Get.off(() => GasMeterReadingInvoicePage(isFromReadingPage: true,));
                    });
                  },
                  buttonColor: ThemeColors.primaryGreenColor,
                  buttonWidth: 200,
                ))
            : Container(),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
            isEditIconEnabled:
                readingCorrectionController.isEditModeEnabled.value,
            fnonFirstButtonPressed: () {
              showLoadingDialog();

              readingCorrectionController.fnGetLastReadingCorrection(
                  mode: "FIRST", docNo: "");
            },
            fnonPreviousButtonPressed: () {
              Get.dialog(
                  barrierDismissible: false,
                  Lottie.asset("assets/lotties/loader4.json"));
              readingCorrectionController.fnGetLastReadingCorrection(
                  mode: "PREVIOUS",
                  docNo: readingCorrectionController.txtDocNumController.text);
            },
            fnonNextButtonPressed: () {
              Get.dialog(
                  barrierDismissible: false,
                  Lottie.asset("assets/lotties/loader4.json"));
              readingCorrectionController.fnGetLastReadingCorrection(
                  mode: "NEXT",
                  docNo: readingCorrectionController.txtDocNumController.text);
            },
            fnonLastButtonPressed: () {
              Get.dialog(
                  barrierDismissible: false,
                  Lottie.asset("assets/lotties/loader4.json"));
              readingCorrectionController.fnGetLastReadingCorrection(
                  mode: "LAST", docNo: "");
            },
            fnonSaveButtonPressed: () {
              readingCorrectionController.fnSaveReadingCorrection();
            },
            fnonCancelPressed: () {
              Get.dialog(
                  barrierDismissible: false,
                  Lottie.asset("assets/lotties/loader4.json"));
              readingCorrectionController.fnGetLastReadingCorrection(
                  mode: "LAST", docNo: "");
              readingCorrectionController.isEditModeEnabled.value = false;
            },
            // widget.isFromAssignPage == true
            //     ?
            //      () {
            //         Get.back();
            //       }
            //     :
            //      () {
            //         readingCorrectionController.isEditModeEnabled.value = false;
            //       },
            fnonAddButtonPressed: () {
              readingCorrectionController.fnClear();

              readingCorrectionController.isEditModeEnabled.value =
                  !readingCorrectionController.isEditModeEnabled.value;
            },
            isAddButtonRequired: true,
          )),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: Get.size.height / 3.7,
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
                        "assets/icons/reading_correction.PNG",
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Reading \n Correction  ",
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
                          controller:
                              readingCorrectionController.txtDocNumController,
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
                                readingCorrectionController
                                    .txtDocNumController.text = value["DOCNO"];
                                readingCorrectionController
                                    .fnGetLastReadingCorrection(
                                        mode: "VIEW", docNo: value["DOCNO"]);
                                Get.back();
                              },
                              tableName: "GREADING_CORRECTION",
                              filter: [],
                              searchColumn: searchColumn,
                            ));
                          },
                        ),

                        // child: CustomSearchField(
                        //   labelColor: Colors.white,
                        //   label: "Request Doc No",
                        //   labelYn: true,
                        //   hintLabel: "Request Doc No",
                        //   controller: readingCorrectionController.txtDocNumController,
                        // ),
                      ),
                      gapWC(10),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            _tHead(
                              title: "Date : ",
                            ),
                            Obx(() => readingCorrectionController
                                    .isEditModeEnabled.value
                                ? _tValue(
                                    value: Helper.convertDateFormat2(
                                        dateTime: DateTime.now().toString()))
                                : _tValue(
                                    value: Helper.convertDateFormat1(
                                        dateTime: readingCorrectionController
                                                .docdate.value ??
                                            "01/01/2000 12:00:00 AM")))
                            // _tValue(
                            //     value:

                            //      Helper.convertDateFormat2(
                            //         dateTime: DateTime.now().toString())),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
              valueListenable: tabController,
              builder: (context, val, child) {
                return _tabBar(
                  tabController: tabController,
                  pageController: pageController,
                );
              }),
          Expanded(
            child: Obx(
              () => PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    tabController.value.animateTo(
                      value,
                    );
                    tabController.value.index = value;
                  });
                },
                children: [
                  SingleChildScrollView(
                    child: Column(
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
                              const Spacer(),
                              // Bounce(
                              //     onPressed: () {
                              //       // listViewScrollController.animateTo(
                              //       //     listViewScrollController
                              //       //         .position.maxScrollExtent,
                              //       //     duration: const Duration(seconds: 1),
                              //       //     curve: Curves.easeInOut);
                              //     },
                              //     duration: const Duration(milliseconds: 100),
                              //     child: Container(
                              //       margin: const EdgeInsets.only(bottom: 10),
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(30),
                              //         color: ThemeColors.primaryBlueColor,
                              //         boxShadow: [
                              //           BoxShadow(
                              //             color: Colors.grey.withOpacity(0.6),
                              //             spreadRadius: 2,
                              //             blurRadius: 5,
                              //             offset: const Offset(0, 5),
                              //           ),
                              //         ],
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 10.0, horizontal: 5),
                              //         child: _tHead(
                              //           title: "Update Tenants",
                              //         ),
                              //       ),
                              //     ))
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomSearchField(
                                labelColor: ThemeColors.primaryBlueColor,
                                borderColor: Colors.grey.withOpacity(0.8),
                                fieldColor: ThemeColors.white,
                                enablests: readingCorrectionController
                                    .isEditModeEnabled.value,
                                labelYn: true,
                                label: "building code",
                                hintLabel: "building code",
                                hintSize: 11,
                                onSearchTap: () {
                                  if (readingCorrectionController
                                      .isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {
                                        "showItem": true,
                                        "columnName": "BUILDING_CODE",
                                        "showName": "Building Code"
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
                                        tableName: "GBUILDINGMASTER",
                                        callBackFn: (value) {
                                          readingCorrectionController.fnClear();
                                          readingCorrectionController
                                              .txtBuildingCodeController
                                              .text = value["BUILDING_CODE"];
                                          readingCorrectionController
                                              .txtBuildingNameController
                                              .text = value["DESCP"];

                                          Get.back();
                                        },
                                        filter: [],
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                    // }
                                  }
                                },
                                controller: readingCorrectionController
                                    .txtBuildingCodeController,
                              ),
                            ),
                            Expanded(
                              child: CustomSearchField(
                                labelColor: ThemeColors.primaryBlueColor,
                                borderColor: Colors.grey.withOpacity(0.8),
                                fieldColor: ThemeColors.white,
                                enablests: readingCorrectionController
                                    .isEditModeEnabled.value,
                                labelYn: true,
                                label: "Appartment code",
                                hintLabel: "Appartment code",
                                hintSize: 11,
                                onSearchTap: () {
                                  if (readingCorrectionController
                                      .txtBuildingCodeController.text.isEmpty) {
                                    errorMsg(msg: "Select Building code");
                                    return;
                                  }

                                  if (readingCorrectionController
                                      .isEditModeEnabled.value) {
                                    List searchColumn = [
                                      {
                                        "showItem": true,
                                        "columnName": "APARTMENT_CODE",
                                        "showName": " Code"
                                      },
                                      // {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                    ];
                                    Get.dialog(
                                      barrierDismissible: false,
                                      lookUpDialogue(
                                        tableName: "GAPARTMENTMASTER",
                                        callBackFn: (value) {
                                          readingCorrectionController
                                              .txtApartmentCodeController
                                              .text = value["APARTMENT_CODE"];

                                          Get.back();
                                          readingCorrectionController
                                              .fnValidateApartment();
                                        },
                                        filter: [
                                          {
                                            'Column': "BUILDING_CODE",
                                            'Operator': '=',
                                            'Value': readingCorrectionController
                                                .txtBuildingCodeController.text,
                                            'JoinType': 'AND'
                                          },
                                        ],
                                        searchColumn: searchColumn,
                                      ),
                                    );
                                  }
                                },
                                controller: readingCorrectionController
                                    .txtApartmentCodeController,
                              ),
                            ),
                          ],
                        ),
                        gapHC(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: PrimaryInputField(
                            enablests: readingCorrectionController
                                .isEditModeEnabled.value,
                            labelYn: true,
                            hintText: "Building Name",
                            txtController: readingCorrectionController
                                .txtBuildingNameController,
                          ),
                        ),
                        gapHC(10),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 5),
                        //   child: PrimaryInputField(
                        //     // enablests: readingCorrectionController.isEditModeEnabled.value,
                        //     labelYn: true,
                        //     hintText: "Gas Meter No.",
                        //     // txtController: readingCorrectionController.txtGasMeterNoController,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 5),
                        //   child: PrimaryInputField(
                        //       enablests: readingCorrectionController
                        //           .isEditModeEnabled.value,
                        //       labelYn: true,
                        //       hintText: "Gas Meter No.",
                        //       txtController: readingCorrectionController
                        //           .txtGasMeterController),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: PrimaryInputField(
                                  enablests: readingCorrectionController
                                      .isEditModeEnabled.value,
                                  labelYn: true,
                                  hintText: "ContractNo",
                                  txtController: readingCorrectionController
                                      .txtContractNoController,
                                ),
                              ),
                              gapWC(10),
                              Expanded(
                                child: PrimaryInputField(
                                    enablests: readingCorrectionController
                                        .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "Gas Meter No.",
                                    txtController: readingCorrectionController
                                        .txtGasMeterController),
                              ),
                            ],
                          ),
                        ),
                        gapHC(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: PrimaryInputField(
                            enablests: readingCorrectionController
                                .isEditModeEnabled.value,
                            labelYn: true,
                            hintText: "Conversion Factor",
                            txtController: readingCorrectionController
                                .txtConvertionFactorController,
                          ),
                        ),
                        gapHC(10),

                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 5),
                        //   child: PhoneNumberField(
                        //     enablests: readingCorrectionController
                        //         .isEditModeEnabled.value,
                        //     labelYn: true,
                        //     hintLabel: "Mobile no.",
                        //     controller:
                        //         readingCorrectionController.txtMobileNoController,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: PrimaryInputField(
                            enablests: readingCorrectionController
                                .isEditModeEnabled.value,
                            labelYn: true,
                            hintText: "Tenant name",
                            txtController: readingCorrectionController
                                .txtTenantNameController,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text(
                                "Invoice Summary ",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(Icons.info_outline)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: PrimaryInputField(
                                  enablests: readingCorrectionController
                                      .isEditModeEnabled.value,
                                  labelYn: true,
                                  hintText: "Outstanding amount",
                                  txtController: readingCorrectionController
                                      .txtOutStantingAmtController,
                                ),
                              ),
                              gapWC(10),
                              Expanded(
                                child: PrimaryInputField(
                                  enablests: readingCorrectionController
                                      .isEditModeEnabled.value,
                                  labelYn: true,
                                  hintText: "Last Reading",
                                  txtController: readingCorrectionController
                                      .txtLastReadingController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: PrimaryInputField(
                            enablests: readingCorrectionController
                                .isEditModeEnabled.value,
                            labelYn: true,
                            hintText: "Last paid amount",
                            txtController: readingCorrectionController
                                .txtlastPaidController,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Last reading Date",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                readingCorrectionController
                                                        .lastReadingDate
                                                        .value ??
                                                    Helper.convertDateFormat2(
                                                        dateTime: DateTime.now()
                                                            .toString()),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 3),
                                        child: Bounce(
                                          onPressed: () async {
                                            // readingCorrectionController.isEditModeEnabled.value
                                            //     ? () async {
                                            var date =
                                                await showCustomDatePicker(
                                                    date: DateTime.now()
                                                        .toString());
                                          },
                                          // readingCorrectionController.contractDate.value =
                                          //     date;
                                          //   }
                                          // : () {},
                                          duration:
                                              const Duration(milliseconds: 100),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                readingCorrectionController
                                                        .isEditModeEnabled.value
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
                                gapWC(18),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Paid date",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                              Helper.convertDateFormat2(
                                                  dateTime:
                                                      readingCorrectionController
                                                              .paidDate.value ??
                                                          DateTime.now()
                                                              .toString()),
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 3),
                                      child: Bounce(
                                        onPressed: () async {
                                          // readingCorrectionController.isEditModeEnabled.value
                                          //     ? () async {
                                          var date = await showCustomDatePicker(
                                              date: DateTime.now().toString());
                                        },
                                        // readingCorrectionController.contractDate.value =
                                        //     date;
                                        //   }
                                        // : () {},
                                        duration:
                                            const Duration(milliseconds: 100),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              readingCorrectionController
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
                                )
                              ],
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Enter Current Reading ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: PrimaryInputField(
                                  textType: TextInputType.number,
                                  enablests: readingCorrectionController
                                      .isEditModeEnabled.value,
                                  labelYn: true,
                                  hintText: "Current Reading",
                                  txtController: readingCorrectionController
                                      .txtCurrentReadingController,
                                  onChanged: (value) {
                                    readingCorrectionController
                                        .fnConsumptionCalculator(value);
                                  },
                                ),
                              ),
                              // gapWC(10),
                              // Expanded(
                              //   child: PrimaryInputField(
                              //     enablests: readingCorrectionController
                              //         .isEditModeEnabled.value,
                              //     labelYn: true,
                              //     hintText: "Discount",
                              //     txtController: readingCorrectionController
                              //         .txtDiscountController,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: PrimaryInputField(
                                  enablests: readingCorrectionController
                                      .isEditModeEnabled.value,
                                  labelYn: true,
                                  hintText: "Deposit",
                                  txtController: readingCorrectionController
                                      .txtDepositController,
                                ),
                              ),
                              gapWC(10),
                              Expanded(
                                child: PrimaryInputField(
                                  enablests: readingCorrectionController
                                      .isEditModeEnabled.value,
                                  labelYn: true,
                                  hintText: "Consumption",
                                  txtController: readingCorrectionController
                                      .txtConsumptionController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: PrimaryInputField(
                            enablests: readingCorrectionController
                                .isEditModeEnabled.value,
                            labelYn: true,
                            hintText: "Unit Price",
                            txtController: readingCorrectionController
                                .txtUnitPriceController,
                          ),
                        ),
                        gapHC(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Bounce(
                                  onPressed: () {
                                    if (readingCorrectionController
                                        .isEditModeEnabled.value) {
                                      Helper.fnImageToBase64().then(
                                        (bytes) {
                                          readingCorrectionController.meterImage
                                              .value = bytes ?? Uint8List(0);
                                        },
                                      );
                                    }
                                  },
                                  duration: const Duration(milliseconds: 100),
                                  child: CustomImagePicker(
                                    label: "Meter image",
                                    image: readingCorrectionController
                                        .meterImage.value,
                                    enable: readingCorrectionController
                                        .isEditModeEnabled.value,
                                    // enable: false,
                                  ),
                                ),
                              ),
                              gapWC(10),
                              Expanded(
                                child: Bounce(
                                  onPressed: () {
                                    if (readingCorrectionController
                                        .isEditModeEnabled.value) {
                                      Helper.fnImageToBase64().then(
                                        (bytes) {
                                          readingCorrectionController.frontImage
                                              .value = bytes ?? Uint8List(0);
                                        },
                                      );
                                    }
                                  },
                                  duration: const Duration(milliseconds: 100),
                                  child: CustomImagePicker(
                                    label: "Front image",
                                    image: readingCorrectionController
                                        .frontImage.value,
                                    enable: readingCorrectionController
                                        .isEditModeEnabled.value,

                                    // enable: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        gapHC(20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: Get.width / 2,
                              child: Bounce(
                                onPressed: () {
                                  if (readingCorrectionController
                                      .isEditModeEnabled.value) {
                                    Helper.fnImageToBase64().then(
                                      (bytes) {
                                        readingCorrectionController.backImage
                                            .value = bytes ?? Uint8List(0);
                                      },
                                    );
                                  }
                                },
                                duration: const Duration(milliseconds: 100),
                                child: CustomImagePicker(
                                  label: "Back image",
                                  image: readingCorrectionController
                                      .backImage.value,
                                  enable: readingCorrectionController
                                      .isEditModeEnabled.value,

                                  // enable: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                        gapHC(10),
                        Row(
                          children: [
                            // Obx(
                            //   () =>
                            CupertinoCheckbox(
                              side: const BorderSide(width: 2),
                              value: readingCorrectionController
                                  .isFinalReading.value,
                              // value: readingCorrectionController.otherAmountReq.value,
                              onChanged: readingCorrectionController
                                      .isEditModeEnabled.value
                                  ? (_) {
                                      readingCorrectionController
                                              .isFinalReading.value =
                                          !readingCorrectionController
                                              .isFinalReading.value;
                                    }
                                  : (_) {},
                              activeColor: ThemeColors.primaryBlueColor,
                            ),
                            // ),
                            const Text("Final Reading"),
                          ],
                        ),
                        gapHC(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SignatureField(
                            isEnabled: readingCorrectionController
                                .isEditModeEnabled.value,
                            lstrSignature:
                                readingCorrectionController.lstrSignature,
                            signatureController:
                                readingCorrectionController.signatureController,
                            curveRadius: 10,
                          ),
                        ),
                        gapHC(70)
                      ],
                    ),
                  ),
                  //====================================Invoice Details===========================================
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Invoice Details ",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(Icons.info_outline),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(flex: 3, child: Container()),
                            Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text("Amount",
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                )),
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text("VAT %",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                )),
                            Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text("VAT \nAmount",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ))
                          ],
                        ),
                        Obx(() => ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount:
                                readingCorrectionController.chargeRows.length,
                            itemBuilder: (context, index) {
                              return Row(children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        readingCorrectionController
                                            .chargeRows[index].name,
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: PrimaryInputField(
                                        enablests: readingCorrectionController
                                            .isEditModeEnabled.value,
                                        hintText: "",
                                        txtRadius: 10,
                                        txtController:
                                            readingCorrectionController
                                                .chargeRows[index]
                                                .txtCurrentAmt,
                                        textType: TextInputType.number)),
                                gapWC(2),
                                Expanded(
                                    flex: 1,
                                    child: PrimaryInputField(
                                        enablests: false,
                                        hintText: "",
                                        txtRadius: 10,
                                        txtController: TextEditingController(
                                            text: readingCorrectionController
                                                .chargeRows[index].taxPerc.value
                                                .toStringAsFixed(0)),
                                        textType: TextInputType.number)),
                                gapWC(2),
                                Expanded(
                                    flex: 2,
                                    child: PrimaryInputField(
                                        enablests: false,
                                        hintText: "",
                                        txtRadius: 10,
                                        txtController: TextEditingController(
                                            text: readingCorrectionController
                                                .chargeRows[index]
                                                .currTaxAmount
                                                .value
                                                .toStringAsFixed(3)),
                                        textType: TextInputType.number))
                              ]);
                            })),
                        const Divider(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                children: [
                                  _tHead(
                                      title: "Total Amount",
                                      color: ThemeColors.primaryBlueColor),
                                  const Spacer(),
                                  Obx(() => Helper.dirhamFormatter(
                                          value: readingCorrectionController
                                              .totalCurrAmount.value
                                              .toStringAsFixed(3))
                                      // Text(readingCorrectionController
                                      //     .totalCurrAmount.value
                                      //     .toStringAsFixed(3))

                                      ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                children: [
                                  _tHead(
                                      title: "Total Tax Amount",
                                      color: ThemeColors.primaryBlueColor),
                                  const Spacer(),
                                  Obx(() => Helper.dirhamFormatter(
                                          value: readingCorrectionController
                                              .totalCurrTaxAmount.value
                                              .toStringAsFixed(3))

                                      //  Text(readingCorrectionController
                                      // .totalCurrTaxAmount.value
                                      // .toStringAsFixed(3))
                                      ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                children: [
                                  _tHead(
                                      title: "Net Amount (Inc Tax)",
                                      color: ThemeColors.primaryBlueColor),
                                  const Spacer(),

                                  Obx(() => Helper.dirhamFormatter(
                                      value: readingCorrectionController
                                          .netAmount.value
                                          .toStringAsFixed(3)))

                                  // Text(
                                  //       readingCorrectionController
                                  //           .netAmount.value
                                  //           .toStringAsFixed(3),
                                  //       style: TextStyle(fontSize: 15),
                                  //     )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        gapHC(70)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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

class _tabBar extends StatefulWidget {
  _tabBar({
    super.key,
    required this.tabController,
    required this.pageController,
  });
  final ValueNotifier<TabController> tabController;
  final PageController pageController;

  @override
  State<_tabBar> createState() => _tabBarState();
}

class _tabBarState extends State<_tabBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        child: TabBar(
          onTap: (value) {
            widget.pageController.animateToPage(value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
            // pageController.jumpToPage(value);
            widget.tabController.value.index = value;
          },
          tabAlignment: TabAlignment.start,
          splashFactory: NoSplash.splashFactory,
          controller: widget.tabController.value,
          automaticIndicatorColorAdjustment: false,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicator: BoxDecoration(
            gradient: ThemeGradient.gradient,
            borderRadius: BorderRadius.circular(30),
          ),
          tabs: [
            Tab(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  "Main Details",
                  style: TextStyle(
                    color: widget.tabController.value.index == 0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  "Invoice Details",
                  style: TextStyle(
                    color: widget.tabController.value.index == 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
