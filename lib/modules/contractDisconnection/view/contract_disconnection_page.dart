import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/contractDisconnection/controller/contract_disconnection_controller.dart';
import 'package:gas_utility_app/modules/contractDisconnection/view/widgets/tab_bar.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractDisconnectionPage extends StatefulWidget {
  ContractDisconnectionPage({Key? key, this.isFromReadingPage = false})
      : super(key: key);

  final bool? isFromReadingPage;

  @override
  State<ContractDisconnectionPage> createState() =>
      _ContractDisconnectionPageState();
}

class _ContractDisconnectionPageState extends State<ContractDisconnectionPage>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<TabController> tabController;

  PageController pageController = PageController();

  ContractDisconnectionController contractDisconnectionController =
      Get.put(ContractDisconnectionController(), permanent: true);
  // GasMeterReadingReceiptController gasMeterReadingReceiptController =
  //     Get.put(GasMeterReadingReceiptController(), permanent: true);
  // contractDisconnectionController contractDisconnectionController =
  //     Get.put(contractDisconnectionController());
  @override
  void initState() {
    super.initState();

    // gasMeterReadingInvoiceController.invoiceDocType = Global.selectedDocType;

    if (widget.isFromReadingPage == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showLoadingDialog();
      });
    }

    contractDisconnectionController.fnGetLastContractDisconnection(
        mode: "LAST", docNo: "");
    fnGetGasDocMaster(docType: Global.selectedDocType).then(
      (value) {
        Global.ccCode = value[0]["CCCODE"];
        Global.divCode = value[0]["DIVCODE"];
        Global.brnCode = value[0]["BRNCODE"];
      },
    );
    // }

    contractDisconnectionController.getDeductionCharges();

    tabController = ValueNotifier(TabController(length: 3, vsync: this));
  }

  @override
  void dispose() {
    tabController.value.dispose();
    tabController.dispose();
    contractDisconnectionController.isEditModeEnabled.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // floatingActionButton: Obx(
        //   () => gasMeterReadingInvoiceController.isEditModeEnabled.value ==
        //           false
        //       ? Padding(
        //           padding: const EdgeInsets.only(bottom: 70),
        //           child: PrimaryButton(
        //             buttonLabel: "Pay Now",
        //             onPressed: () {
        //               selectDoctTypeDialogueNext(prvDocType: "GREC")
        //                   .then((value) {
        //                 if (value.isNotEmpty) {
        //                   gasMeterReadingReceiptController
        //                       .fnValidateReadingReceipt(
        //                           invoiceDocNo: gasMeterReadingInvoiceController
        //                               .txtDocNumController.text,
        //                           invoiceDocType:
        //                               gasMeterReadingInvoiceController
        //                                   .invoiceDocType,
        //                           invoiceYearCode: Global.selectedCompanyYear);
        //                 }
        //               });
        //             },
        //             buttonColor: ThemeColors.primaryGreenColor,
        //             buttonWidth: 200,
        //           ))
        //       : Container(),
        // ),
        bottomNavigationBar: Obx(() => CustomBottomNavBar(
              fnonFirstButtonPressed: () {
                showLoadingDialog();

                contractDisconnectionController.fnGetLastContractDisconnection(
                    mode: "FIRST", docNo: "");
              },
              fnonPreviousButtonPressed: () {
                showLoadingDialog();

                contractDisconnectionController.fnGetLastContractDisconnection(
                    mode: "PREVIOUS",
                    docNo: contractDisconnectionController
                        .txtDocNumController.text);
              },
              fnonLastButtonPressed: () {
                showLoadingDialog();

                contractDisconnectionController.fnGetLastContractDisconnection(
                    mode: "LAST", docNo: "");
              },
              fnonNextButtonPressed: () {
                showLoadingDialog();
                contractDisconnectionController.fnGetLastContractDisconnection(
                    mode: "NEXT",
                    docNo: contractDisconnectionController
                        .txtDocNumController.text);
              },
              fnonSaveButtonPressed: () {
                contractDisconnectionController.fnSaveContractDisconnection();
              },
              fnonCancelPressed: () {
                contractDisconnectionController.isEditModeEnabled.value = false;
                contractDisconnectionController.fnClear();
                contractDisconnectionController.fnGetLastContractDisconnection(
                    mode: "LAST", docNo: "");
              },
              fnonAddButtonPressed: () {
                contractDisconnectionController.fnClear();

                contractDisconnectionController.isEditModeEnabled.value =
                    !contractDisconnectionController.isEditModeEnabled.value;
              },
              isAddButtonRequired: true,
              isEditIconEnabled:
                  contractDisconnectionController.isEditModeEnabled.value,
              netAmountisRequired: true,
              netAmount: contractDisconnectionController.totalNetPayable.value
                  .toString(),
            )),
        body: Column(
          children: [
            /////////////////header//////////////
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
                          "assets/icons/discoonection.PNG",
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Contract \n Disconnection",
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
                          flex: 3,//
                          
                          child:CustomSearchField(
                            labelColor: Colors.white,
                            label: "Request Doc No",
                            labelYn: true,
                            hintLabel: "Request Doc No",
                            controller:
                                contractDisconnectionController.txtDocNumController,
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
                                  contractDisconnectionController.txtDocNumController
                                      .text = value["DOCNO"];
                                  contractDisconnectionController
                                      .fnGetLastContractDisconnection(
                                          mode: "VIEW", docNo: value["DOCNO"]);
                                  Get.back();
                                },
                                tableName: "GGASCONTRACTREFUND",
                                filter: [],
                                searchColumn: searchColumn,
                              ));
                            },
                          )
                          
                          //  CustomSearchField(
                          //   labelColor: Colors.white,
                          //   label: "Request Doc No",
                          //   labelYn: true,
                          //   hintLabel: "Request Doc No",
                          //   controller: contractDisconnectionController
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

                              Obx(() => contractDisconnectionController
                                      .isEditModeEnabled.value
                                  ? _tValue(
                                      value: Helper.convertDateFormat2(
                                          dateTime: DateTime.now().toString()))
                                  : _tValue(
                                      value: Helper.convertDateFormat1(
                                          dateTime:
                                              contractDisconnectionController
                                                      .docdate.value ??
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

            ////////////tabs////////////////
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: tabController,
                    builder: (context, val, child) {
                      return CustomTabBar(
                        tabController: tabController,
                        pageController: pageController,
                      );
                    }),
              ],
            ),

            //////////////tab view///////////////////
            Expanded(
              child: PageView(
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
                  //////////////////////////main/////////////////////
                  SingleChildScrollView(
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
                            enablests: contractDisconnectionController
                                .isEditModeEnabled.value,
                            labelYn: true,
                            label: "Contract No",
                            hintLabel: "Contract No",
                            
                            hintSize: 11,
                            onSearchTap: () {
                              if (contractDisconnectionController
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
                                    tableName: "GGASCONTRACT",
                                    callBackFn: (value) {
                                      Get.back();

                                      contractDisconnectionController
                                          .fnValidateContractDisconnection(
                                              contractNo: value["CONTRACT_NO"]);

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
                            controller: contractDisconnectionController
                                .txtContractNoController,
                          ),
                          gapHC(10),
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
                                      "Connection date",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                            contractDisconnectionController
                                                            .lastReadingDate
                                                            .value !=
                                                        null &&
                                                    contractDisconnectionController
                                                        .lastReadingDate
                                                        .value!
                                                        .isNotEmpty
                                                ? Helper.convertDateFormat1(
                                                    dateTime:
                                                        contractDisconnectionController
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
                                        //         contractDisconnectionController
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
                                    // contractDisconnectionController.contractDate.value =
                                    //     date;
                                    //   }
                                    // : () {},
                                    duration: const Duration(milliseconds: 100),
                                    child: CircleAvatar(
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
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: PrimaryInputField(
                                    enablests: false,
                                    labelYn: true,
                                    hintText: "Building code",
                                    txtController:
                                        contractDisconnectionController
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
                                    txtController:
                                        contractDisconnectionController
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
                              txtController: contractDisconnectionController
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
                              txtController: contractDisconnectionController
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
                                      "Last reading date",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                            contractDisconnectionController
                                                            .lastReadingDate
                                                            .value !=
                                                        null &&
                                                    contractDisconnectionController
                                                        .lastReadingDate
                                                        .value!
                                                        .isNotEmpty
                                                ? Helper.convertDateFormat1(
                                                    dateTime:
                                                        contractDisconnectionController
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
                                        //         contractDisconnectionController
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
                                    // contractDisconnectionController.contractDate.value =
                                    //     date;
                                    //   }
                                    // : () {},
                                    duration: const Duration(milliseconds: 100),
                                    child: CircleAvatar(
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
                          gapHC(70)
                        ],
                      ),
                    ),
                  ),
                  //====================================DEduction Details===========================================
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Deduction Details ",
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
                            itemCount: contractDisconnectionController
                                .deductionChargeRows.length,
                            itemBuilder: (context, index) {
                              return Row(children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        contractDisconnectionController
                                            .deductionChargeRows[index].name,
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Obx(() => PrimaryInputField(
                                        onChanged: (value) {
                                          contractDisconnectionController
                                              .fnEnterCrntAmt(value, index);
                                        },
                                        enablests:
                                            contractDisconnectionController
                                                .isEditModeEnabled.value,
                                        hintText: "",
                                        txtRadius: 10,
                                        txtController:
                                            contractDisconnectionController
                                                .deductionChargeRows[index]
                                                .txtCurrentAmt,
                                        textType: TextInputType.number))),
                                gapWC(2),
                                Expanded(
                                    flex: 1,
                                    child: PrimaryInputField(
                                        enablests: false,
                                        hintText: "",
                                        txtRadius: 10,
                                        txtController: TextEditingController(
                                            text:
                                                contractDisconnectionController
                                                    .deductionChargeRows[index]
                                                    .taxPerc
                                                    .value
                                                    .toStringAsFixed(0)),
                                        textType: TextInputType.number)),
                                gapWC(2),
                                Expanded(
                                    flex: 2,
                                    child: Obx(() => PrimaryInputField(
                                        enablests: false,
                                        hintText: "",
                                        txtRadius: 10,
                                        txtController: TextEditingController(
                                            text:
                                                contractDisconnectionController
                                                    .deductionChargeRows[index]
                                                    .currTaxAmount
                                                    .value
                                                    .toString()),
                                        textType: TextInputType.number)))
                              ]);
                            })),
                        const Divider(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                              child: Row(
                                children: [
                                  _tHead(
                                      title: "Total Amount",
                                      color: ThemeColors.primaryBlueColor),
                                  const Spacer(),
                                  Obx(() => Text(contractDisconnectionController
                                      .totalCurrentAmount.value
                                      .toString())),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                              child: Row(
                                children: [
                                  _tHead(
                                      title: "Total Tax Amount",
                                      color: ThemeColors.primaryBlueColor),
                                  const Spacer(),
                                  Obx(() => Text(contractDisconnectionController
                                      .totalCurrTaxAmount.value
                                      .toStringAsFixed(3))),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                              child: Row(
                                children: [
                                  _tHead(
                                      title: "Net Amount (Inc Tax)",
                                      color: ThemeColors.primaryBlueColor),
                                  const Spacer(),
                                  Obx(() => Text(
                                        contractDisconnectionController
                                            .netDeductionAmount.value
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
                  //====================================Amount Details=============================================
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Amount Details ",
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
                            itemCount: contractDisconnectionController
                                .chargeRows.length,
                            itemBuilder: (context, index) {
                              return Row(children: [
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        contractDisconnectionController
                                            .chargeRows[index].name,
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Obx(() => PrimaryInputField(
                                        enablests:
                                            contractDisconnectionController
                                                .isEditModeEnabled.value,
                                        hintText: "",
                                        txtRadius: 10,
                                        txtController:
                                            contractDisconnectionController
                                                .chargeRows[index]
                                                .txtCurrentAmt,
                                        textType: TextInputType.number))),
                                gapWC(2),
                                Expanded(
                                    flex: 1,
                                    child: PrimaryInputField(
                                        enablests: false,
                                        hintText: "",
                                        txtRadius: 10,
                                        // enablests: index != 0 &&
                                        //     index != 6 &&
                                        //     index != 7 &&
                                        //     index != 8,
                                        txtController: TextEditingController(
                                            text:
                                                contractDisconnectionController
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
                                        // enablests: index != 0 &&
                                        //     index != 2 &&
                                        //     index != 6 &&
                                        //     index != 7 &&
                                        //     index != 8,
                                        txtController: TextEditingController(
                                            text:
                                                contractDisconnectionController
                                                    .chargeRows[index]
                                                    .currTaxAmount
                                                    .value
                                                    .toString()),
                                        textType: TextInputType.number))
                              ]);
                            })),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              _tHead(
                                  title: "Total Net payable Amount",
                                  color: ThemeColors.primaryBlueColor),
                              const Spacer(),
                              Obx(() => 
                              Helper.dirhamFormatter(value: contractDisconnectionController
                                  .totalNetAmount.value
                                  .toStringAsFixed(3))
                              
                              // Text(contractDisconnectionController
                              //     .totalNetAmount.value
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
                                  title: "Total Net payable Tax Amount",
                                  color: ThemeColors.primaryBlueColor),
                              const Spacer(),
                              Obx(() => 
                              Helper.dirhamFormatter(value: contractDisconnectionController
                                  .totalNetTax.value
                                  .toStringAsFixed(3))
                              // Text(contractDisconnectionController
                              //     .totalNetTax.value
                              //     .toStringAsFixed(3))
                                  
                                  
                                  ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              _tHead(
                                  title: "Final Net payable",
                                  color: ThemeColors.primaryBlueColor),
                              const Spacer(),
                              Obx(
                                () => 
                                
                                Helper.dirhamFormatter(value: contractDisconnectionController
                                      .totalNetPayable.value
                                      .toStringAsFixed(3))
                                // Text(
                                //   contractDisconnectionController
                                //       .totalNetPayable.value
                                //       .toStringAsFixed(3),
                                //   style: TextStyle(fontWeight: FontWeight.bold),
                                // ),
                              ),
                            ],
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                        //       child: Row(
                        //         children: [
                        //           _tHead(
                        //               title: "Total Amount",
                        //               color: ThemeColors.primaryBlueColor),
                        //           const Spacer(),
                        //           Obx(() => Text(contractDisconnectionController
                        //               .totalCurrAmount.value
                        //               .toString())),
                        //         ],
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                        //       child: Row(
                        //         children: [
                        //           _tHead(
                        //               title: "Total Tax Amount",
                        //               color: ThemeColors.primaryBlueColor),
                        //           const Spacer(),
                        //           Obx(() => Text(contractDisconnectionController
                        //               .totalCurrTaxAmount.value
                        //               .toString())),
                        //         ],
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                        //       child: Row(
                        //         children: [
                        //           _tHead(
                        //               title: "Net Amount (Inc Tax)",
                        //               color: ThemeColors.primaryBlueColor),
                        //           const Spacer(),
                        //           Obx(() => Text(
                        //                 contractDisconnectionController
                        //                     .netAmount.value
                        //                     .toStringAsFixed(3),
                        //                 style: TextStyle(fontSize: 15),
                        //               )),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(),
                        gapHC(30)
                      ],
                    ),
                  )
                ],
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
