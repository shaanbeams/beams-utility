import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import 'package:gas_utility_app/support/common_widgets/bottom_nav_exe.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/common_widgets/gap.dart';
import '../../../support/common_widgets/lookup_search_field.dart';
import '../../../support/common_widgets/primary_button.dart';
import '../../../support/common_widgets/primary_text_field.dart';
import '../../../support/common_widgets/signature_field.dart';
import '../../../support/global.dart';
import '../../gasMeterReceipt/controller/gas_meter_receipt_controller.dart';
import '../../home/view/home_page_exe.dart';
import '../../home/view/widgets/select_doc_type_widget.dart';
import '../../lookup/view/look_up_dialogue_exe.dart';

class GasMeterInvoicePageExe extends StatefulWidget {
  GasMeterInvoicePageExe({super.key, this.isFromReadingPage = false});

  final bool isFromReadingPage;

  @override
  State<GasMeterInvoicePageExe> createState() => _GasMeterInvoicePageExeState();
}

class _GasMeterInvoicePageExeState extends State<GasMeterInvoicePageExe> {
  GasMeterReadingInvoiceController gasMeterReadingInvoiceController = Get.put(GasMeterReadingInvoiceController());
  GasMeterReadingReceiptController gasMeterReadingReceiptController = Get.put(GasMeterReadingReceiptController());

  @override
  void initState() {
    super.initState();

    gasMeterReadingInvoiceController.invoiceDocType = Global.selectedDocType;

    if (widget.isFromReadingPage == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(barrierDismissible: false, Lottie.asset("assets/lotties/loader4.json"));
      });

      gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(mode: "LAST", docNo: "");
      fnGetGasDocMaster(docType: Global.selectedDocType).then(
        (value) {
          Global.ccCode = value[0]["CCCODE"];
          Global.divCode = value[0]["DIVCODE"];
          Global.brnCode = value[0]["BRNCODE"];
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Obx(() => gasMeterReadingInvoiceController.isEditModeEnabled.value == true
            ? Container()
            : Padding(
                padding: EdgeInsets.all(Get.width * .01),
                child: Bounce(
                  onPressed: () {
                    if (gasMeterReadingInvoiceController.floatingIsExpanded.value == true) {
                      gasMeterReadingInvoiceController.floatingIsExpanded(false);
                    } else {
                      gasMeterReadingInvoiceController.floatingIsExpanded(true);
                    }
                  },
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(gasMeterReadingInvoiceController.floatingIsExpanded.value ? 80 : 15),
                      color: ThemeColors.primaryBlueColor,
                    ),
                    height: gasMeterReadingInvoiceController.floatingIsExpanded.value
                        ? Get.width * .1 > 80
                            ? 80
                            : Get.width * .08
                        : Get.width * .1 > 80 || Get.height < 80
                            ? 350
                            : Get.width * .4,
                    width: Get.width * .1 > 80 ? 80 : Get.width * .08,
                    child: gasMeterReadingInvoiceController.floatingIsExpanded.value
                        ? CircleAvatar(
                            radius: 27,
                            backgroundColor: ThemeColors.primaryBlueColor,
                            child: Image.asset(
                              "assets/icons/List_Add.png",
                              height: Get.width * .1 > 60 ? 35 : Get.width * .04,
                              color: Colors.white,
                            ))
                        : SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    Get.dialog(barrierDismissible: false, Lottie.asset("assets/lotties/loader4.json"));
                                    gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(mode: "FIRST", docNo: "");
                                  },
                                  child: CircleAvatar(
                                      radius: Get.width * .1 > 80 || Get.height < 80 ? 27 : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/Skip_first.png",
                                        height: Get.width * .1 > 80 || Get.height < 80 ? 35 : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    Get.dialog(barrierDismissible: false, Lottie.asset("assets/lotties/loader4.json"));
                                    gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(mode: "PREVIOUS", docNo: gasMeterReadingInvoiceController.txtDocNumController.text);
                                  },
                                  child: CircleAvatar(
                                      radius: Get.width * .1 > 80 || Get.height < 80 ? 27 : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/previuos.png",
                                        height: Get.width * .1 > 80 || Get.height < 80 ? 35 : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    // contractController.fngetLastContractDetails(mode: "PREVIOUS", docNo: txtReqNoController.text);
                                  },
                                  child: CircleAvatar(
                                      radius: Get.width * .1 > 80 || Get.height < 80 ? 27 : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/add item.png",
                                        height: Get.width * .1 > 80 || Get.height < 80 ? 35 : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    Get.dialog(barrierDismissible: false, Lottie.asset("assets/lotties/loader4.json"));
                                    gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(mode: "NEXT", docNo: gasMeterReadingInvoiceController.txtDocNumController.text);
                                  },
                                  child: CircleAvatar(
                                      radius: Get.width * .1 > 80 || Get.height < 80 ? 27 : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/next.png",
                                        height: Get.width * .1 > 80 || Get.height < 80 ? 35 : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    Get.dialog(barrierDismissible: false, Lottie.asset("assets/lotties/loader4.json"));
                                    gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(mode: "LAST", docNo: "");
                                  },
                                  child: CircleAvatar(
                                      radius: Get.width * .1 > 80 || Get.height < 80 ? 27 : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/Skip_last.png",
                                        height: Get.width * .1 > 80 || Get.height < 80 ? 35 : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                CircleAvatar(
                                    radius: Get.width * .1 > 60 || Get.height < 80 ? 27 : Get.width * .03,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      "assets/icons/List_Add.png",
                                      height: Get.width * .1 > 60 || Get.height < 80 ? 35 : Get.width * .04,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                  ),
                ),
              )),
        bottomNavigationBar: cBottomNav(Get.height * .04),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: Get.height * .25 < 228 ? 228 : Get.height * .25,
              decoration: BoxDecoration(
                  gradient: ThemeGradient.gradient,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  gapWC(Get.width * .07 < 60 ? Get.width * .07 : 60),
                  Column(
                    children: [
                      gapHC(Get.height * .04),
                      Image.asset(
                        "assets/icons/meter invoice.PNG",
                        height: Get.width * .13 < 120 ? Get.width * .13 : 120,
                      ),
                    ],
                  ),
                  gapWC(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        gapHC(Get.height * .04),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0, right: 18),
                                child: Text(
                                  "Gas Invoice",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 25, fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Colors.white,
                                ),
                              ),
                              Bounce(
                                  onPressed: () {
                                    Get.offAll(() => HomePageExe());
                                  },
                                  duration: const Duration(milliseconds: 100),
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 50, 0),
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundColor: ThemeColors.primaryBlueColor,
                                        child: Image.asset(
                                          "assets/icons/home.png",
                                          height: 35,
                                          color: Colors.white,
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                        gapHC(Get.height * .03),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          runSpacing: 10,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0, bottom: 5),
                                  child: Text(
                                    "Document No.",
                                    style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 13, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                    width: Get.width * .3,
                                    child: CustomSearchField(
                                      
                                      hintLabel: "Document No.",
                                      enablests: false,
                                      controller: gasMeterReadingInvoiceController.txtDocNumController,
                                      onSearchTap: () {
                                        // List searchColumn = [
                                        //   {"showItem": true, "columnName": "DOCNO", "showName": "Document No"},
                                        //   {"showItem": true, "columnName": "CONTRACT_NO", "showName": "Contract No"},
                                        //   {"showItem": true, "columnName": "PARTYNAME", "showName": "Party Name"},
                                        //   {"showItem": true, "columnName": "BUILDING_CODE", "showName": "Building Code"},
                                        //   {"showItem": true, "columnName": "APARTMENT_CODE", "showName": "Apartment Code"},
                                        // ];
                                        // Get.dialog(
                                        //   lookUpDialogueExe(
                                        //     callBackFn: (value) {
                                        //       // contractController.txtcontractNoController.text = value["CONTRACT_NO"].toString();
                                        //       contractReceiptController.txtReqDocNo.text = value["DOCNO"];
                                        //       contractReceiptController.fngetLastContractDetails(mode: "VIEW", docNo: value["DOCNO"]);
                                        //       Get.back();
                                        //     },
                                        //     tableName: "GGASCONTRACTREC",
                                        //     filter: [],
                                        //     searchColumn: searchColumn,
                                        //   ),
                                        // );
                                      },
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0, bottom: 5),
                              child: SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "Date : ",
                                      style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 15 : 12, fontWeight: FontWeight.bold),
                                    ),
                                    // Obx(
                                    //       () => Text(
                                    //     widget.isFromContractPage == true
                                    //         ? Helper.convertDateFormat2(dateTime: DateTime.now().toString())
                                    //         : contractReceiptController.docdate.value != null
                                    //         ? Helper.convertDateFormat1(dateTime: contractReceiptController.docdate.value!)
                                    //         : Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
                                    //     style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 16 : 12, fontWeight: FontWeight.normal),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            gapWC(Get.width * .14 < 200 ? 0 : Get.width * .14),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 5),
                              child: SizedBox(
                                width: 330,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "Net Amount (Inc Tax) :  ",
                                      style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 15 : 12, fontWeight: FontWeight.bold),
                                    ),
                                    Obx(
                                      () => AutoSizeText(
                                        gasMeterReadingInvoiceController.netAmount.value.toStringAsFixed(2),
                                        style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 17 : 15, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            gapHC(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
              child: Row(
                children: [
                  const Spacer(),
                  Obx(() {
                    return gasMeterReadingInvoiceController.isEditModeEnabled.value
                        ? Bounce(
                            duration: const Duration(milliseconds: 100),
                            onPressed: () {
                              gasMeterReadingInvoiceController.isEditModeEnabled(false);
                              gasMeterReadingInvoiceController.fnGetLastGasMeterInvoice(mode: "LAST", docNo: "");
                            },
                            child: Get.width * .3 > 190
                                ? Container(
                                    height: 30,
                                    width: 95,
                                    decoration: BoxDecoration(
                                      color: ThemeColors.primaryRedColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    child: Center(
                                      child: AutoSizeText(
                                        //        contractController.isEditModeEnabled.value ? "Save" :
                                        "Cancel",
                                        maxLines: 1,
                                        minFontSize: 12, // Ensures the text is still readable
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: ThemeColors.primaryRedColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close,
                                        color: ThemeColors.white,
                                        size: 17,
                                      ),
                                    ),
                                  ),
                          )
                        : Bounce(
                            duration: const Duration(milliseconds: 100),
                            onPressed: () {
                              Get.dialog(
                                  barrierDismissible: false,
                                  AlertDialog(
                                    content: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Are you sure want to delete the Reading?",
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          gapHC(30),
                                          Icon(
                                            Icons.delete,
                                            color: ThemeColors.black,
                                            size: 100,
                                          ),
                                          gapHC(30),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10.0),
                                                  child: PrimaryButton(
                                                    buttonLabel: "Cancel",
                                                    onPressed: () {
                                                      // if (Get.isDialogOpen == true) {
                                                      Get.back();
                                                      // }
                                                    },
                                                    isGradient: false,
                                                  ),
                                                ),
                                              ),
                                              gapWC(10),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10.0),
                                                  child: PrimaryButton(
                                                    buttonLabel: "Delete",
                                                    buttonColor: ThemeColors.primaryRedColor,
                                                    onPressed: () async {
                                                      Get.back();
                                                      gasMeterReadingInvoiceController.fnDeleteGasInvoice();
                                                    },
                                                    isGradient: false,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: Get.width * .3 > 190
                                ? Container(
                                    height: 30,
                                    width: 95,
                                    decoration: BoxDecoration(
                                      color: ThemeColors.primaryRedColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    child: Center(
                                      child: AutoSizeText(
                                        //        contractController.isEditModeEnabled.value ? "Save" :
                                        "Delete",
                                        maxLines: 1,
                                        minFontSize: 12, // Ensures the text is still readable
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: ThemeColors.primaryRedColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    child: const Center(
                                      child: Icon(
                                        Icons.delete,
                                        color: ThemeColors.white,
                                        size: 17,
                                      ),
                                    ),
                                  ),
                          );
                  }),
                  gapWC(15),
                  // Obx(
                  //   () => gasMeterReadingInvoiceController.isEditModeEnabled.value == false
                  //       ? Bounce(
                  //           duration: const Duration(milliseconds: 100),
                  //           onPressed: () {
                  //             gasMeterReadingInvoiceController.isEditModeEnabled.value = !gasMeterReadingInvoiceController.isEditModeEnabled.value;
                  //           },
                  //           child: Get.width * .3 > 190
                  //               ? Container(
                  //                   height: 30,
                  //                   width: 95,
                  //                   decoration: BoxDecoration(
                  //                     color: ThemeColors.primaryBlueColor,
                  //                     borderRadius: BorderRadius.circular(5),
                  //                   ),
                  //                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  //                   child: Center(
                  //                     child: AutoSizeText(
                  //                       //        contractController.isEditModeEnabled.value ? "Save" :
                  //                       "Edit",
                  //                       maxLines: 1,
                  //                       minFontSize: 12, // Ensures the text is still readable
                  //                       style: GoogleFonts.poppins(
                  //                         color: ThemeColors.white,
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.normal,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 )
                  //               : Container(
                  //                   height: 30,
                  //                   width: 50,
                  //                   // Use a fixed width instead of Expanded
                  //                   decoration: BoxDecoration(
                  //                     color: ThemeColors.primaryBlueColor,
                  //                     borderRadius: BorderRadius.circular(5),
                  //                   ),
                  //                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  //                   child: const Center(
                  //                     child: Icon(
                  //                       //contractController.isEditModeEnabled.value ? Icons.save :
                  //                       Icons.edit_outlined,
                  //                       color: ThemeColors.white,
                  //                       size: 17,
                  //                     ),
                  //                   ),
                  //                 ),
                  //         )
                  //       : Bounce(
                  //           duration: const Duration(milliseconds: 100),
                  //           onPressed: () {
                  //             gasMeterReadingInvoiceController.isEditModeEnabled.value = !gasMeterReadingInvoiceController.isEditModeEnabled.value;
                  //           },
                  //           child: Container(
                  //             height: 30,
                  //             width: 95,
                  //             decoration: BoxDecoration(
                  //               color: ThemeColors.primaryBlueColor,
                  //               borderRadius: BorderRadius.circular(5),
                  //             ),
                  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  //             child: Center(
                  //               child: AutoSizeText(
                  //                 //        contractController.isEditModeEnabled.value ? "Save" :
                  //                 "Save",
                  //                 maxLines: 1,
                  //                 minFontSize: 12, // Ensures the text is still readable
                  //                 style: GoogleFonts.poppins(
                  //                   color: ThemeColors.white,
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.normal,
                  //                 ),
                  //               ),
                  //             ),
                  //           )),
                  // ),
                  Obx(() {
                    return Visibility(
                      visible: gasMeterReadingInvoiceController.isEditModeEnabled.value == false,
                      child: Row(
                        children: [
                          gapWC(15),
                          Bounce(
                              duration: const Duration(milliseconds: 100),
                              onPressed: () {},
                              child: Container(
                                height: 30,
                                width: 95,
                                decoration: BoxDecoration(
                                  color: ThemeColors.primaryBlueColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                child: Center(
                                  child: AutoSizeText(
                                      //        contractController.isEditModeEnabled.value ? "Save" :
                                      "Print",
                                      maxLines: 1,
                                      minFontSize: 12, // Ensures the text is still readable
                                      style: GoogleFonts.poppins(
                                        color: ThemeColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                              )),
                          gapWC(15),
                          Bounce(
                              child: Get.width * .3 > 200
                                  ? Container(
                                      width: 90,
                                      height: 30,
                                      decoration: BoxDecoration(color: ThemeColors.primaryGreenColor, borderRadius: BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                      child: AutoSizeText(
                                        "Pay Now",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Container(
                                      width: Get.width * .1 < 100 ? Get.width * .1 : 90,
                                      height: 30,
                                      decoration: BoxDecoration(color: ThemeColors.primaryGreenColor, borderRadius: BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                      child: AutoSizeText(
                                        "Pay Now",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                              duration: const Duration(milliseconds: 100),
                              onPressed: () {
                                selectDoctTypeDialogueNext(prvDocType: "GREC").then((value) {
                                  if (value.isNotEmpty) {
                                    gasMeterReadingReceiptController.fnValidateReadingReceipt(
                                        invoiceDocNo: gasMeterReadingInvoiceController.txtDocNumController.text,
                                        invoiceDocType: gasMeterReadingInvoiceController.invoiceDocType,
                                        invoiceYearCode: Global.selectedCompanyYear);
                                  }
                                });
                              })
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),

            ///BODY///
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 15,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      ///MAIN PART//////
                      SizedBox(
                        width: Get.width > 1300 ? Get.width - 700 : Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Tenants Details",
                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                gapWC(15),
                                const Icon(Icons.info_outline),
                              ],
                            ),
                            gapHC(15),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                      child: Text(
                                        "Building Code",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .23 < 230 ? 230 : Get.width * .23,
                                        child: CustomSearchField(
                                           labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                                          hintLabel: "Building Code",
                                          controller: gasMeterReadingInvoiceController.txtBuildingCodeController,
                                           
                                          // enablests: contractController.isEditModeEnabled.value,
                                          onSearchTap: () {
                                            // if (contractController.isEditModeEnabled.value) {
                                            List searchColumn = [
                                              {"showItem": true, "columnName": "BUILDING_CODE", "showName": "Building Code"},
                                              {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                            ];
                                            Get.dialog(
                                              barrierDismissible: false,
                                              lookUpDialogueExe(
                                                tableName: "GBUILDINGMASTER",
                                                callBackFn: (value) {
                                                  gasMeterReadingInvoiceController.txtBuildingCodeController.text = value["BUILDING_CODE"];
                                                  gasMeterReadingInvoiceController.txtBuildingNameController.text = value["DESCP"];
                                                  Get.back();
                                                },
                                                filter: [],
                                                searchColumn: searchColumn,
                                              ),
                                            );
                                            // }
                                          },
                                          onChanged: (p0) {},
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
                                        "Apartment Code",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .23 < 230 ? 230 : Get.width * .23,
                                        child: CustomSearchField(
                                           labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                                          hintLabel: "Apartment Code",
                                          controller: gasMeterReadingInvoiceController.txtApartmentCodeController,
                                         
                                          // enablests: contractController.isEditModeEnabled.value,
                                          onSearchTap: () {
                                            // if (contractController.isEditModeEnabled.value) {
                                            List searchColumn = [
                                              {"showItem": true, "columnName": "APARTMENT_CODE", "showName": " Code"},
                                              // {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                            ];
                                            Get.dialog(
                                              barrierDismissible: false,
                                              lookUpDialogueExe(
                                                tableName: "GAPARTMENTMASTER",
                                                callBackFn: (value) {
                                                  gasMeterReadingInvoiceController.txtApartmentCodeController.text = value["APARTMENT_CODE"];
                                                  // gasMeterReadingInvoiceController.fnValidateApartment();
                                                  Get.back();
                                                },
                                                filter: [
                                                  {'Column': "BUILDING_CODE", 'Operator': '=', 'Value': gasMeterReadingInvoiceController.txtBuildingCodeController.text, 'JoinType': 'AND'},
                                                ],
                                                searchColumn: searchColumn,
                                              ),
                                            );
                                            // }
                                          },
                                          onChanged: (p0) {},
                                          hintSize: 12,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            gapHC(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                  child: Text(
                                    "Building Name",
                                    style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                    width: Get.width * .3 < 230 ? 230 : Get.width * .3,
                                    child: PrimaryInputField(
                                      hintText: "Building Name",
                                      txtController: gasMeterReadingInvoiceController.txtBuildingNameController,
                                    )),
                              ],
                            ),
                            gapHC(30),
                            Row(
                              children: [
                                Text(
                                  "Invoice Summary",
                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                gapWC(15),
                                const Icon(Icons.info_outline),
                              ],
                            ),
                            gapHC(15),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                      child: Text(
                                        "Last Reading",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          txtController: gasMeterReadingInvoiceController.txtLastReadingController,
                                          hintText: "Last Reading",
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0, bottom: 5),
                                      child: Text(
                                        "Outstanting Amount",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          txtController: gasMeterReadingInvoiceController.txtOutStantingAmtController,
                                          hintText: "Outstanting Amount",
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
                                        "Last Paid Amount",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          txtController: gasMeterReadingInvoiceController.txtlastPaidController,
                                          hintText: "Last Paid Amount",
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            gapHC(10),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                      child: Text(
                                        "Contract No",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Contract No",
                                          txtController: gasMeterReadingInvoiceController.txtContractNoController,
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18.0, bottom: 5),
                                      child: Text(
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        "Conversion Factor",
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Conversion Factor",
                                          txtController: gasMeterReadingInvoiceController.txtConvertionFactorController,
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
                                        "Meter No",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Meter No",
                                          txtController: gasMeterReadingInvoiceController.txtGasMeterController,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            gapHC(10),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                      child: Text(
                                        "Tenant Name",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Tenant Name",
                                          txtController: gasMeterReadingInvoiceController.txtTenantNameController,
                                        )),
                                  ],
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                //       child: Text(
                                //         "Mobile No.",
                                //         style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //         width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                //         child: PhoneNumberField(
                                //           hintLabel: "Mobile No.",
                                //           enablests: gasMeterReadingInvoiceController.isEditModeEnabled.value,
                                //           controller: gasMeterReadingInvoiceController.txtMobileNoController,
                                //         )),
                                //   ],
                                // ),

                                SizedBox(
                                  width: 230,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Last Reading Date",
                                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Text(gasMeterReadingInvoiceController.lastReadingDate.value ?? Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
                                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 13),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: ThemeColors.primaryBlueColor,
                                            child: Icon(
                                              Icons.calendar_month_outlined,
                                              color: ThemeColors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )

                                ///TODO ASK VIPIN SIR AND CLEAR
                                // SizedBox(
                                //   width: 230,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(left: 20),
                                //     child: Row(
                                //       children: [
                                //         Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               "Paid Date",
                                //               style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                //             ),
                                //             Padding(
                                //               padding: const EdgeInsets.only(top: 10),
                                //               child: Text("01-10-2024", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                                //             ),
                                //           ],
                                //         ),
                                //         const Padding(
                                //           padding: EdgeInsets.only(left: 13),
                                //           child: CircleAvatar(
                                //             radius: 20,
                                //             backgroundColor: ThemeColors.primaryBlueColor,
                                //             child: Icon(
                                //               Icons.calendar_month_outlined,
                                //               color: ThemeColors.white,
                                //             ),
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            gapHC(10),
                            // Wrap(
                            //   runSpacing: 10,
                            //   spacing: 10,
                            //   crossAxisAlignment: WrapCrossAlignment.center,
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                            //           child: Text(
                            //             "Last Paid Amount",
                            //             style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            //           ),
                            //         ),
                            //         SizedBox(
                            //             width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                            //             child: PrimaryInputField(
                            //               hintText: "Last Paid Amount",
                            //               txtController: gasMeterReadingInvoiceController.txtlastPaidController,
                            //             )),
                            //       ],
                            //     ),
                            //
                            //   ],
                            // ),
                            // gapHC(10),
                            // Wrap(
                            //   runSpacing: 10,
                            //   spacing: 10,
                            //   crossAxisAlignment: WrapCrossAlignment.start,
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                            //           child: Text(
                            //             "Oustanding  Amount",
                            //             style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            //           ),
                            //         ),
                            //         SizedBox(
                            //             width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                            //             child: PrimaryInputField(
                            //               hintText: "Oustanding  Amount",
                            //               txtController: gasMeterReadingInvoiceController.txtOutStantingAmtController,
                            //             )),
                            //       ],
                            //     ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 18.0, bottom: 5),
                            //           child: Text(
                            //             "Last Reading",
                            //             style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                            //           ),
                            //         ),
                            //         SizedBox(
                            //             width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                            //             child: PrimaryInputField(
                            //               hintText: "Last Reading",
                            //             )),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            gapHC(15),
                            Row(
                              children: [
                                Text(
                                  "Enter Current Reading",
                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                gapWC(15),
                                const Icon(Icons.info_outline),
                              ],
                            ),
                            gapHC(10),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                      child: Text(
                                        "Current Reading",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Current Reading",
                                          txtController: gasMeterReadingInvoiceController.txtCurrentReadingController,
                                          onChanged: (value) {
                                            gasMeterReadingInvoiceController.fnConsumptionCalculator(value);
                                          },
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
                                        "Discount",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Discount",
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
                                        "Deposit",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Deposit",
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                                      child: Text(
                                        "Consumption",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Consumption",
                                          txtController: gasMeterReadingInvoiceController.txtConsumptionController,
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
                                        "Unit Price",
                                        style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                        child: PrimaryInputField(
                                          hintText: "Unit Price",
                                          txtController: gasMeterReadingInvoiceController.txtUnitPriceController,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            gapHC(10),

                            SizedBox(
                              height: 220,
                              width: Get.width * .18 < 220 ? 220 : Get.width * .18,
                              child: SignatureField(
                                signatureController: gasMeterReadingInvoiceController.signatureController,
                                isEnabled: gasMeterReadingInvoiceController.isEditModeEnabled.value,
                                lstrSignature: gasMeterReadingInvoiceController.lstrSignature,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///INVOICE PART?//////

                      SizedBox(
                        width: Get.width > 1300 ? 600 : Get.width,
                        // ConstrainedBox(
                        // constraints: BoxConstraints(maxWidth: Get.width * .35 < 600 ? 600 : Get.width * .35, minWidth: 600),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    "Invoice Details",
                                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                gapWC(15),
                                const Icon(Icons.info_outline),
                              ],
                            ),
                            gapHC(20),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [BoxShadow(color: Color(0x41000000), blurRadius: 10, offset: Offset(1, 4), blurStyle: BlurStyle.normal, spreadRadius: 1)],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(),
                                        flex: 3,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text("Amount", style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                                          )),
                                      gapWC(10),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text("VAT %", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                                          )),
                                      gapWC(10),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text("VAT \nAmount", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                                          ))
                                    ],
                                  ),
                                  gapHC(10),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: gasMeterReadingInvoiceController.chargeRows.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Obx(
                                          () => _amountDetailsItem(
                                            headValue: gasMeterReadingInvoiceController.chargeRows[index].name,
                                            amountValueController: gasMeterReadingInvoiceController.chargeRows[index].txtCurrentAmt,
                                            vatPercController: gasMeterReadingInvoiceController.chargeRows[index].taxPerc.toString(),
                                            vatAmountController: gasMeterReadingInvoiceController.chargeRows[index].currTaxAmount.value.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  gapHC(20),
                                  Column(
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                      //   child: Row(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       _tHead(title: "Total Amount", color: ThemeColors.primaryBlueColor),
                                      //       const Spacer(),
                                      //       Text("0.00"),
                                      //     ],
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _tHead(title: "Total Curr Amount", color: ThemeColors.primaryBlueColor),
                                            const Spacer(),
                                            Obx(
                                              () => Text(
                                                textAlign: TextAlign.center,
                                                gasMeterReadingInvoiceController.totalCurrAmount.value.toStringAsFixed(2),
                                                style: GoogleFonts.poppins(
                                                  color: ThemeColors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _tHead(title: "Total Vat Amount", color: ThemeColors.primaryBlueColor),
                                            const Spacer(),
                                            Obx(
                                              () => Text(
                                                textAlign: TextAlign.center,
                                                gasMeterReadingInvoiceController.totalCurrTaxAmount.value.toStringAsFixed(2),
                                                style: GoogleFonts.poppins(
                                                  color: ThemeColors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _tHead(title: "Net Amount (Inc Vat)", color: ThemeColors.primaryBlueColor),
                                            const Spacer(),
                                            Obx(
                                              () => Text(
                                                textAlign: TextAlign.center,
                                                gasMeterReadingInvoiceController.netAmount.value.toStringAsFixed(2),
                                                style: GoogleFonts.poppins(
                                                  color: ThemeColors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
          ],
        ),
      );
    });
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
  final TextEditingController amountValueController;
  String vatAmountController, vatPercController;
  GasMeterReadingInvoiceController gasMeterReadingInvoiceController = Get.find();

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
      gapWC(10),
      Expanded(flex: 1, child: PrimaryInputField(enablests: false, hintText: "", txtRadius: 10, txtController: TextEditingController(text: vatPercController), textType: TextInputType.number)),
      gapWC(10),
      Expanded(flex: 2, child: PrimaryInputField(enablests: false, hintText: "", txtRadius: 10, txtController: TextEditingController(text: vatAmountController), textType: TextInputType.number))
    ]);
  }
}

Text _tHead({required String title, Color? color}) {
  return Text(
    title,
    style: GoogleFonts.poppins(color: color ?? ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}
