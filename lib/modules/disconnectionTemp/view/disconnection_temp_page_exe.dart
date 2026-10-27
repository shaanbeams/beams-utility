import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/support/common_widgets/bottom_nav_exe.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/common_widgets/gap.dart';
import '../../../support/common_widgets/lookup_search_field.dart';
import '../../../support/common_widgets/primary_button.dart';
import '../../../support/common_widgets/primary_text_field.dart';
import '../../home/view/home_page_exe.dart';
import '../../lookup/view/look_up_dialogue_exe.dart';
import '../controller/temp_disconnection_controller.dart';

class DisconnectionTemporaryPageExe extends StatefulWidget {
  const DisconnectionTemporaryPageExe({super.key, this.isFromInvoicePage = false});

  final bool isFromInvoicePage;

  @override
  State<DisconnectionTemporaryPageExe> createState() => _DisconnectionTemporaryPageExeState();
}

class _DisconnectionTemporaryPageExeState extends State<DisconnectionTemporaryPageExe> {
  TempDisconnectionController tempDisconnectionController = Get.put(TempDisconnectionController());

  @override
  void initState() {
    super.initState();

    if (widget.isFromInvoicePage == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showLoadingDialog();
      });
      tempDisconnectionController.fnGetLastTempContractDisconnection(docNo: "", mode: "LAST");
      // if (Get.isDialogOpen == true) {
      //   Get.back();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: cBottomNav(Get.height * .04),
        floatingActionButton: Obx(() => tempDisconnectionController.isEditModeEnabled.value == true
            ? Container()
            : Padding(
                padding: EdgeInsets.all(Get.width * .01),
                child: Bounce(
                  onPressed: () {
                    if (tempDisconnectionController.floatingIsExpanded.value == true) {
                      tempDisconnectionController.floatingIsExpanded(false);
                    } else {
                      tempDisconnectionController.floatingIsExpanded(true);
                    }
                  },
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(tempDisconnectionController.floatingIsExpanded.value ? 80 : 15),
                      color: ThemeColors.primaryBlueColor,
                    ),
                    height: tempDisconnectionController.floatingIsExpanded.value
                        ? Get.width * .1 > 80
                            ? 80
                            : Get.width * .08
                        : Get.width * .1 > 80 || Get.height < 80
                            ? 350
                            : Get.width * .4,
                    width: Get.width * .1 > 80 ? 80 : Get.width * .08,
                    child: tempDisconnectionController.floatingIsExpanded.value
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
                                    tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "FIRST", docNo: "");
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
                                    tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "PREVIOUS", docNo: tempDisconnectionController.txtDocNumController.text);
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
                                    // contractController.fngetLastContractDetails(mode: "NEXT", docNo: contractController.txtcontractNoController.text);
                                    tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "NEXT", docNo: tempDisconnectionController.txtDocNumController.text);
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
                                    tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "LAST", docNo: "");
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
                        "assets/icons/disconnected.png",
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
                                  "Temporary Disconnection",
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
                                      controller: tempDisconnectionController.txtDocNumController,
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
                                        //       tempDisconnectionController.txtReqDocNo.text = value["DOCNO"];
                                        //       tempDisconnectionController.fngetLastContractDetails(mode: "VIEW", docNo: value["DOCNO"]);
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
                                    widget.isFromInvoicePage == true || tempDisconnectionController.docdate.value == null
                                        ? Text(
                                            widget.isFromInvoicePage == true
                                                ? Helper.convertDateFormat2(dateTime: DateTime.now().toString())
                                                : tempDisconnectionController.docdate.value != null
                                                    ? Helper.convertDateFormat1(dateTime: tempDisconnectionController.docdate.value!)
                                                    : Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
                                            style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 16 : 12, fontWeight: FontWeight.normal),
                                          )
                                        : Obx(
                                            () => Text(
                                              Helper.convertDateFormat1(dateTime: tempDisconnectionController.docdate.value!),
                                              style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 16 : 12, fontWeight: FontWeight.normal),
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
                    return tempDisconnectionController.isEditModeEnabled.value
                        ? Bounce(
                            duration: const Duration(milliseconds: 100),
                            onPressed: () {
                              tempDisconnectionController.isEditModeEnabled(false);
                              tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "LAST", docNo: "");
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
                                            "Are you sure want to delete the Invoice Receipt?",
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
                                                      // tempDisconnectionController.fnDeleteGasInvoiceReceipt();
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
                  Bounce(
                      duration: const Duration(milliseconds: 100),
                      onPressed: () {
                        if (tempDisconnectionController.isEditModeEnabled.value == true) {
                          // tempDisconnectionController.fnSaveMeterReading();
                        } else {
                          // tempDisconnectionController.clearAll();
                          tempDisconnectionController.isEditModeEnabled(true);
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 95,
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryBlueColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Center(
                          child: Obx(() {
                            return AutoSizeText(
                              //        contractController.isEditModeEnabled.value ? "Save" :
                              tempDisconnectionController.isEditModeEnabled.value ? "Save" : "Add",
                              maxLines: 1,
                              minFontSize: 12, // Ensures the text is still readable
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
                  Bounce(
                      duration: const Duration(milliseconds: 100),
                      onPressed: () {
                        // Get.to(() => ContractReceiptPagesExe(
                        //   isFromContractPage: true,
                        // ));
                      },
                      child: Container(
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(color: ThemeColors.primaryGreenColor, borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "Generate Invoice",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),

            ///BODY///
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: SingleChildScrollView(
                  child: Obx(
                    () => Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 15,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        ///MAIN PART//////

                        SizedBox(
                          width: Get.width > 1300 ? Get.width - 500 : Get.width,
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
                                          "Contract No",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .23 < 230 ? 230 : Get.width * .23,
                                          child: CustomSearchField(
                                            hintLabel: "Contract No",
                                            controller: tempDisconnectionController.txtContractNoController,
                                            fieldColor: ThemeColors.primaryBlueColor,
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            onSearchTap: () {
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
                                          "Building Code",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .23 < 230 ? 230 : Get.width * .23,
                                          child: PrimaryInputField(
                                            txtController: tempDisconnectionController.txtBuildingCodeController,
                                            // fieldColor: ThemeColors.primaryBlueColor,
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,

                                            onChanged: (p0) {},
                                            hintText: "Building Code",
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
                                          child: PrimaryInputField(
                                            hintText: "Apartment Code",
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            txtController: tempDisconnectionController.txtApartmentCodeController,
                                            onChanged: (p0) {},
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              gapHC(10),
                              Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
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
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            txtController: tempDisconnectionController.txtBuildingNameController,
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
                                          "Tenant Name",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .3 < 230 ? 230 : Get.width * .3,
                                          child: PrimaryInputField(
                                            hintText: "Tenant Name",
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            txtController: tempDisconnectionController.txtTenantNameController,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 230,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Last Reading Date",
                                                style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Text(
                                                    tempDisconnectionController.lastReadingDate.value != null && tempDisconnectionController.lastReadingDate.value!.isNotEmpty
                                                        ? Helper.convertDateFormat1(dateTime: tempDisconnectionController.lastReadingDate.value!)
                                                        : Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
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
                                ],
                              ),
                              gapHC(30),
                              Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.0, bottom: 5),
                                        child: Text(
                                          "Branch",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                          child: CustomSearchField(
                                            hintLabel: "Branch",
                                            fieldColor: ThemeColors.primaryBlueColor,
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            hintSize: 12,
                                            onSearchTap: () {
                                              if (tempDisconnectionController.isEditModeEnabled.value) {
                                                List searchColumn = [
                                                  {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                                  {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                                ];
                                                Get.dialog(
                                                  barrierDismissible: false,
                                                  lookUpDialogueExe(
                                                    tableName: "BRANCHMAST",
                                                    filter: [],
                                                    callBackFn: (value) {
                                                      // contractController.txtBranchController.text = value["CODE"].toString();
                                                      Get.back();
                                                    },
                                                    searchColumn: searchColumn,
                                                  ),
                                                );
                                              }
                                            },
                                            controller: tempDisconnectionController.txtBranch,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0, bottom: 5),
                                        child: Text(
                                          "Division",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                          child: CustomSearchField(
                                            hintLabel: "Division",
                                            fieldColor: ThemeColors.primaryBlueColor,
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            hintSize: 12,
                                            onSearchTap: () {
                                              if (tempDisconnectionController.isEditModeEnabled.value) {
                                                List searchColumn = [
                                                  {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                                  {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                                ];
                                                Get.dialog(
                                                  barrierDismissible: false,
                                                  lookUpDialogueExe(
                                                    tableName: "DIVISIONMASTER",
                                                    filter: [],
                                                    callBackFn: (value) {
                                                      tempDisconnectionController.txtDivision.text = value["CODE"].toString();
                                                      Get.back();
                                                    },
                                                    searchColumn: searchColumn,
                                                  ),
                                                );
                                              }
                                            },
                                            controller: tempDisconnectionController.txtDivision,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.0, bottom: 5),
                                        child: Text(
                                          "Cost Center",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .18 < 230 ? 230 : Get.width * .18,
                                          child: CustomSearchField(
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            hintLabel: "Cost Center",
                                            onSearchTap: () {
                                              if (tempDisconnectionController.isEditModeEnabled.value) {
                                                List searchColumn = [
                                                  {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                                  {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                                ];
                                                Get.dialog(
                                                  barrierDismissible: false,
                                                  lookUpDialogueExe(
                                                    tableName: "CCMAST",
                                                    callBackFn: (value) {
                                                      tempDisconnectionController.txtCostCenter.text = value["CODE"].toString();
                                                      Get.back();
                                                    },
                                                    filter: [
                                                      {'Column': "CCTYPE", 'Operator': '=', 'Value': "D", 'JoinType': 'AND'},
                                                    ],
                                                    searchColumn: searchColumn,
                                                  ),
                                                );
                                              }
                                            },
                                            fieldColor: ThemeColors.primaryBlueColor,
                                            hintSize: 12,
                                            controller: tempDisconnectionController.txtCostCenter,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              gapHC(10),
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
                                          "Ref 1",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                                          child: PrimaryInputField(
                                            hintText: "Ref 1",
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            txtController: tempDisconnectionController.ref1,
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
                                          "Ref 2",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                                          child: PrimaryInputField(
                                            hintText: "Ref 2",
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            txtController: tempDisconnectionController.ref2,
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
                                          "Ref 3",
                                          style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                                          child: PrimaryInputField(
                                            hintText: "Ref 3",
                                            enablests: tempDisconnectionController.isEditModeEnabled.value,
                                            txtController: tempDisconnectionController.ref3,
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
                                      "Remarks",
                                      style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(
                                      width: Get.width * .23 < 200 ? 200 : Get.width * .23,
                                      child: PrimaryInputField(
                                        hintText: "Remarks",
                                        isTextArea: true,
                                        enablests: tempDisconnectionController.isEditModeEnabled.value,
                                        txtController: tempDisconnectionController.remarks,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),

                        ///INVOICE PART?//////
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
