import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/controller/gas_meter_receipt_controller.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/custom_date_picker.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GasMeterReadingReceiptPage extends StatefulWidget {
  GasMeterReadingReceiptPage({super.key, this.isFromInvoicePage = false});

  final bool? isFromInvoicePage;

  @override
  State<GasMeterReadingReceiptPage> createState() =>
      _GasMeterReadingReceiptPageState();
}

class _GasMeterReadingReceiptPageState
    extends State<GasMeterReadingReceiptPage> {
  GasMeterReadingReceiptController gasMeterReadingReceiptController =
      Get.put(GasMeterReadingReceiptController());
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = gasMeterReadingReceiptController.selectedPaymentMode.value;

    if (widget.isFromInvoicePage == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showLoadingDialog();
      });
      gasMeterReadingReceiptController.fnGetLastGasMeterReceipt(
          docNo: "", mode: "LAST");
      // if (Get.isDialogOpen == true) {
      //   Get.back();
      // }
    }
  }

  @override
  void dispose() {
    gasMeterReadingReceiptController.isEditModeEnabled.value = false;
    Get.delete<GasMeterReadingInvoiceController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: Obx(() => CustomBottomNavBar(
              fnonFirstButtonPressed: () {
                gasMeterReadingReceiptController.fnGetLastGasMeterReceipt(
                    mode: "FIRST", docNo: "");
              },
              fnonPreviousButtonPressed: () {
                gasMeterReadingReceiptController.fnGetLastGasMeterReceipt(
                    mode: "PREVIOUS",
                    docNo: gasMeterReadingReceiptController
                        .txtDocNumController.text);
              },
              fnonLastButtonPressed: () {
                gasMeterReadingReceiptController.fnGetLastGasMeterReceipt(
                    mode: "LAST", docNo: "");
              },
              fnonNextButtonPressed: () {
                gasMeterReadingReceiptController.fnGetLastGasMeterReceipt(
                    mode: "NEXT",
                    docNo: gasMeterReadingReceiptController
                        .txtDocNumController.text);
              },
              fnonSaveButtonPressed: () {
                gasMeterReadingReceiptController.fnSaveMeterReceipt();
              },
              fnonCancelPressed: widget.isFromInvoicePage == true
                  ? () {
                      Get.back();
                    }
                  : () {
                      gasMeterReadingReceiptController.isEditModeEnabled.value =
                          false;
                    },
              fnonAddButtonPressed: () {},
              isEditIconEnabled:
                  gasMeterReadingReceiptController.isEditModeEnabled.value,
            )),
        body: Obx(
          () => Column(
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
                    padding: const EdgeInsets.fromLTRB(
                        16, 8, 16, 12), // Reduced vertical padding

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
                                "assets/icons/receipt.png",
                                height: 38,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Gas Meter Receipt",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 18,
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
                                    label: "Gas Meter Receipt Doc No",
                                    labelYn: true,
                                    enablests: true,
                                    readonly: true,
                                    hintLabel: "Gas Meter Receipt Doc No",
                                    controller: gasMeterReadingReceiptController
                                        .txtDocNumController,
                                    onSearchTap: () {
                                      if (gasMeterReadingReceiptController
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
                                            gasMeterReadingReceiptController
                                                .txtDocNumController
                                                .text = value["DOCNO"];
                                            gasMeterReadingReceiptController
                                                .fnGetLastGasMeterReceipt(
                                                    mode: "VIEW",
                                                    docNo: value["DOCNO"]);
                                            Get.back();
                                          },
                                          tableName: "GREC",
                                          filter: [],
                                          searchColumn: searchColumn,
                                        ));
                                      }
                                    },
                                  )

                                  //  CustomSearchField(
                                  //   labelColor: Colors.white,
                                  //   label: "Request Doc No",
                                  //   labelYn: true,
                                  //   hintLabel: "Request Doc No",
                                  //   controller: gasMeterReadingReceiptController
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
                                    _tValue(
                                        value: Helper.convertDateFormat2(
                                            dateTime:
                                                DateTime.now().toString())),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                            Spacer(),
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
                       
                       
                        fieldColor: ThemeColors.white,
                        enablests: false,
                        // enablests: gasMeterReadingReceiptController.isEditModeEnabled.value,
                        labelYn: true,
                        label: "Contract No",
                        hintLabel: "Contract No",
                        // fieldColor: ThemeColors.primaryBlueColor,
                        hintSize: 11,
                        onSearchTap: () {
                          // if (contractController.isEditModeEnabled.value) {
                          // List searchColumn = [
                          //   {
                          //     "showItem": true,
                          //     "columnName": "BUILDING_CODE",
                          //     "showName": "Building Code"
                          //   },
                          //   {
                          //     "showItem": true,
                          //     "columnName": "DESCP",
                          //     "showName": "Description"
                          //   },
                          // ];
                          // Get.dialog(
                          //   barrierDismissible: false,
                          //   lookUpDialogue(
                          //     tableName: "GBUILDINGMASTER",
                          //     callBackFn: (value) {
                          //       gasMeterReadingReceiptController
                          //           .txtBuildingCodeController
                          //           .text = value["BUILDING_CODE"];
                          //       gasMeterReadingReceiptController
                          //           .txtBuildingNameController
                          //           .text = value["DESCP"];

                          //       Get.back();
                          //     },
                          //     filter: [],
                          //     searchColumn: searchColumn,
                          //   ),
                          // );
                          // }
                        },
                        controller: gasMeterReadingReceiptController
                            .txtContractNoController,
                      ),
                      gapHC(5),
                      Row(
                        children: [
                          Expanded(
                            child: CustomSearchField(
                              labelColor: ThemeColors.primaryBlueColor,
                              borderColor: Colors.grey.withOpacity(0.8),
                              fieldColor: ThemeColors.white,
                              enablests: false,

                              // enablests: gasMeterReadingReceiptController.isEditModeEnabled.value,
                              labelYn: true,
                              label: "Building code",
                              hintLabel: "building code",

                              hintSize: 11,
                              onSearchTap: () {
                                // if (contractController.isEditModeEnabled.value) {
                                // List searchColumn = [
                                //   {
                                //     "showItem": true,
                                //     "columnName": "BUILDING_CODE",
                                //     "showName": "Building Code"
                                //   },
                                //   {
                                //     "showItem": true,
                                //     "columnName": "DESCP",
                                //     "showName": "Description"
                                //   },
                                // ];
                                // Get.dialog(
                                //   barrierDismissible: false,
                                //   lookUpDialogue(
                                //     tableName: "GBUILDINGMASTER",
                                //     callBackFn: (value) {
                                //       gasMeterReadingReceiptController
                                //           .txtBuildingCodeController
                                //           .text = value["BUILDING_CODE"];
                                //       gasMeterReadingReceiptController
                                //           .txtBuildingNameController
                                //           .text = value["DESCP"];

                                //       Get.back();
                                //     },
                                //     filter: [],
                                //     searchColumn: searchColumn,
                                //   ),
                                // );
                                // }
                              },
                              controller: gasMeterReadingReceiptController
                                  .txtBuildingCodeController,
                            ),
                          ),
                          Expanded(
                            child: CustomSearchField(
                              labelColor: ThemeColors.primaryBlueColor,
                              borderColor: Colors.grey.withOpacity(0.8),
                              fieldColor: ThemeColors.white,
                              enablests: false,

                              // enablests: gasMeterReadingReceiptController.isEditModeEnabled.value,

                              labelYn: true,
                              label: "Appartment code",
                              hintLabel: "Appartment code",

                              hintSize: 11,
                              onSearchTap: () {
                                // if (contractController.isEditModeEnabled.value) {
                                // List searchColumn = [
                                //   {
                                //     "showItem": true,
                                //     "columnName": "APARTMENT_CODE",
                                //     "showName": " Code"
                                //   },
                                //   // {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                // ];
                                // Get.dialog(
                                //   barrierDismissible: false,
                                //   lookUpDialogue(
                                //     tableName: "GAPARTMENTMASTER",
                                //     callBackFn: (value) {
                                //       gasMeterReadingReceiptController
                                //           .txtApartmentCodeController
                                //           .text = value["APARTMENT_CODE"];

                                //       // Get.back();
                                //     },
                                //     filter: [
                                //       {
                                //         'Column': "BUILDING_CODE",
                                //         'Operator': '=',
                                //         'Value':
                                //             gasMeterReadingReceiptController
                                //                 .txtBuildingCodeController.text,
                                //         'JoinType': 'AND'
                                //       },
                                //     ],
                                //     searchColumn: searchColumn,
                                //   ),
                                // );
                                // }
                              },
                              controller: gasMeterReadingReceiptController
                                  .txtApartmentCodeController,
                            ),
                          ),
                        ],
                      ),
                      gapHC(5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: gasMeterReadingReceiptController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Building Name",
                          txtController: gasMeterReadingReceiptController
                              .txtBuildingNameController,
                        ),
                      ),
                      gapHC(5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,

                          // enablests: gasMeterReadingReceiptController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Tenant Name",
                          txtController: gasMeterReadingReceiptController
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: SizedBox(
                            child: PrimaryInputField(
                              enablests: false,

                              // enablests: gasMeterReadingReceiptController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintText: "Invoice No",
                              txtController: gasMeterReadingReceiptController
                                  .txtInvoiceNoController,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: SizedBox(
                            child: PrimaryInputField(
                              enablests: false,

                              // enablests: gasMeterReadingReceiptController
                              //     .isEditModeEnabled.value,
                              labelYn: true,
                              hintText: "Last invoice",
                              txtController: gasMeterReadingReceiptController
                                  .txtLastInvoice,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
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
                                        gasMeterReadingReceiptController
                                                        .lastReadingDate
                                                        .value !=
                                                    null &&
                                                gasMeterReadingReceiptController
                                                    .lastReadingDate
                                                    .value!
                                                    .isNotEmpty
                                            ? gasMeterReadingReceiptController
                                                .lastReadingDate.value
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
                                    //         gasMeterReadingReceiptController
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
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 10, right: 3),
                            //   child: Bounce(
                            //     onPressed: () async {
                            //       // gasMeterReadingReceiptController.isEditModeEnabled.value
                            //       //     ? () async {
                            //     //   var date = await showCustomDatePicker(
                            //     //       date: DateTime.now().toString());
                            //     // },
                            //     // gasMeterReadingReceiptController.contractDate.value =
                            //     //     date;
                            //     //   }
                            //     // : () {},
                            //     duration: const Duration(milliseconds: 100),
                            //     child: CircleAvatar(
                            //       radius: 20,
                            //       backgroundColor:
                            //           gasMeterReadingReceiptController
                            //                   .isEditModeEnabled.value
                            //               ? ThemeColors.primaryBlueColor
                            //               : ThemeColors.grey,
                            //       child: Icon(
                            //         Icons.calendar_month_outlined,
                            //         color: ThemeColors.white,
                            //       ),
                            //     ),
                            //   ),
                            // )
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

                                // enablests: gasMeterReadingReceiptController
                                //     .isEditModeEnabled.value,
                                labelYn: true,
                                hintText: "Invoice amount",
                                txtController: gasMeterReadingReceiptController
                                    .txtInvoiceAmount,
                              ),
                            ),
                            gapWC(10),
                            Expanded(
                              child: PrimaryInputField(
                                 
                                enablests: false,

                                // enablests: gasMeterReadingReceiptController
                                //     .isEditModeEnabled.value,
                                labelYn: true,
                                hintText: "Paid Amount",
                                txtController: gasMeterReadingReceiptController
                                    .txtLastPaidController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      gapHC(5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                         
                          enablests: false,
                          // enablests: gasMeterReadingReceiptController
                          //     .isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "OutStanding amount",
                          txtController: gasMeterReadingReceiptController
                              .txtOutStandingAmtController,
                          textType: TextInputType.number,
                        ),
                      ),
                      gapHC(5),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          color: Colors.grey.withOpacity(0.5),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DottedBorder(
                          dashPattern: [6, 3],
                          strokeWidth: 2,
                          color: ThemeColors.grey,
                          radius: Radius.circular(30),
                          padding: EdgeInsets.all(6),
                          borderType: BorderType.RRect,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: PrimaryInputField(
                                    // gasMeterReadingReceiptController
                                    //     .isEditModeEnabled.value,
                                    enablests: gasMeterReadingReceiptController
                                        .isEditModeEnabled.value,
                                    labelYn: true,
                                    hintText: "Received amount",
                                    txtController: gasMeterReadingReceiptController
                                        .txtReceivedAmtController,
                                    textType: TextInputType.number,
                                    autoFocus: true,
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
                                SizedBox(
                                  height: 30,
                                  child: RadioMenuButton(
                                    style: const ButtonStyle(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    value: "CASH",
                                    onChanged: gasMeterReadingReceiptController
                                                .isEditModeEnabled.value ==
                                            true
                                        ? (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                              gasMeterReadingReceiptController
                                                  .txtCreditCard
                                                  .clear();
                                              gasMeterReadingReceiptController
                                                  .selectedPaymentMode
                                                  .value = "CASH";
                                            });
                                          }
                                        : (s) {},
                                    groupValue: gasMeterReadingReceiptController
                                        .selectedPaymentMode.value,
                                    child: const Text("Cash"),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: RadioMenuButton(
                                    style: const ButtonStyle(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    value: "CREDITCARD",
                                    onChanged: gasMeterReadingReceiptController
                                                .isEditModeEnabled.value ==
                                            true
                                        ? (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                              gasMeterReadingReceiptController
                                                  .selectedPaymentMode
                                                  .value = "CREDITCARD";
                                            });
                                          }
                                        : (_) {},
                                    groupValue: gasMeterReadingReceiptController
                                        .selectedPaymentMode.value,
                                    child: const Text("Credit card"),
                                  ),
                                ),
                                Visibility(
                                  visible: selectedOption == "CREDITCARD" ||
                                      gasMeterReadingReceiptController
                                              .selectedPaymentMode.value ==
                                          "CREDITCARD",
                                  child: CustomSearchField(
                                    enablests: 
                                    gasMeterReadingReceiptController
                                        .isEditModeEnabled.value,
                                    labelColor: ThemeColors.primaryBlueColor,
                                    borderColor: Colors.black,
                                    fieldColor: ThemeColors.white,
                                    readonly:true,
                                    label: "Credit Card",
                                    labelYn: true,
                                    hintLabel: "Credit Card",
                                    
                                                    
                                    hintSize: 11,
                                    onSearchTap: () {
                                      if (gasMeterReadingReceiptController
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
                                                gasMeterReadingReceiptController
                                                        .txtCreditCard.text =
                                                    value["CODE"].toString();
                                              }
                                            },
                                            searchColumn: searchColumn,
                                          ),
                                        );
                                      }
                                    },
                                    controller: gasMeterReadingReceiptController
                                        .txtCreditCard,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      gapHC(70)
                    ],
                  ),
                ),
              )
            ],
          ),
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
