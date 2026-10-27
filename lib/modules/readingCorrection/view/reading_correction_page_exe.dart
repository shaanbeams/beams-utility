import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/readingCorrection/controller/reading_correction_controller.dart';
import 'package:gas_utility_app/support/common_widgets/bottom_nav_exe.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';

import '../../../support/common_widgets/commonDialog.dart';
import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/common_widgets/gap.dart';
import '../../../support/common_widgets/image_picker.dart';
import '../../../support/common_widgets/lookup_search_field.dart';
import '../../../support/common_widgets/primary_button.dart';
import '../../../support/common_widgets/primary_text_field.dart';
import '../../../support/global.dart';
import '../../gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import '../../home/view/home_page_exe.dart';
import '../../home/view/widgets/select_doc_type_widget.dart';
import '../../lookup/view/look_up_dialogue_exe.dart';

class ReadingCorrectionPageExe extends StatelessWidget {
  ReadingCorrectionPageExe({super.key, this.isFromContractPage = false});

  final bool isFromContractPage;

  ReadingCorrectionController readingCorrectionController =
      Get.put(ReadingCorrectionController());
  GasMeterReadingInvoiceController gasMeterReadingInvoiceController =
      Get.put(GasMeterReadingInvoiceController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: cBottomNav(Get.height * .04),
        floatingActionButton: Obx(() => readingCorrectionController
                    .isEditModeEnabled.value ==
                true
            ? Container()
            : Padding(
                padding: EdgeInsets.all(Get.width * .01),
                child: Bounce(
                  onPressed: () {
                    if (readingCorrectionController.floatingIsExpanded.value ==
                        true) {
                      readingCorrectionController.floatingIsExpanded(false);
                    } else {
                      readingCorrectionController.floatingIsExpanded(true);
                    }
                  },
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          readingCorrectionController.floatingIsExpanded.value
                              ? 80
                              : 15),
                      color: ThemeColors.primaryBlueColor,
                    ),
                    height: readingCorrectionController.floatingIsExpanded.value
                        ? Get.width * .1 > 80
                            ? 80
                            : Get.width * .08
                        : Get.width * .1 > 80 || Get.height < 80
                            ? 350
                            : Get.width * .4,
                    width: Get.width * .1 > 80 ? 80 : Get.width * .08,
                    child: readingCorrectionController.floatingIsExpanded.value
                        ? CircleAvatar(
                            radius: 27,
                            backgroundColor: ThemeColors.primaryBlueColor,
                            child: Image.asset(
                              "assets/icons/List_Add.png",
                              height:
                                  Get.width * .1 > 60 ? 35 : Get.width * .04,
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
                                    readingCorrectionController
                                        .fnGetLastReadingCorrection(
                                            mode: "FIRST", docNo: "");
                                  },
                                  child: CircleAvatar(
                                      radius:
                                          Get.width * .1 > 80 || Get.height < 80
                                              ? 27
                                              : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/Skip_first.png",
                                        height: Get.width * .1 > 80 ||
                                                Get.height < 80
                                            ? 35
                                            : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    readingCorrectionController
                                        .fnGetLastReadingCorrection(
                                            mode: "PREVIOUS",
                                            docNo: readingCorrectionController
                                                .txtDocNumController.text);
                                  },
                                  child: CircleAvatar(
                                      radius:
                                          Get.width * .1 > 80 || Get.height < 80
                                              ? 27
                                              : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/previuos.png",
                                        height: Get.width * .1 > 80 ||
                                                Get.height < 80
                                            ? 35
                                            : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    // contractController.fngetLastContractDetails(mode: "PREVIOUS", docNo: txtReqNoController.text);
                                  },
                                  child: CircleAvatar(
                                      radius:
                                          Get.width * .1 > 80 || Get.height < 80
                                              ? 27
                                              : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/add item.png",
                                        height: Get.width * .1 > 80 ||
                                                Get.height < 80
                                            ? 35
                                            : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    readingCorrectionController
                                        .fnGetLastReadingCorrection(
                                            mode: "NEXT",
                                            docNo: readingCorrectionController
                                                .txtDocNumController.text);
                                  },
                                  child: CircleAvatar(
                                      radius:
                                          Get.width * .1 > 80 || Get.height < 80
                                              ? 27
                                              : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/next.png",
                                        height: Get.width * .1 > 80 ||
                                                Get.height < 80
                                            ? 35
                                            : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    readingCorrectionController
                                        .fnGetLastReadingCorrection(
                                            mode: "LAST", docNo: "");
                                  },
                                  child: CircleAvatar(
                                      radius:
                                          Get.width * .1 > 80 || Get.height < 80
                                              ? 27
                                              : Get.width * .03,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/icons/Skip_last.png",
                                        height: Get.width * .1 > 80 ||
                                                Get.height < 80
                                            ? 35
                                            : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                CircleAvatar(
                                    radius:
                                        Get.width * .1 > 60 || Get.height < 80
                                            ? 27
                                            : Get.width * .03,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      "assets/icons/List_Add.png",
                                      height:
                                          Get.width * .1 > 60 || Get.height < 80
                                              ? 35
                                              : Get.width * .04,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                  ),
                ),
              )),
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
                        "assets/icons/reading_correction.PNG",
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
                                padding:
                                    const EdgeInsets.only(left: 0, right: 18),
                                child: Text(
                                  "Reading Correction ",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 50, 0),
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundColor:
                                            ThemeColors.primaryBlueColor,
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
                                  padding: const EdgeInsets.only(
                                      left: 25.0, bottom: 5),
                                  child: Text(
                                    "Document No.",
                                    style: GoogleFonts.poppins(
                                        color: ThemeColors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                    width: Get.width * .3,
                                    child: CustomSearchField(
                                      hintLabel: "Document No.",
                                      enablests: false,
                                      controller: readingCorrectionController
                                          .txtDocNumController,
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
                                        //       readingCorrectionController.txtReqDocNo.text = value["DOCNO"];
                                        //       readingCorrectionController.fngetLastContractDetails(mode: "VIEW", docNo: value["DOCNO"]);
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
                              padding:
                                  const EdgeInsets.only(left: 60.0, bottom: 5),
                              child: SizedBox(
                                width: 200,
                                child: Row(
                                  children: [
                                    Text(
                                      "Date : ",
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.white,
                                          fontSize:
                                              Get.width * .19 > 200 ? 15 : 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(
                                      () => Text(
                                        isFromContractPage == true
                                            ? Helper.convertDateFormat2(
                                                dateTime:
                                                    DateTime.now().toString())
                                            : readingCorrectionController
                                                        .docdate.value !=
                                                    null
                                                ? Helper.convertDateFormat1(
                                                    dateTime:
                                                        readingCorrectionController
                                                            .docdate.value!)
                                                : Helper.convertDateFormat2(
                                                    dateTime: DateTime.now()
                                                        .toString()),
                                        style: GoogleFonts.poppins(
                                            color: ThemeColors.white,
                                            fontSize:
                                                Get.width * .19 > 200 ? 16 : 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            gapWC(Get.width * .14 < 200 ? 0 : Get.width * .14),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, bottom: 5),
                              child: SizedBox(
                                width: 330,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "Net Amount (Inc Tax) :  ",
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.white,
                                          fontSize:
                                              Get.width * .19 > 200 ? 15 : 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(
                                      () => AutoSizeText(
                                        readingCorrectionController
                                            .netAmount.value
                                            .toStringAsFixed(2),
                                        style: GoogleFonts.poppins(
                                            color: ThemeColors.white,
                                            fontSize:
                                                Get.width * .19 > 200 ? 17 : 15,
                                            fontWeight: FontWeight.bold),
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
                    return readingCorrectionController.isEditModeEnabled.value
                        ? Bounce(
                            duration: const Duration(milliseconds: 100),
                            onPressed: () {
                              readingCorrectionController
                                  .isEditModeEnabled(false);
                              readingCorrectionController
                                  .fnGetLastReadingCorrection(
                                      mode: "LAST", docNo: "");
                            },
                            child: Get.width * .3 > 190
                                ? Container(
                                    height: 30,
                                    width: 95,
                                    decoration: BoxDecoration(
                                      color: ThemeColors.primaryRedColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    child: Center(
                                      child: AutoSizeText(
                                        //        contractController.isEditModeEnabled.value ? "Save" :
                                        "Cancel",
                                        maxLines: 1,
                                        minFontSize:
                                            12, // Ensures the text is still readable
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: PrimaryButton(
                                                    buttonLabel: "Delete",
                                                    buttonColor: ThemeColors
                                                        .primaryRedColor,
                                                    onPressed: () async {
                                                      Get.back();
                                                      readingCorrectionController
                                                          .fnDeleteReadingCorrection();
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    child: Center(
                                      child: AutoSizeText(
                                        //        contractController.isEditModeEnabled.value ? "Save" :
                                        "Delete",
                                        maxLines: 1,
                                        minFontSize:
                                            12, // Ensures the text is still readable
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
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
                  Bounce(
                      duration: const Duration(milliseconds: 100),
                      onPressed: () {
                        if (readingCorrectionController
                                .isEditModeEnabled.value ==
                            true) {
                          // readingCorrectionController.fnSaveMeterReading();
                          readingCorrectionController.fnSaveReadingCorrection();
                          readingCorrectionController.fnClear();
                          readingCorrectionController.isEditModeEnabled(true);
                        } else {
                          readingCorrectionController.fnClear();

                          readingCorrectionController.isEditModeEnabled.value =
                              !readingCorrectionController
                                  .isEditModeEnabled.value;
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 95,
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryBlueColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: Center(
                          child: Obx(() {
                            return AutoSizeText(
                              //        contractController.isEditModeEnabled.value ? "Save" :
                              readingCorrectionController
                                      .isEditModeEnabled.value
                                  ? "Save"
                                  : "Add",
                              maxLines: 1,
                              minFontSize:
                                  12, // Ensures the text is still readable
                              style: GoogleFonts.poppins(
                                color: ThemeColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          }),
                        ),
                      )),
                  gapWC(15),
                  Obx(() =>
                      readingCorrectionController.isEditModeEnabled.value ==
                              true
                          ? Container()
                          : Bounce(
                              duration: const Duration(milliseconds: 100),
                              onPressed: () {
                                selectDoctTypeDialogueNext(prvDocType: "GIN").then(
                                    (value) {
                                  if (value.isNotEmpty) {
                                    gasMeterReadingInvoiceController
                                        .fnValidateReadingInvoice(
                                            readingDocNo:
                                                readingCorrectionController
                                                    .txtDocNumController.text,
                                            readingDocType:
                                                readingCorrectionController
                                                    .contractReadingDocType,
                                            readingYearCode:
                                                Global.selectedCompanyYear);
                                  }
                                }

                                    // Get.off(() => GasMeterReadingInvoicePage(isFromReadingPage: true,));
                                    );
                              },
                              child: Container(
                                width: 150,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: ThemeColors.primaryGreenColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  "Generate Invoice",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))),
                ],
              ),
            ),

            ///BODY///
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: SingleChildScrollView(
                  child: Obx(
                    () => Wrap(
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
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Building Code",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .23 < 230
                                              ? 230
                                              : Get.width * .23,
                                          child: CustomSearchField(
                                            labelColor:
                                                ThemeColors.primaryBlueColor,
                                            borderColor:
                                                Colors.grey.withOpacity(0.8),
                                            fieldColor: ThemeColors.white,
                                            hintLabel: "Building Code",
                                            controller:
                                                readingCorrectionController
                                                    .txtBuildingCodeController,
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            onSearchTap: () {
                                              // if (contractController.isEditModeEnabled.value) {
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
                                                lookUpDialogueExe(
                                                  tableName: "GBUILDINGMASTER",
                                                  callBackFn: (value) {
                                                    readingCorrectionController
                                                        .fnClear();
                                                    readingCorrectionController
                                                            .txtBuildingCodeController
                                                            .text =
                                                        value["BUILDING_CODE"];
                                                    readingCorrectionController
                                                        .txtBuildingNameController
                                                        .text = value["DESCP"];
                                                    Get.back();
                                                  },
                                                  filter: const [],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Apartment Code",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .23 < 230
                                              ? 230
                                              : Get.width * .23,
                                          child: CustomSearchField(
                                            labelColor:
                                                ThemeColors.primaryBlueColor,
                                            borderColor:
                                                Colors.grey.withOpacity(0.8),
                                            fieldColor: ThemeColors.white,
                                            hintLabel: "Apartment Code",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            controller:
                                                readingCorrectionController
                                                    .txtApartmentCodeController,

                                            // enablests: contractController.isEditModeEnabled.value,
                                            onSearchTap: () {
                                              if (readingCorrectionController
                                                  .txtBuildingCodeController
                                                  .text
                                                  .isEmpty) {
                                                errorMsg(
                                                    msg:
                                                        "Select Building code");
                                                return;
                                              }

                                              // if (contractController.isEditModeEnabled.value) {
                                              List searchColumn = [
                                                {
                                                  "showItem": true,
                                                  "columnName":
                                                      "APARTMENT_CODE",
                                                  "showName": " Code"
                                                },
                                                // {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                              ];
                                              Get.dialog(
                                                barrierDismissible: false,
                                                lookUpDialogueExe(
                                                  tableName: "GAPARTMENTMASTER",
                                                  callBackFn: (value) {
                                                    readingCorrectionController
                                                            .txtApartmentCodeController
                                                            .text =
                                                        value["APARTMENT_CODE"];
                                                    showLoadingDialog();
                                                    readingCorrectionController
                                                        .fnValidateApartment();
                                                    Get.back();
                                                  },
                                                  filter: [
                                                    {
                                                      'Column': "BUILDING_CODE",
                                                      'Operator': '=',
                                                      'Value':
                                                          readingCorrectionController
                                                              .txtBuildingCodeController
                                                              .text,
                                                      'JoinType': 'AND'
                                                    },
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
                                    padding: const EdgeInsets.only(
                                        left: 15.0, bottom: 5),
                                    child: Text(
                                      "Building Name",
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.primaryBlueColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(
                                      width: Get.width * .3 < 230
                                          ? 230
                                          : Get.width * .3,
                                      child: PrimaryInputField(
                                        hintText: "Building Name",
                                        enablests: readingCorrectionController
                                            .isEditModeEnabled.value,
                                        txtController:
                                            readingCorrectionController
                                                .txtBuildingNameController,
                                      )),
                                ],
                              ),
                              gapHC(10),
                              Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Contract No",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Contract No",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            txtController:
                                                readingCorrectionController
                                                    .txtContractNoController,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, bottom: 5),
                                        child: Text(
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                          "Conversion Factor",
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Conversion Factor",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            txtController:
                                                readingCorrectionController
                                                    .txtConvertionFactorController,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Meter No",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Meter No",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            txtController:
                                                readingCorrectionController
                                                    .txtGasMeterController,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Tenant Name",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Tenant Name",
                                            enablests: false,
                                            txtController:
                                                readingCorrectionController
                                                    .txtTenantNameController,
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
                                  //           enablests: readingCorrectionController.isEditModeEnabled.value,
                                  //           controller: readingCorrectionController.txtMobileNoController,
                                  //         )),
                                  //   ],
                                  // ),

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
                              gapHC(30),
                              Row(
                                children: [
                                  Text(
                                    "Invoice Summary",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, bottom: 5),
                                        child: Text(
                                          "Outstanding Amount",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            txtController:
                                                readingCorrectionController
                                                    .txtOutStantingAmtController,
                                            hintText: "Outstanting Amount",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Last Reading",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            txtController:
                                                readingCorrectionController
                                                    .txtLastReadingController,
                                            hintText: "Last Reading",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Last Paid Amount",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            txtController:
                                                readingCorrectionController
                                                    .txtlastPaidController,
                                            hintText: "Last Paid Amount",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              gapHC(20),
                              Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 230,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Last Reading Date",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                    readingCorrectionController
                                                            .lastReadingDate
                                                            .value ??
                                                        Helper.convertDateFormat2(
                                                            dateTime: DateTime
                                                                    .now()
                                                                .toString()),
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 13),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  ThemeColors.primaryBlueColor,
                                              child: Icon(
                                                Icons.calendar_month_outlined,
                                                color: ThemeColors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 230,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Paid Date",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                    readingCorrectionController
                                                            .paidDate.value ??
                                                        Helper.convertDateFormat2(
                                                            dateTime: DateTime
                                                                    .now()
                                                                .toString()),
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 13),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  ThemeColors.primaryBlueColor,
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
                              //               txtController: readingCorrectionController.txtlastPaidController,
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
                              //               txtController: readingCorrectionController.txtOutStantingAmtController,
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
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Current Reading",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Current Reading",
                                            txtController:
                                                readingCorrectionController
                                                    .txtCurrentReadingController,
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            onChanged: (value) {
                                              readingCorrectionController
                                                  .fnConsumptionCalculator(
                                                      value);
                                            },
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
                                  //         "Discount",
                                  //         style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //         width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                  //         child: const PrimaryInputField(
                                  //           hintText: "Discount",
                                  //         )),
                                  //   ],
                                  // ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Deposit",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Deposit",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Consumption",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Consumption",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            txtController:
                                                readingCorrectionController
                                                    .txtConsumptionController,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 5),
                                        child: Text(
                                          "Unit Price",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230
                                              ? 230
                                              : Get.width * .18,
                                          child: PrimaryInputField(
                                            hintText: "Unit Price",
                                            enablests:
                                                readingCorrectionController
                                                    .isEditModeEnabled.value,
                                            txtController:
                                                readingCorrectionController
                                                    .txtUnitPriceController,
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
                                  SizedBox(
                                    width: Get.width * .12 < 180
                                        ? 180
                                        : Get.width * .12,
                                    child: Obx(
                                      () => Bounce(
                                        onPressed: () {},
                                        duration:
                                            const Duration(milliseconds: 100),
                                        child: CustomImagePicker(
                                          label: "Meter image",
                                          image: readingCorrectionController
                                              .meterImage.value,
                                          // enable: readingCorrectionController.isEditModeEnabled.value,
                                          enable: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * .12 < 180
                                        ? 180
                                        : Get.width * .12,
                                    child: Bounce(
                                      onPressed: () {},
                                      duration:
                                          const Duration(milliseconds: 100),
                                      child: Obx(
                                        () => CustomImagePicker(
                                          label: "Front Image",
                                          image: readingCorrectionController
                                              .meterImage.value,
                                          // enable: readingCorrectionController.isEditModeEnabled.value,
                                          enable: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * .12 < 180
                                        ? 180
                                        : Get.width * .12,
                                    child: Bounce(
                                      onPressed: () {},
                                      duration:
                                          const Duration(milliseconds: 100),
                                      child: Obx(
                                        () => CustomImagePicker(
                                          label: "Back Image",
                                          image: readingCorrectionController
                                              .meterImage.value,
                                          // enable: readingCorrectionController.isEditModeEnabled.value,
                                          enable: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                              SizedBox(
                                height: 220,
                                width: Get.width * .18 < 220
                                    ? 220
                                    : Get.width * .18,
                                child: Obx(() {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Text(
                                          "Signature",
                                          style: GoogleFonts.poppins(
                                              color:
                                                  ThemeColors.primaryBlueColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          DottedBorder(
                                            dashPattern: [6, 3],
                                            strokeWidth: 2,
                                            color: ThemeColors.black
                                                .withOpacity(0.5),
                                            radius: Radius.circular(30),
                                            padding: EdgeInsets.all(6),
                                            borderType: BorderType.RRect,
                                            // child: contractController.isEditModeEnabled.value
                                            child: readingCorrectionController
                                                    .isEditModeEnabled.value
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    // child:Container(
                                                    //   height: 160,
                                                    //   child: Center(child: Text("Clicke here to add Signature")),
                                                    // )

                                                    child: Signature(
                                                      // dynamicPressureSupported: ,
                                                      backgroundColor:
                                                          Colors.white,
                                                      height: 160,
                                                      controller:
                                                          // contractController.signatureController,
                                                          readingCorrectionController
                                                              .signatureController,
                                                    ))
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(40),
                                                      height: 160,
                                                      width: double.infinity,
                                                      child:
                                                          readingCorrectionController
                                                                  .lstrSignature
                                                                  .value
                                                                  .isNotEmpty
                                                              ? Image.memory(
                                                                  readingCorrectionController
                                                                      .lstrSignature
                                                                      .value,
                                                                )
                                                              : Image.asset(
                                                                  "assets/icons/signature.png",
                                                                ),
                                                    ),
                                                  ),
                                          ),
                                          Positioned(
                                              right: 10,
                                              top: 10,
                                              child: Bounce(
                                                duration:
                                                    Duration(milliseconds: 100),
                                                onPressed: () {
                                                  readingCorrectionController
                                                      .signatureController
                                                      .clear();
                                                },
                                                child: CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        readingCorrectionController
                                                                .isEditModeEnabled
                                                                .value
                                                            ? ThemeColors
                                                                .primaryGreenColor
                                                            : ThemeColors.grey,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    )),
                                              ))
                                        ],
                                      ),
                                    ],
                                    // ),
                                  );
                                }),
                              ),

                              gapHC(100),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "Invoice Details",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x41000000),
                                        blurRadius: 10,
                                        offset: Offset(1, 4),
                                        blurStyle: BlurStyle.normal,
                                        spreadRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text("Amount",
                                                  style: GoogleFonts.poppins(
                                                      color: ThemeColors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )),
                                        gapWC(10),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text("VAT %",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      color: ThemeColors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )),
                                        gapWC(10),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text("VAT \nAmount",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      color: ThemeColors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ))
                                      ],
                                    ),
                                    gapHC(10),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: readingCorrectionController
                                          .chargeRows.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Obx(
                                            () => _amountDetailsItem(
                                              headValue:
                                                  readingCorrectionController
                                                      .chargeRows[index].name,
                                              amountValueController:
                                                  readingCorrectionController
                                                      .chargeRows[index]
                                                      .txtCurrentAmt,
                                              vatPercController:
                                                  readingCorrectionController
                                                      .chargeRows[index].taxPerc
                                                      .toString(),
                                              vatAmountController:
                                                  readingCorrectionController
                                                      .chargeRows[index]
                                                      .currTaxAmount
                                                      .value
                                                      .toStringAsFixed(3),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 30, 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _tHead(
                                                  title: "Total Curr Amount",
                                                  color: ThemeColors
                                                      .primaryBlueColor),
                                              const Spacer(),
                                              Obx(
                                                () => Text(
                                                  textAlign: TextAlign.center,
                                                  readingCorrectionController
                                                      .totalCurrAmount.value
                                                      .toStringAsFixed(2),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 30, 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _tHead(
                                                  title: "Total Vat Amount",
                                                  color: ThemeColors
                                                      .primaryBlueColor),
                                              const Spacer(),
                                              Obx(
                                                () => Text(
                                                  textAlign: TextAlign.center,
                                                  readingCorrectionController
                                                      .totalCurrTaxAmount.value
                                                      .toStringAsFixed(2),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 30, 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _tHead(
                                                  title: "Net Amount (Inc Vat)",
                                                  color: ThemeColors
                                                      .primaryBlueColor),
                                              const Spacer(),
                                              Obx(
                                                () => Text(
                                                  textAlign: TextAlign.center,
                                                  readingCorrectionController
                                                      .netAmount.value
                                                      .toStringAsFixed(2),
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
            ),
          ],
        ),
      );
    });
  }
}

class _amountDetailsItem extends StatelessWidget {
  _amountDetailsItem({
    required this.headValue,
    required this.amountValueController,
    required this.vatAmountController,
    required this.vatPercController,
  });

  final String headValue;
  final TextEditingController amountValueController;
  String vatAmountController, vatPercController;
  ReadingCorrectionController readingCorrectionController = Get.find();

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
              enablests: readingCorrectionController.isEditModeEnabled.value,
              hintText: "",
              txtRadius: 10,
              txtController: amountValueController,
              textType: TextInputType.number)),
      gapWC(10),
      Expanded(
          flex: 1,
          child: PrimaryInputField(
              enablests: false,
              hintText: "",
              txtRadius: 10,
              txtController: TextEditingController(text: vatPercController),
              textType: TextInputType.number)),
      gapWC(10),
      Expanded(
          flex: 2,
          child: PrimaryInputField(
              enablests: false,
              hintText: "",
              txtRadius: 10,
              txtController: TextEditingController(text: vatAmountController),
              textType: TextInputType.number))
    ]);
  }
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
