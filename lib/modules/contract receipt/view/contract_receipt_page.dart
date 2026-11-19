import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract%20receipt/controller/contract_receipt_controller.dart';
import 'package:gas_utility_app/modules/contract%20receipt/widgets/contract_receipt_details_card.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/common_widgets/print_button.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 

import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/global.dart';

class ContractReceiptPage extends StatefulWidget {
  final bool? isFromContractPage;
  final String? contractNo;

  ContractReceiptPage(
      {super.key, this.isFromContractPage = false, this.contractNo});

  @override
  State<ContractReceiptPage> createState() => _ContractReceiptPageState();
}

ScrollController listViewScrollController = ScrollController();
ContractReceiptController contractReceiptController =
    Get.put(ContractReceiptController());

class _ContractReceiptPageState extends State<ContractReceiptPage> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog();
    });

    if (widget.isFromContractPage == false) {
      contractReceiptController.fngetLastContractDetails(
          mode: "LAST", docNo: "");
    } else {
      contractReceiptController.getContractReceipt(
          contractNo: widget.contractNo ?? "");
      fnGetGasDocMaster(docType: Global.selectedDocType).then(
        (value) {
          Global.ccCode = value[0]["CCCODE"];
          Global.divCode = value[0]["DIVCODE"];
          Global.brnCode = value[0]["BRNCODE"];
        },
      );
    }
    contractReceiptController.isEditModeEnabled.value =
        widget.isFromContractPage == true;

    // contractReceiptController.getContractReceipt(
    //     contractNo: widget.contractNo ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton:
      //     contractReceiptController.isEditModeEnabled.value == true
      //         ? Container()
      //         : Padding(
      //             padding: const EdgeInsets.only(bottom: 70),
      //             child: SizedBox(
      //                 width: 100,
      //                 child: PrintButton(
      //                   onPressed: () {},
      //                 ))),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
            netAmount:
                contractReceiptController.netAmount.value.toStringAsFixed(2),
            netAmountisRequired: true,
            fnonCancelPressed: widget.isFromContractPage == true
                ? () {
                    Get.back();
                  }
                : () {
                    contractReceiptController.isEditModeEnabled.value = false;
                  },
            fnonFirstButtonPressed: () {
              showLoadingDialog();
              contractReceiptController.fngetLastContractDetails(
                  mode: "FIRST", docNo: "");
            },
            fnonPreviousButtonPressed: () {
              showLoadingDialog();
              contractReceiptController.fngetLastContractDetails(
                  mode: "PREVIOUS",
                  docNo: contractReceiptController
                          .selectedContractReceiptFill.docno ??
                      "0");
            },
            fnonNextButtonPressed: () {
              showLoadingDialog();
              contractReceiptController.fngetLastContractDetails(
                  mode: "NEXT",
                  docNo: contractReceiptController
                          .selectedContractReceiptFill.docno ??
                      "0");
            },
            fnonLastButtonPressed: () {
              showLoadingDialog();
              contractReceiptController.fngetLastContractDetails(
                  mode: "LAST", docNo: "");
            },
            fnonSaveButtonPressed: () {
              contractReceiptController.fnSaveContractReceipt();
            },
            isEditIconEnabled:
                contractReceiptController.isEditModeEnabled.value,
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
                bottomRight: Radius.circular(30), // Slightly tighter curve
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    16, 8, 16, 12), // Reduced vertical padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top Bar (Back Button, Icon, Title)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8), // Reduced top padding
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Bounce(
                            onPressed: () {
                              Get.back();
                            },
                            duration: const Duration(milliseconds: 100),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, 0, 16, 0), // Tighter spacing
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: ThemeColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          Image.asset(
                            "assets/icons/contract_receipt.png",
                            height: 32, // Slightly compact icon size
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Contract Receipt",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: ThemeColors.white,
                                fontSize:
                                    18, // Slightly reduced font size for compactness
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Search Field & Date Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomSearchField(
                              labelColor: Colors.white,
                              label: "Contract Receipt No",
                              labelYn: true,
                              // enablests: false,
                              readonly: true,
                              hintLabel: "Contract Receipt No",
                              controller: contractReceiptController.txtReqDocNo,
                              onSearchTap: () {
                                              if(contractReceiptController.isEditModeEnabled.value==false){
                                List searchColumn = [
                                  {
                                    "showItem": true,
                                    "columnName": "DOCNO",
                                    "showName": "Document No"
                                  },
                                  {
                                    "showItem": true,
                                    "columnName": "CONTRACT_NO",
                                    "showName": "Contract No"
                                  },
                                  {
                                    "showItem": true,
                                    "columnName": "PARTYNAME",
                                    "showName": "Party Name"
                                  },
                                  {
                                    "showItem": true,
                                    "columnName": "BUILDING_CODE",
                                    "showName": "Building Code"
                                  },
                                  {
                                    "showItem": true,
                                    "columnName": "APARTMENT_CODE",
                                    "showName": "Apartment Code"
                                  },
                                ];
                                Get.dialog(lookUpDialogue(
                                  callBackFn: (value) {
                                    contractReceiptController.txtReqDocNo.text =
                                        value["DOCNO"];
                                    contractReceiptController
                                        .fngetLastContractDetails(
                                            mode: "VIEW",
                                            docNo: value["DOCNO"]);
                                    Get.back();
                                  },
                                  tableName: "GGASCONTRACTREC",
                                  filter: [],
                                  searchColumn: searchColumn,
                                ));}
                              },
                            ),
                          ),
                          gapWC(10),
                          Expanded(
                            flex: 2,
                            child: widget.isFromContractPage == true
                                ? Row(children: [
                                    _tHead(title: "Date : "),
                                    _tValue(
                                        value: Helper.convertDateFormat2(
                                            dateTime:
                                                DateTime.now().toString()))
                                  ])
                                : Row(
                                    children: [
                                      _tHead(title: "Date : "),
                                      Obx(() => Text(
                                          contractReceiptController
                                                      .docdate.value !=
                                                  null
                                              ? Helper.convertDateFormat1(
                                                  dateTime:
                                                      contractReceiptController
                                                          .docdate.value!)
                                              : Helper.convertDateFormat2(
                                                  dateTime: DateTime.now()
                                                      .toString()),
                                          style: GoogleFonts.poppins(
                                              color: ThemeColors.white,
                                              fontSize: Get.width * .19 > 200
                                                  ? 15
                                                  : 11,
                                              fontWeight: FontWeight.normal))),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    gapHC(5),
                    Obx(() => DetailCard(
                          tenantName: contractReceiptController
                                  .selectedcontractReceipt
                                  .value
                                  ?.partyname
                                  ?.value ??
                              "",
                          contractNo: contractReceiptController
                                  .selectedcontractReceipt
                                  .value
                                  ?.contractNo
                                  ?.value ??
                              "",
                          apartmentNo: contractReceiptController
                                  .selectedcontractReceipt
                                  .value
                                  ?.apartmentCode
                                  ?.value ??
                              "",
                          buildingName: contractReceiptController
                                  .selectedcontractReceipt
                                  .value
                                  ?.buildingDescp
                                  ?.value ??
                              "",
                          buildingNo: contractReceiptController
                                  .selectedcontractReceipt
                                  .value
                                  ?.buildingCode
                                  ?.value ??
                              "",
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            "Invoice Details",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.info_outline),
                          // const Spacer(),
                          // Bounce(
                          //     onPressed: () {
                          //       listViewScrollController.animateTo(
                          //           listViewScrollController
                          //               .position.maxScrollExtent,
                          //           duration: const Duration(seconds: 1),
                          //           curve: Curves.easeInOut);
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
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: [
                          //             _tHead(
                          //               title: "More Details",
                          //             ),
                          //             const Icon(
                          //               Icons.arrow_forward,
                          //               color: Colors.white,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ))
                        ],
                      ),
                    ),
                    widget.isFromContractPage == true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Obx(
                              () => ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: contractReceiptController
                                      .chargeRows.length,
                                  itemBuilder: (context, index) {
                                    final chargeRow = contractReceiptController
                                        .chargeRows[index];

                                    ///Node Function///
                                    chargeRow.focusNode.addListener(() {
                                      if (!chargeRow.focusNode.hasFocus) {
                                        contractReceiptController
                                            .checkNodeFocus(index);
                                      }
                                    });
                                    return Obx(
                                      () => Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 5),
                                                ),
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      contractReceiptController
                                                          .chargeRows[index]
                                                          .name,
                                                      style: GoogleFonts.poppins(
                                                          color: ThemeColors
                                                              .primaryBlueColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              "Amount",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color:
                                                                    ThemeColors
                                                                        .black,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ),
                                                          gapWC(5),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                contractReceiptController
                                                                    .chargeRows[
                                                                        index]
                                                                    .amount
                                                                    .value
                                                                    .toStringAsFixed(
                                                                        3),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color:
                                                                      ThemeColors
                                                                          .black,
                                                                  fontSize: 10,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              "Amt Received",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color:
                                                                    ThemeColors
                                                                        .black,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ),
                                                          gapWC(5),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                contractReceiptController
                                                                    .chargeRows[
                                                                        index]
                                                                    .amountReceived
                                                                    .value
                                                                    .toStringAsFixed(
                                                                        3),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color:
                                                                      ThemeColors
                                                                          .black,
                                                                  fontSize: 10,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              "Tax amount",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color:
                                                                    ThemeColors
                                                                        .black,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ),
                                                          gapWC(5),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                contractReceiptController
                                                                    .chargeRows[
                                                                        index]
                                                                    .currTaxAmount
                                                                    .value
                                                                    .toStringAsFixed(
                                                                        3),
                                                                style: GoogleFonts.poppins(
                                                                    color: ThemeColors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              "Total",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color:
                                                                    ThemeColors
                                                                        .black,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ),
                                                          gapWC(5),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Obx(
                                                              () => Text(
                                                                  contractReceiptController
                                                                      .chargeRows[
                                                                          index]
                                                                      .total
                                                                      .value
                                                                      .toStringAsFixed(
                                                                          3),
                                                                  style: GoogleFonts.poppins(
                                                                      color: ThemeColors
                                                                          .black,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 3),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              "Balance",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color:
                                                                    ThemeColors
                                                                        .black,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          ),
                                                          gapWC(5),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                contractReceiptController
                                                                    .chargeRows[
                                                                        index]
                                                                    .balance
                                                                    .value
                                                                    .toStringAsFixed(
                                                                        3),
                                                                style: GoogleFonts.poppins(
                                                                    color: ThemeColors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                Expanded(
                                                    child: PrimaryInputField(
                                                  enablests:
                                                      widget.isFromContractPage,
                                                  focusNode:
                                                      contractReceiptController
                                                          .chargeRows[index]
                                                          .focusNode,
                                                  labelYn: true,
                                                  label: "Current Amount",
                                                  hintText: "0.00",
                                                  txtController:
                                                      contractReceiptController
                                                          .chargeRows[index]
                                                          .txtCurrentAmt,
                                                  textType:
                                                      TextInputType.number,
                                                  onChanged: (p0) {
                                                    contractReceiptController
                                                        .fnEnterCrntAmt(
                                                            p0, index);
                                                  },
                                                )),
                                              ],
                                            ),
                                          )),
                                    );
                                  }),
                            ),

                            //  Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Expanded(
                            //           flex: 2,
                            //           child: Column(
                            //             children: [
                            //               const SizedBox(
                            //                   height: 40, child: Text(" ")),
                            //               // SizedBox(
                            //               //   height: 65,
                            //               //   child: Align(
                            //               //     alignment: Alignment.center,
                            //               //     child: _tHead(title: "Monthly Amount", color: ThemeColors.primaryBlueColor),
                            //               //   ),
                            //               // ),
                            //               // SizedBox(
                            //               //   height: 65,
                            //               //   child: Align(
                            //               //     alignment: Alignment.center,
                            //               //     child: _tHead(title: "Boiler gas Amount", color: ThemeColors.primaryBlueColor),
                            //               //   ),
                            //               // ),
                            //               SizedBox(
                            //                 height: 65,
                            //                 child: Align(
                            //                   alignment: Alignment.center,
                            //                   child: _tHead(
                            //                       title: "Insurance",
                            //                       color:
                            //                           ThemeColors.primaryBlueColor),
                            //                 ),
                            //               ),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Deposit",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Connection",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Maintanance",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Disconnection",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //               // SizedBox(
                            //               //     height: 65,
                            //               //     child: Align(
                            //               //       alignment: Alignment.center,
                            //               //       child: _tHead(title: "Clearance", color: ThemeColors.primaryBlueColor),
                            //               //     )),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Registration",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //               // SizedBox(
                            //               //     height: 65,
                            //               //     child: Align(
                            //               //       alignment: Alignment.center,
                            //               //       child: _tHead(title: "Administration fee", color: ThemeColors.primaryBlueColor),
                            //               //     )),
                            //               // SizedBox(
                            //               //     height: 65,
                            //               //     child: Align(
                            //               //       alignment: Alignment.center,
                            //               //       child: _tHead(title: "Bill meter reading fee", color: ThemeColors.primaryBlueColor),
                            //               //     )),
                            //               // SizedBox(
                            //               //     height: 65,
                            //               //     child: Align(
                            //               //       alignment: Alignment.center,
                            //               //       child: _tHead(title: "Facility fee", color: ThemeColors.primaryBlueColor),
                            //               //     )),
                            //               // SizedBox(
                            //               //     height: 65,
                            //               //     child: Align(
                            //               //       alignment: Alignment.center,
                            //               //       child: _tHead(title: "Delay Payment charge", color: ThemeColors.primaryBlueColor),
                            //               //     )),
                            //               // SizedBox(
                            //               //     height: 65,
                            //               //     child: Align(
                            //               //       alignment: Alignment.center,
                            //               //       child: _tHead(title: "Security Charges", color: ThemeColors.primaryBlueColor),
                            //               //     )),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Other Charge 1",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Other Charge 2",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //               SizedBox(
                            //                   height: 65,
                            //                   child: Align(
                            //                     alignment: Alignment.center,
                            //                     child: _tHead(
                            //                         title: "Other Charge 3",
                            //                         color:
                            //                             ThemeColors.primaryBlueColor),
                            //                   )),
                            //             ],
                            //           )),
                            //       gapWC(10),
                            //       Expanded(
                            //           flex: 4,
                            //           child: SizedBox(

                            //               ///change height as 65* length of the list + 40
                            //               height: 625,
                            //               child: ListView(
                            //                 controller: listViewScrollController,
                            //                 clipBehavior: Clip.hardEdge,
                            //                 scrollDirection: Axis.horizontal,
                            //                 shrinkWrap: true,
                            //                 children: [
                            //                   const DetailsColumnWidget(
                            //                     headValue: "Curr Amount",
                            //                     enablests: true,
                            //                   ),
                            //                   gapWC(10),
                            //                   const DetailsColumnWidget(
                            //                     headValue: "Amount",
                            //                   ),
                            //                   gapWC(10),
                            //                   const DetailsColumnWidget(
                            //                       headValue: "Amt Received"),
                            //                   gapWC(10),
                            //                   const DetailsColumnWidget(
                            //                       headValue: "Total"),
                            //                   gapWC(10),
                            //                   const DetailsColumnWidget(
                            //                       headValue: "Balance"),
                            //                   gapWC(10),
                            //                 ],
                            //               )))
                            //     ]),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Obx(
                              () => ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount:
                                    contractReceiptController.chargeRows.length,
                                separatorBuilder: (_, __) => Divider(
                                    height: 1, color: Colors.grey.shade300),
                                itemBuilder: (context, index) {
                                  final chargeRow = contractReceiptController
                                      .chargeRows[index];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Heading + info icon
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              chargeRow.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                color: ThemeColors
                                                    .primaryBlueColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () => _showChargeDetails(
                                                context, chargeRow),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Icon(
                                                Icons.info_outline,
                                                size: 18,
                                                color: ThemeColors
                                                    .primaryBlueColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Obx(() => _receiptLine(
                                          "Total",
                                          chargeRow.total.value
                                              .toStringAsFixed(3))),
                                      Obx(() => _receiptLine(
                                          "Balance",
                                          chargeRow.balance.value
                                              .toStringAsFixed(3),
                                          bold: true)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                    const Divider(),
                    Obx(
                      () => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              children: [
                                _tHead(
                                    title: "Total Curr Amount",
                                    color: ThemeColors.primaryBlueColor),
                                const Spacer(),
                                Helper.dirhamFormatter(
                                    value: contractReceiptController
                                        .totalCurrAmount.value
                                        .toStringAsFixed(2),
                                    colour: Colors.black)
                               
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              children: [
                                _tHead(
                                    title: "Total Curr Tax Amount",
                                    color: ThemeColors.primaryBlueColor),
                                const Spacer(),
                                Helper.dirhamFormatter(
                                    value: contractReceiptController
                                        .totalCurrTaxAmount.value
                                        .toStringAsFixed(2),
                                    colour: Colors.black)
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
                                Helper.dirhamFormatter(
                                    value: contractReceiptController
                                        .netAmount.value
                                        .toStringAsFixed(2),
                                    fontSize: 15,
                                    colour: Colors.black),
                                // Text(
                                //   contractReceiptController.netAmount.value
                                //       .toStringAsFixed(2),
                                //   style: TextStyle(fontSize: 15),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: _tHead(
                            title: "Payment Method : ",
                            color: ThemeColors.primaryBlueColor)),
                    SizedBox(
                      height: 30,
                      child: RadioMenuButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        value: "Cash",
                        onChanged:
                            contractReceiptController.isEditModeEnabled.value ==
                                    true
                                ? (value) {
                                    setState(() {
                                      selectedOption = value.toString();
                                      contractReceiptController.txtCreditCard
                                          .clear();
                                      contractReceiptController
                                          .selectedPaymentMode.value = "CASH";
                                    });
                                  }
                                : (s) {},
                        groupValue: selectedOption,
                        child: const Text("Cash"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: RadioMenuButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        value: "Credit card",
                        onChanged:
                            contractReceiptController.isEditModeEnabled.value ==
                                    true
                                ? (value) {
                                    setState(() {
                                      selectedOption = value.toString();
                                      contractReceiptController
                                          .selectedPaymentMode
                                          .value = "CREDITCARD";
                                    });
                                  }
                                : (_) {},
                        groupValue: selectedOption,
                        child: const Text("Credit card"),
                      ),
                    ),
                    Visibility(
                      visible: selectedOption == "Credit card",
                      child: CustomSearchField(
                        labelColor: ThemeColors.primaryBlueColor,
                        borderColor: Colors.grey.withOpacity(0.8),
                        fieldColor: ThemeColors.white,
                        enablests:
                            contractReceiptController.isEditModeEnabled.value,
                        label: "Credit Card",
                        labelYn: true,
                        hintLabel: "Credit Card",
                        hintSize: 11,
                        onSearchTap: () {
                          if (contractReceiptController
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
                                    contractReceiptController.txtCreditCard
                                        .text = value["CODE"].toString();
                                  }
                                },
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                        controller: contractReceiptController.txtCreditCard,
                      ),
                    )

                    // SizedBox(
                    //   height: 30,
                    //   child: RadioMenuButton(
                    //     style: const ButtonStyle(
                    //       splashFactory: NoSplash.splashFactory,
                    //     ),
                    //     value: "Cheque",
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedOption = value.toString();
                    //       });
                    //     },
                    //     groupValue: selectedOption,
                    //     child: const Text("Cheque"),
                    //   ),
                    // )
                    ,
                    gapHC(60)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsColumnWidget extends StatelessWidget {
  const DetailsColumnWidget(
      {super.key, required this.headValue, this.enablests = false});
  final String headValue;
  final bool? enablests;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 3,
      child: Column(
        children: [
          SizedBox(
              width: Get.width / 3,
              height: 40,
              child: _tHead(
                  title: headValue, color: ThemeColors.primaryBlueColor)),
          Obx(
            () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contractReceiptController.chargeRows.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 65,
                    width: Get.width / 3,
                    child: PrimaryInputField(
                      enablests: enablests,
                      labelYn: false,
                      hintText:
                          getInitialValue(headValue: headValue, index: index),
                      txtRadius: 10,
                      textType: TextInputType.number,
                      onChanged: (value) {
                        contractReceiptController.fnEnterCrntAmt(value, index);
                      },
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

getInitialValue({
  required String headValue,
  required int index,
}) {
  switch (headValue) {
    case "Amount":
      return contractReceiptController.chargeRows[index].amount.value
          .toString();
    case "Amt Received":
      return contractReceiptController.chargeRows[index].amountReceived.value
          .toString();
    case "Curr Amount":
      return contractReceiptController.chargeRows[index].currentAmt.value
          .toString();
    case "Total":
      return contractReceiptController.chargeRows[index].total.value.toString();
    case "Balance":
      return contractReceiptController.chargeRows[index].balance.value
          .toString();
    default:
      return "0.0";
  }
}

//

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

Widget _receiptLine(String label, String value, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[700],
            fontSize: 11,
          ),
        ),
       
        Helper.dirhamFormatter(value: value, colour: ThemeColors.black,fontSize: 12)
       
      ],
    ),
  );
}

void _showChargeDetails(BuildContext context, dynamic chargeRow) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chargeRow.name,
              style: GoogleFonts.poppins(
                color: ThemeColors.primaryBlueColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(height: 20),
            _detailLine("Amount", chargeRow.amount.value),
            _detailLine("Amt Received", chargeRow.amountReceived.value),
            _detailLine("Tax amount", chargeRow.currTaxAmount.value),
            _detailLine("Total", chargeRow.total.value, bold: true),
            _detailLine("Balance", chargeRow.balance.value, bold: true),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}

Widget _detailLine(String label, double value, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12)),
        Helper.dirhamFormatter(value: value.toStringAsFixed(2), colour: Colors.black)
        // UaeDirhamSymbolTextView(
        //   amount: value,
        //   fontSize: 12,
        //   isFormatted: true,
        //   includeDecimal: true,
        //   // fontWeight: FontWeight.bold,
        // ),
        // Text(
        //   value.toStringAsFixed(3),
        //   style: GoogleFonts.poppins(
        //     fontSize: 12,
        //     fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
        //   ),
        // ),
      ],
    ),
  );
}
