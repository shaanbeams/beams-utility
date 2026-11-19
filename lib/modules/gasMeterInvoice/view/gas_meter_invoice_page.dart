import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import 'package:gas_utility_app/modules/gasMeterReading/controller/gas_meter_controller.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/controller/gas_meter_receipt_controller.dart';
import 'package:gas_utility_app/modules/home/view/widgets/select_doc_type_widget.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/custom_date_picker.dart';
import 'package:gas_utility_app/support/common_widgets/custom_phone_input.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/common_widgets/signature_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GasMeterReadingInvoicePage extends StatefulWidget {
  GasMeterReadingInvoicePage({Key? key, this.isFromReadingPage = false})
      : super(key: key);

  final bool? isFromReadingPage;

  @override
  State<GasMeterReadingInvoicePage> createState() =>
      _GasMeterReadingInvoicePageState();
}

class _GasMeterReadingInvoicePageState extends State<GasMeterReadingInvoicePage>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<TabController> tabController;

  PageController pageController = PageController();
  GasMeterReadingInvoiceController gasMeterReadingInvoiceController =
      Get.put(GasMeterReadingInvoiceController(), permanent: true);
  GasMeterReadingReceiptController gasMeterReadingReceiptController =
      Get.put(GasMeterReadingReceiptController(), permanent: true);
  @override
  void initState() {
    super.initState();

    gasMeterReadingInvoiceController.invoiceDocType = Global.selectedDocType;

    if (widget.isFromReadingPage == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showLoadingDialog();
      });

      gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(
          mode: "LAST", docNo: "");
      fnGetGasDocMaster(docType: Global.selectedDocType).then(
        (value) {
          Global.ccCode = value[0]["CCCODE"];
          Global.divCode = value[0]["DIVCODE"];
          Global.brnCode = value[0]["BRNCODE"];
        },
      );
    }

    tabController = ValueNotifier(TabController(length: 2, vsync: this));
  }

  @override
  void dispose() {
    tabController.value.dispose(); // Dispose the TabController
    tabController.dispose();
    Get.delete<GasMeterReadingController>();
    gasMeterReadingInvoiceController.isEditModeEnabled.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Obx(
          () => gasMeterReadingInvoiceController.isEditModeEnabled.value ==
                  false
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: PrimaryButton(
                    buttonLabel: "Pay Now",
                    onPressed: () {
                      selectDoctTypeDialogueNext(prvDocType: "GREC")
                          .then((value) {
                        if (value.isNotEmpty) {
                          gasMeterReadingReceiptController
                              .fnValidateReadingReceipt(
                                  invoiceDocNo: gasMeterReadingInvoiceController
                                      .txtDocNumController.text,
                                  invoiceDocType:
                                      gasMeterReadingInvoiceController
                                          .invoiceDocType,
                                  invoiceYearCode: Global.selectedCompanyYear);
                        }
                      });
                    },
                    buttonColor: ThemeColors.primaryGreenColor,
                    buttonWidth: 200,
                  ))
              : Container(),
        ),
        bottomNavigationBar: Obx(() => CustomBottomNavBar(
              fnonFirstButtonPressed: () {
                showLoadingDialog();

                gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(
                    mode: "FIRST", docNo: "");
              },
              fnonPreviousButtonPressed: () {
                showLoadingDialog();

                gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(
                    mode: "PREVIOUS",
                    docNo: gasMeterReadingInvoiceController
                        .txtDocNumController.text);
              },
              fnonLastButtonPressed: () {
                showLoadingDialog();

                gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(
                    mode: "LAST", docNo: "");
              },
              fnonNextButtonPressed: () {
                showLoadingDialog();

                gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(
                    mode: "NEXT",
                    docNo: gasMeterReadingInvoiceController
                        .txtDocNumController.text);
              },
              fnonSaveButtonPressed: () {
                gasMeterReadingInvoiceController.fnSaveInvoiceReading();
              },
              fnonCancelPressed: widget.isFromReadingPage == true
                  ? () {
                      Get.back();
                    }
                  : () {
                      gasMeterReadingInvoiceController.isEditModeEnabled.value =
                          false;
                    },
              fnonAddButtonPressed: () {},
              //  () {
              //   contractController.isEditModeEnabled.value = !contractController.isEditModeEnabled.value;
              // },

              isEditIconEnabled:
                  gasMeterReadingInvoiceController.isEditModeEnabled.value,
            )),
        body: Column(
          children: [
            Container(
              width: double.infinity,
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
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Bounce(
                              onPressed: () {
                                Get.back();
                              },
                              duration: const Duration(milliseconds: 100),
                              child: const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: ThemeColors.white,
                                  )),
                            ),
                            Image.asset(
                              "assets/icons/meter invoice.PNG",
                              height: 38,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Gas Meter Invoice",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: ThemeColors.white,
                                    fontSize: 20,
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
                                  label: "Gas Meter Invoice Doc No",
                                  labelYn: true,
                                  enablests: true,
                                  readonly: true,
                                  hintLabel: "Gas Meter Invoice Doc No",
                                  controller: gasMeterReadingInvoiceController
                                      .txtDocNumController,
                                  onSearchTap: () {
                                    if (gasMeterReadingInvoiceController
                                            .isEditModeEnabled.value ==
                                        false) {
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
                                          gasMeterReadingInvoiceController
                                              .txtDocNumController
                                              .text = value["DOCNO"];
                                          gasMeterReadingInvoiceController
                                              .fnGetLastGasMeterInvoice(
                                                  mode: "VIEW",
                                                  docNo: value["DOCNO"]);
                                          Get.back();
                                        },
                                        tableName: "GINV",
                                        filter: [],
                                        searchColumn: searchColumn,
                                      ));
                                    }
                                  },
                                )

                                // CustomSearchField(
                                //   labelColor: Colors.white,
                                //   label: "Request Doc No",
                                //   labelYn: true,
                                //   hintLabel: "Request Doc No",
                                //   controller: gasMeterReadingInvoiceController
                                //       .txtDocNumController,
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

                                  Obx(() => gasMeterReadingInvoiceController
                                          .isEditModeEnabled.value
                                      ? _tValue(
                                          value: Helper.convertDateFormat2(
                                              dateTime:
                                                  DateTime.now().toString()))
                                      : _tValue(
                                          value: Helper.convertDateFormat1(
                                              dateTime:
                                                  gasMeterReadingInvoiceController
                                                          .lastDocdate.value ??
                                                      "01/01/2000 12:00:00 AM")))
                                  // _tValue(
                                  //     value: Helper.convertDateFormat2(
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
              ),
            ),
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: tabController,
                    builder: (context, val, child) {
                      return _tabBar(
                        tabController: tabController,
                        pageController: pageController,
                      );
                    }),
                const Spacer(),
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
                                  enablests: false,
                                  // enablests: gasMeterReadingInvoiceController.isEditModeEnabled.value,
                                  labelYn: true,
                                  label: "building code",
                                  hintLabel: "building code",

                                  hintSize: 11,
                                  // onSearchTap: () {
                                  //   // if (contractController.isEditModeEnabled.value) {
                                  //   List searchColumn = [
                                  //     {
                                  //       "showItem": true,
                                  //       "columnName": "BUILDING_CODE",
                                  //       "showName": "Building Code"
                                  //     },
                                  //     {
                                  //       "showItem": true,
                                  //       "columnName": "DESCP",
                                  //       "showName": "Description"
                                  //     },
                                  //   ];
                                  //   Get.dialog(
                                  //     barrierDismissible: false,
                                  //     lookUpDialogue(
                                  //       tableName: "GBUILDINGMASTER",
                                  //       callBackFn: (value) {
                                  //         gasMeterReadingInvoiceController
                                  //             .txtBuildingCodeController
                                  //             .text = value["BUILDING_CODE"];
                                  //         gasMeterReadingInvoiceController
                                  //             .txtBuildingNameController
                                  //             .text = value["DESCP"];

                                  //         Get.back();
                                  //       },
                                  //       filter: [],
                                  //       searchColumn: searchColumn,
                                  //     ),
                                  //   );
                                  //   // }
                                  // },
                                  controller: gasMeterReadingInvoiceController
                                      .txtBuildingCodeController,
                                ),
                              ),
                              Expanded(
                                child: CustomSearchField(
                                  labelColor: ThemeColors.primaryBlueColor,
                                  borderColor: Colors.grey.withOpacity(0.8),
                                  fieldColor: ThemeColors.white,
                                  enablests: false,

                                  // enablests: gasMeterReadingInvoiceController.isEditModeEnabled.value,

                                  labelYn: true,
                                  label: "Apartment code",
                                  hintLabel: "Apartment code",

                                  hintSize: 11,
                                  // onSearchTap: () {
                                  //   // if (contractController.isEditModeEnabled.value) {
                                  //   List searchColumn = [
                                  //     {
                                  //       "showItem": true,
                                  //       "columnName": "APARTMENT_CODE",
                                  //       "showName": " Code"
                                  //     },
                                  //     // {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                  //   ];
                                  //   Get.dialog(
                                  //     barrierDismissible: false,
                                  //     lookUpDialogue(
                                  //       tableName: "GAPARTMENTMASTER",
                                  //       callBackFn: (value) {
                                  //         gasMeterReadingInvoiceController
                                  //             .txtApartmentCodeController
                                  //             .text = value["APARTMENT_CODE"];

                                  //         Get.back();
                                  //         // gasMeterReadingInvoiceController
                                  //         //     .fnValidateApartment();
                                  //       },
                                  //       filter: [
                                  //         {
                                  //           'Column': "BUILDING_CODE",
                                  //           'Operator': '=',
                                  //           'Value':
                                  //               gasMeterReadingInvoiceController
                                  //                   .txtBuildingCodeController
                                  //                   .text,
                                  //           'JoinType': 'AND'
                                  //         },
                                  //       ],
                                  //       searchColumn: searchColumn,
                                  //     ),
                                  //   );
                                  //   // }
                                  // },
                                  controller: gasMeterReadingInvoiceController
                                      .txtApartmentCodeController,
                                ),
                              ),
                            ],
                          ),
                          gapHC(10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: PrimaryInputField(
                              enablests: false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintText: "Building Name",
                              txtController: gasMeterReadingInvoiceController
                                  .txtBuildingNameController,
                            ),
                          ),
                          gapHC(10),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 5),
                          //   child: PrimaryInputField(
                          //     // enablests: gasMeterReadingInvoiceController.isEditModeEnabled.value,
                          //     labelYn: true,
                          //     hintText: "Gas Meter No.",
                          //     // txtController: gasMeterReadingInvoiceController.txtGasMeterNoController,
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 5),
                          //   child: PrimaryInputField(
                          //       enablests: gasMeterReadingInvoiceController
                          //           .isEditModeEnabled.value,
                          //       labelYn: true,
                          //       hintText: "Gas Meter No.",
                          //       txtController: gasMeterReadingInvoiceController
                          //           .txtGasMeterController),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: PrimaryInputField(
                                    enablests: false,
                                    // enablests: gasMeterReadingInvoiceController
                                    //     .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "ContractNo",
                                    txtController:
                                        gasMeterReadingInvoiceController
                                            .txtContractNoController,
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  child: PrimaryInputField(
                                      enablests: false,
                                      // enablests: gasMeterReadingInvoiceController
                                      //     .isEditModeEnabled.value,
                                      labelYn: true,
                                      hintText: "Gas Meter No.",
                                      txtController:
                                          gasMeterReadingInvoiceController
                                              .txtGasMeterController),
                                ),
                              ],
                            ),
                          ),
                          gapHC(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: PrimaryInputField(
                              enablests: false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintText: "Conversion Factor",
                              txtController: gasMeterReadingInvoiceController
                                  .txtConvertionFactorController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: PhoneNumberField(
                              enablests: false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintLabel: "Mobile no.",
                              controller: gasMeterReadingInvoiceController
                                  .txtMobileNoController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: PrimaryInputField(
                              enablests: false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintText: "Tenant name",
                              txtController: gasMeterReadingInvoiceController
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
                                    enablests: false,
                                    // enablests: gasMeterReadingInvoiceController
                                    //     .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "Outstanding amount",
                                    txtController:
                                        gasMeterReadingInvoiceController
                                            .txtOutStantingAmtController,
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  child: PrimaryInputField(
                                    enablests: false,
                                    // enablests: gasMeterReadingInvoiceController
                                    //     .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "Last Reading",
                                    txtController:
                                        gasMeterReadingInvoiceController
                                            .txtLastReadingController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: PrimaryInputField(
                              enablests: false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintText: "Last paid amount",
                              txtController: gasMeterReadingInvoiceController
                                  .txtlastPaidController,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                
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
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                  gasMeterReadingInvoiceController
                                                          .lastReadingDate
                                                          .value ??
                                                      Helper.convertDateFormat2(
                                                          dateTime:
                                                              DateTime.now()
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
                                            onPressed: () {
                                              // gasMeterReadingInvoiceController.isEditModeEnabled.value
                                              //     ? () async {
                                              // var date =
                                              // await showCustomDatePicker(
                                              //     date: DateTime.now()
                                              //         .toString());
                                            },
                                            // gasMeterReadingInvoiceController.contractDate.value =
                                            //     date;
                                            //   }
                                            // : () {},
                                            duration: const Duration(
                                                milliseconds: 100),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  gasMeterReadingInvoiceController
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
                                                        gasMeterReadingInvoiceController
                                                                .paidDate
                                                                .value ??
                                                            DateTime.now()
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
                                            // gasMeterReadingInvoiceController.isEditModeEnabled.value
                                            // //     ? () async {
                                            // var date =
                                            //     await showCustomDatePicker(
                                            //         date: DateTime.now()
                                            //             .toString());
                                          },
                                          // gasMeterReadingInvoiceController.contractDate.value =
                                          //     date;
                                          //   }
                                          // : () {},
                                          duration:
                                              const Duration(milliseconds: 100),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                gasMeterReadingInvoiceController
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
                                           enablests:false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "Current Reading",
                                    txtController:
                                        gasMeterReadingInvoiceController
                                            .txtCurrentReadingController,
                                    onChanged: (value) {
                                      gasMeterReadingInvoiceController
                                          .fnConsumptionCalculator(value);
                                    },
                                  ),
                                ),
                                // gapWC(10),
                                // Expanded(
                                //   child: PrimaryInputField(
                                //     enablests: gasMeterReadingInvoiceController
                                //         .isEditModeEnabled.value,
                                //     labelYn: true,
                                //     hintText: "Discount",
                                //     txtController: gasMeterReadingInvoiceController
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
                                          enablests:false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "Deposit",
                                    txtController:
                                        gasMeterReadingInvoiceController
                                            .txtDepositController,
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  child: PrimaryInputField(
                                      enablests:false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "Consumption",
                                    txtController:
                                        gasMeterReadingInvoiceController
                                            .txtConsumptionController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: PrimaryInputField(
                                  enablests:false,
                              // enablests: gasMeterReadingInvoiceController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintText: "Unit Price",
                              txtController: gasMeterReadingInvoiceController
                                  .txtUnitPriceController,
                            ),
                          ),

                          gapHC(10),
                          Row(
                            children: [
                              // Obx(
                              //   () =>
                              CupertinoCheckbox(
                                side: const BorderSide(width: 2),
                                value: gasMeterReadingInvoiceController
                                    .isFinalReading.value,
                                // value: gasMeterReadingInvoiceController.otherAmountReq.value,
                                onChanged:
                                //  gasMeterReadingInvoiceController
                                //         .isEditModeEnabled.value
                                //     ? (_) {
                                //         gasMeterReadingInvoiceController
                                //                 .isFinalReading.value =
                                //             !gasMeterReadingInvoiceController
                                //                 .isFinalReading.value;
                                //       }
                                    // :                                                                                                                                                                                                                                    ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                    (_) {},
                                activeColor: ThemeColors.primaryBlueColor,
                              ),
                              // ),
                              const Text("Final Reading"),
                            ],
                          ),
                          gapHC(10),

                          Obx(() => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SignatureField(
                                  isEnabled: gasMeterReadingInvoiceController
                                      .isEditModeEnabled.value,
                                  lstrSignature:
                                      gasMeterReadingInvoiceController
                                          .lstrSignature,
                                  signatureController:
                                      gasMeterReadingInvoiceController
                                          .signatureController,
                                  curveRadius: 10,
                                ),
                              )),
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
                              itemCount: gasMeterReadingInvoiceController
                                  .chargeRows.length,
                              itemBuilder: (context, index) {
                                return Row(children: [
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: Text(
                                          gasMeterReadingInvoiceController
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
                                          enablests:
                                              gasMeterReadingInvoiceController
                                                  .isEditModeEnabled.value,
                                          hintText: "",
                                          txtRadius: 10,
                                          txtController:
                                              gasMeterReadingInvoiceController
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
                                              text:
                                                  gasMeterReadingInvoiceController
                                                      .chargeRows[index]
                                                      .taxPerc
                                                      .value
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
                                              text:
                                                  gasMeterReadingInvoiceController
                                                      .chargeRows[index]
                                                      .currTaxAmount
                                                      .value
                                                      .toString()),
                                          textType: TextInputType.number))
                                ]);
                              })),
                          const Divider(),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                child: Row(
                                  children: [
                                    _tHead(
                                        title: "Total Amount",
                                        color: ThemeColors.primaryBlueColor),
                                    const Spacer(),
                                    Obx(() => Text(
                                        gasMeterReadingInvoiceController
                                            .totalCurrAmount.value
                                            .toString())),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                child: Row(
                                  children: [
                                    _tHead(
                                        title: "Total Tax Amount",
                                        color: ThemeColors.primaryBlueColor),
                                    const Spacer(),
                                    Obx(() => Text(
                                        gasMeterReadingInvoiceController
                                            .totalCurrTaxAmount.value
                                            .toString())),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                child: Row(
                                  children: [
                                    _tHead(
                                        title: "Net Amount (Inc Tax)",
                                        color: ThemeColors.primaryBlueColor),
                                    const Spacer(),
                                    Obx(() => Text(
                                          gasMeterReadingInvoiceController
                                              .netAmount.value
                                              .toStringAsFixed(3),
                                          style: TextStyle(fontSize: 15),
                                        )),
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

class _amountDetailsItem extends StatelessWidget {
  _amountDetailsItem({
    super.key,
    required this.headValue,
    required this.amountValueController,
    required this.vatAmountController,
    required this.vatPercController,
  });

  final String headValue;
  final TextEditingController amountValueController,
      vatAmountController,
      vatPercController;
  GasMeterReadingInvoiceController gasMeterReadingInvoiceController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              headValue,
              style: GoogleFonts.poppins(
                color: ThemeColors.black,
                fontSize: 12,
              ),
            ),
          )),
      Expanded(
          flex: 2,
          child: PrimaryInputField(
              // enablests: contractController.isEditModeEnabled.value,
              hintText: "",
              txtRadius: 10,
              txtController: amountValueController,
              textType: TextInputType.number)),
      gapWC(2),
      Expanded(
          flex: 1,
          child: PrimaryInputField(
              // enablests: contractController.isEditModeEnabled.value,
              hintText: "",
              txtRadius: 10,
              txtController: vatAmountController,
              textType: TextInputType.number)),
      gapWC(2),
      Expanded(
          flex: 2,
          child: PrimaryInputField(
              // enablests: contractController.isEditModeEnabled.value,
              hintText: "",
              txtRadius: 10,
              txtController: vatAmountController,
              textType: TextInputType.number))
    ]);
  }
}
