import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract%20receipt/controller/contract_receipt_controller.dart';
import 'package:gas_utility_app/support/common_widgets/bottom_nav_exe.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/common_widgets/gap.dart';
import '../../../support/common_widgets/lookup_search_field.dart';
import '../../../support/common_widgets/primary_button.dart';
import '../../../support/global.dart';
import '../../../support/helper.dart';
import '../../home/view/home_page_exe.dart';
import '../../lookup/view/look_up_dialogue_exe.dart';

class ContractReceiptPagesExe extends StatefulWidget {
  const ContractReceiptPagesExe({super.key, this.isFromContractPage = false, this.contractNo});

  final bool isFromContractPage;
  final String? contractNo;

  @override
  State<ContractReceiptPagesExe> createState() => _ContractReceiptPagesExeState();
}

class _ContractReceiptPagesExeState extends State<ContractReceiptPagesExe> {
  final contractReceiptController = Get.put(ContractReceiptController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get.dialog(
      //     barrierDismissible: false,
      //     AlertDialog(content: Lottie.asset("assets/lotties/loader.json")));
    });
    contractReceiptController.isInProgress.value = true;
    if (widget.isFromContractPage == false) {
      contractReceiptController.fngetLastContractDetails(mode: "LAST", docNo: "");
    } else {
      fnGetGasDocMaster(docType: Global.selectedDocType).then(
        (value) {
          Global.ccCode = value[0]["CCCODE"];
          Global.divCode = value[0]["DIVCODE"];
          Global.brnCode = value[0]["BRNCODE"];
        },
      );
      contractReceiptController.getContractReceipt(contractNo: widget.contractNo ?? "");
    }

    contractReceiptController.isEditModeEnabled.value = widget.isFromContractPage == true;
    super.initState();
  }

  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: cBottomNav(Get.height * .04),
        floatingActionButton: Obx(() => contractReceiptController.isEditModeEnabled.value == true
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: Get.width * .01, bottom: Get.width * .01),
                child: Bounce(
                  onPressed: () {
                    if (contractReceiptController.floatingIsExpanded.value == true) {
                      contractReceiptController.floatingIsExpanded(false);
                    } else {
                      contractReceiptController.floatingIsExpanded(true);
                    }
                  },
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(contractReceiptController.floatingIsExpanded.value ? 80 : 15),
                      color: ThemeColors.primaryBlueColor,
                    ),
                    height: contractReceiptController.floatingIsExpanded.value
                        ? Get.width * .1 > 80
                            ? 80
                            : Get.width * .08
                        : Get.width * .1 > 80 || Get.height < 80
                            ? 350
                            : Get.width * .4,
                    width: Get.width * .1 > 80 ? 80 : Get.width * .08,
                    child: contractReceiptController.floatingIsExpanded.value
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
                                    contractReceiptController.fngetLastContractDetails(mode: "FIRST", docNo: "");
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
                                    contractReceiptController.fngetLastContractDetails(mode: "PREVIOUS", docNo: contractReceiptController.selectedContractReceiptFill.docno ?? "0");
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
                                        "assets/icons/edit.png",
                                        height: Get.width * .1 > 80 || Get.height < 80 ? 35 : Get.width * .04,
                                        color: Colors.white,
                                      )),
                                ),
                                Bounce(
                                  duration: Duration(milliseconds: 100),
                                  onPressed: () {
                                    // contractController.fngetLastContractDetails(mode: "NEXT", docNo: contractController.txtcontractNoController.text);
                                    contractReceiptController.fngetLastContractDetails(mode: "NEXT", docNo: contractReceiptController.selectedContractReceiptFill.docno ?? "0");
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
                                    contractReceiptController.fngetLastContractDetails(mode: "LAST", docNo: "");
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
                        "assets/icons/contract_receipt.png",
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
                                padding: const EdgeInsets.only(left: 0, right: 20),
                                child: Text(
                                  "Contract Receipt",
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
                                      controller: contractReceiptController.txtReqDocNo,
                                      onSearchTap: () {
                                        List searchColumn = [
                                          {"showItem": true, "columnName": "DOCNO", "showName": "Document No"},
                                          {"showItem": true, "columnName": "CONTRACT_NO", "showName": "Contract No"},
                                          {"showItem": true, "columnName": "PARTYNAME", "showName": "Party Name"},
                                          {"showItem": true, "columnName": "BUILDING_CODE", "showName": "Building Code"},
                                          {"showItem": true, "columnName": "APARTMENT_CODE", "showName": "Apartment Code"},
                                        ];
                                        Get.dialog(
                                          lookUpDialogueExe(
                                            callBackFn: (value) {
                                              // contractController.txtcontractNoController.text = value["CONTRACT_NO"].toString();
                                              contractReceiptController.txtReqDocNo.text = value["DOCNO"];
                                              contractReceiptController.fngetLastContractDetails(mode: "VIEW", docNo: value["DOCNO"]);
                                              Get.back();
                                            },
                                            tableName: "GGASCONTRACTREC",
                                            filter: [],
                                            searchColumn: searchColumn,
                                          ),
                                        );
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
                                    widget.isFromContractPage
                                        ? Text(
                                            Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
                                            style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 16 : 12, fontWeight: FontWeight.normal),
                                          )
                                        : Obx(
                                            () => Text(
                                              widget.isFromContractPage == true
                                                  ? Helper.convertDateFormat2(dateTime: DateTime.now().toString())
                                                  : contractReceiptController.docdate.value != null
                                                      ? Helper.convertDateFormat1(dateTime: contractReceiptController.docdate.value!)
                                                      : Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
                                              style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 16 : 12, fontWeight: FontWeight.normal),
                                            ),
                                          ),
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
                                        contractReceiptController.netAmount.value.toStringAsFixed(2),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Scrollbar(
                  radius: const Radius.circular(10),
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapHC(Get.height * .01),
                          Obx(() => Row(
                                children: [
                                  Expanded(
                                    child: contractReceiptController.isInProgress.value == true
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(30),
                                            child: Shimmer.fromColors(
                                              baseColor: ThemeColors.primaryBlueColor,
                                              highlightColor: ThemeColors.primaryRedColor,
                                              child: Container(
                                                height: 90,
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    gradient: ThemeGradient.gradient,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.6),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: const Offset(0, 5),
                                                      ),
                                                    ],
                                                    borderRadius: BorderRadius.circular(30)),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 90,
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                gradient: ThemeGradient.gradient,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.6),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 5),
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.circular(30)),
                                            child: Obx(
                                              () => Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        _tHead(
                                                          title: "Contract No . ",
                                                        ),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: _tValue(
                                                            value: contractReceiptController.selectedcontractReceipt.value?.contractNo?.value ?? "",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        _tHead(
                                                          title: "Tenant Name",
                                                        ),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: _tValue(
                                                            value: contractReceiptController.selectedcontractReceipt.value?.partyname?.value ?? "",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        _tHead(
                                                          title: "Building No : ",
                                                        ),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: _tValue(
                                                            value: contractReceiptController.selectedcontractReceipt.value?.buildingCode?.value ?? "",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        _tHead(
                                                          title: "Apartment No : ",
                                                        ),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: _tValue(
                                                            value: contractReceiptController.selectedcontractReceipt.value?.apartmentCode?.value ?? "",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        _tHead(
                                                          title: "Building Name",
                                                        ),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: _tValue(
                                                            value: contractReceiptController.selectedcontractReceipt.value?.buildingDescp?.value ?? "",
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
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Invoice Details",
                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                const Icon(Icons.info_outline),
                                const Spacer(),
                                Obx(
                                  () => contractReceiptController.isEditModeEnabled.value
                                      ? SizedBox(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Bounce(
                                                onPressed: () {
                                                  contractReceiptController.fnSaveContractReceipt();
                                                },
                                                duration: Duration(milliseconds: 100),
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  width: 120,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ThemeColors.primaryGreenColor,
                                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.9),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: const Offset(0, 5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Text(
                                                    "Save",
                                                    style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              gapWC(10),
                                              Bounce(
                                                duration: Duration(milliseconds: 100),
                                                onPressed: () {
                                                  contractReceiptController.fngetLastContractDetails(mode: "LAST", docNo: "");
                                                  contractReceiptController.isEditModeEnabled(false);
                                                },
                                                child: Container(
                                                  width: 120,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ThemeColors.primaryRedColor,
                                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.9),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: const Offset(0, 5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Text(
                                                    "Cancel",
                                                    style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Obx(() => SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Bounce(
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
                                                                  "Are you sure want to delete contract receipt?",
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
                                                                            contractReceiptController.fnDeleteContractReceipt();
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
                                                  duration: Duration(milliseconds: 100),
                                                  child: contractReceiptController.isInProgress.value == true
                                                      ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(30),
                                                          child: Shimmer.fromColors(
                                                              baseColor: ThemeColors.grey.withOpacity(0.5),
                                                              highlightColor: ThemeColors.grey.withOpacity(0.3),
                                                              child: Container(
                                                                  width: 120,
                                                                  height: 100,
                                                                  decoration: BoxDecoration(
                                                                    color: ThemeColors.primaryRedColor,
                                                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors.grey.withOpacity(0.9),
                                                                        spreadRadius: 2,
                                                                        blurRadius: 5,
                                                                        offset: const Offset(0, 5),
                                                                      ),
                                                                    ],
                                                                  ))),
                                                        )
                                                      : Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                                          width: 120,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: ThemeColors.primaryRedColor,
                                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.9),
                                                                spreadRadius: 2,
                                                                blurRadius: 5,
                                                                offset: const Offset(0, 5),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Text(
                                                            "Delete",
                                                            style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                ),
                                                gapWC(10),
                                                contractReceiptController.isInProgress.value == true
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(30),
                                                        child: Shimmer.fromColors(
                                                            baseColor: ThemeColors.grey.withOpacity(0.5),
                                                            highlightColor: ThemeColors.grey.withOpacity(0.3),
                                                            child: Container(
                                                                width: 120,
                                                                height: 100,
                                                                decoration: BoxDecoration(
                                                                  color: ThemeColors.primaryRedColor,
                                                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors.grey.withOpacity(0.9),
                                                                      spreadRadius: 2,
                                                                      blurRadius: 5,
                                                                      offset: const Offset(0, 5),
                                                                    ),
                                                                  ],
                                                                ))),
                                                      )
                                                    : Bounce(
                                                        onPressed: () {
                                                          Get.dialog(
                                                              barrierDismissible: true,
                                                              AlertDialog(
                                                                backgroundColor: Colors.transparent,
                                                                content: ConstrainedBox(
                                                                  constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child: Lottie.asset("assets/lotties/loader4.json"),
                                                                  ),
                                                                ),
                                                              ));
                                                        },
                                                        duration: Duration(milliseconds: 100),
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                                          decoration: BoxDecoration(
                                                            color: ThemeColors.primaryBlueColor,
                                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.9),
                                                                spreadRadius: 2,
                                                                blurRadius: 5,
                                                                offset: const Offset(0, 5),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Print",
                                                                style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                                              ),
                                                              SizedBox(
                                                                height: 24,
                                                                child: Image.asset("assets/icons/Printer.png"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                          )),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: Get.height * .04,
                            decoration: BoxDecoration(
                              gradient: ThemeGradient.gradient,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                gapWC(40),
                                Expanded(
                                  flex: 3,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.start,
                                    "",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    "Amount",
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    "Amt Received",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    "Curr Amount",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    "Curr Tax Amount",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    "Total",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                gapWC(10),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    "Balance",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          gapHC(15),
                          Obx(
                            () => contractReceiptController.isInProgress.value == true
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 20,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Shimmer.fromColors(
                                            baseColor: ThemeColors.grey,
                                            highlightColor: ThemeColors.grey.withOpacity(0.3),
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: ThemeColors.primaryGrayColor, borderRadius: BorderRadius.circular(30)),
                                              child: Container(
                                                height: 50,
                                                color: ThemeColors.primaryGrayColor,
                                                child: Text("   "),
                                              ),
                                            )),
                                      );
                                    })
                                : ListView.builder(
                                    itemCount: contractReceiptController.chargeRows.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final chargeRow = contractReceiptController.chargeRows[index];

                                      ///Node Function///
                                      chargeRow.focusNode.addListener(() {
                                        if (!chargeRow.focusNode.hasFocus) {
                                          contractReceiptController.checkNodeFocus(index);
                                        }
                                      });
                                      return Obx(
                                        () => Container(
                                          height: Get.height * .045,
                                          decoration: BoxDecoration(
                                            color: index % 2 == 0 ? ThemeColors.white : ThemeColors.primaryGrayColor,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              gapWC(40),
                                              Expanded(
                                                flex: 3,
                                                child: AutoSizeText(
                                                  textAlign: TextAlign.start,
                                                  contractReceiptController.chargeRows[index].name,
                                                  maxLines: 1,
                                                  style: GoogleFonts.poppins(
                                                    color: ThemeColors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              gapWC(10),
                                              Expanded(
                                                flex: 2,
                                                child: AutoSizeText(
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  contractReceiptController.chargeRows[index].amount.toStringAsFixed(2),
                                                  style: GoogleFonts.poppins(
                                                    color: ThemeColors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              gapWC(10),
                                              Expanded(
                                                flex: 2,
                                                child: AutoSizeText(
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  contractReceiptController.chargeRows[index].amountReceived.toStringAsFixed(2),
                                                  style: GoogleFonts.poppins(
                                                    color: ThemeColors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              gapWC(10),

                                              ///TEXT FIELD///
                                              Expanded(
                                                flex: 2,
                                                child: contractReceiptController.isEditModeEnabled.value
                                                    ? Container(
                                                        margin: EdgeInsets.only(top: 3, bottom: 3),
                                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                                        decoration: boxOutlineDecoration(Colors.transparent, 10),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: TextFormField(
                                                                autofocus: true,
                                                                cursorColor: ThemeColors.black,
                                                                maxLines: 1,
                                                                controller: contractReceiptController.chargeRows[index].txtCurrentAmt,
                                                                focusNode: contractReceiptController.chargeRows[index].focusNode,
                                                                onChanged: (value) {
                                                                  contractReceiptController.fnEnterCrntAmt(value, index);
                                                                },
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(fontSize: 13),
                                                                decoration: const InputDecoration(
                                                                  counterText: "",
                                                                  helperStyle: TextStyle(fontSize: 13),
                                                                  hintText: "0.00",
                                                                  border: InputBorder.none,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : AutoSizeText(
                                                        maxLines: 1,
                                                        textAlign: TextAlign.center,
                                                        contractReceiptController.chargeRows[index].currentAmt.value.toStringAsFixed(2),
                                                        style: GoogleFonts.poppins(
                                                          color: ThemeColors.black,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                              ),
                                              gapWC(10),
                                              Expanded(
                                                flex: 2,
                                                child: AutoSizeText(
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  contractReceiptController.chargeRows[index].currTaxAmount.toStringAsFixed(2),
                                                  style: GoogleFonts.poppins(
                                                    color: ThemeColors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              gapWC(10),

                                              Expanded(
                                                flex: 2,
                                                child: Obx(
                                                  () => AutoSizeText(
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    contractReceiptController.chargeRows[index].total.toStringAsFixed(2),
                                                    style: GoogleFonts.poppins(
                                                      color: ThemeColors.black,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              gapWC(10),
                                              Expanded(
                                                flex: 2,
                                                child: Obx(
                                                  () => AutoSizeText(
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    contractReceiptController.chargeRows[index].balance.toStringAsFixed(2),
                                                    style: GoogleFonts.poppins(
                                                      color: ThemeColors.black,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          gapHC(2),
                          const Divider(
                            thickness: 1,
                            color: ThemeColors.black,
                          ),
                          Obx(() => contractReceiptController.isInProgress.value == true
                              ? Container()
                              : Container(
                                  height: Get.height * .06,
                                  decoration: BoxDecoration(
                                    color: ThemeColors.primaryGrayColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      gapWC(40),
                                      Expanded(
                                        flex: 3,
                                        child: AutoSizeText(
                                          textAlign: TextAlign.start,
                                          "Total",
                                          maxLines: 1,
                                          style: GoogleFonts.poppins(
                                            color: ThemeColors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      gapWC(10),
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => AutoSizeText(
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            contractReceiptController.totalBillAmount.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      gapWC(10),
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => AutoSizeText(
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            contractReceiptController.totalBillAmountRec.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      gapWC(10),
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => AutoSizeText(
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            contractReceiptController.totalCurrAmount.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      gapWC(10),
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => AutoSizeText(
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            contractReceiptController.totalCurrTaxAmount.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      gapWC(10),
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => AutoSizeText(
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            contractReceiptController.totalAmount.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      gapWC(10),
                                      Expanded(
                                        flex: 2,
                                        child: Obx(
                                          () => AutoSizeText(
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            contractReceiptController.totalBalanceAmount.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          gapHC(30),
                          Container(
                            height: Get.height * .05,
                            decoration: BoxDecoration(
                              color: ThemeColors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: Get.width * .2 < 250 ? 8 : 11, child: Container()),
                                Expanded(
                                    flex: Get.width * .2 < 250 ? 5 : 2,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            textAlign: TextAlign.start,
                                            "Total Current Amount",
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                gapWC(90),
                                Expanded(
                                  flex: 2,
                                  child: Obx(
                                    () => Text(
                                      textAlign: TextAlign.center,
                                      contractReceiptController.totalCurrAmount.value.toStringAsFixed(2),
                                      style: GoogleFonts.poppins(
                                        color: ThemeColors.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: Get.height * .05,
                            decoration: BoxDecoration(
                              color: ThemeColors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: Get.width * .2 < 250 ? 8 : 11, child: Container()),
                                Expanded(
                                    flex: Get.width * .2 < 250 ? 5 : 2,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            textAlign: TextAlign.start,
                                            "Total Current Tax",
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                gapWC(90),
                                Expanded(
                                  flex: 2,
                                  child: Obx(
                                    () => Text(
                                      textAlign: TextAlign.center,
                                      contractReceiptController.totalCurrTaxAmount.value.toStringAsFixed(2),
                                      style: GoogleFonts.poppins(
                                        color: ThemeColors.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: Get.height * .05,
                            decoration: BoxDecoration(
                              color: ThemeColors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: Get.width * .2 < 250 ? 8 : 11, child: Container()),
                                Expanded(
                                    flex: Get.width * .2 < 250 ? 5 : 2,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            textAlign: TextAlign.start,
                                            "Net Amount (Inc Tax)",
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                gapWC(90),
                                Expanded(
                                  flex: 2,
                                  child: Obx(
                                    () => Text(
                                      textAlign: TextAlign.center,
                                      contractReceiptController.netAmount.value.toStringAsFixed(2),
                                      style: GoogleFonts.poppins(
                                        color: ThemeColors.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: ThemeColors.black,
                          ),
                          gapHC(30),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                            child: Text(
                              "Payment Method",
                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Wrap(
                            runSpacing: 20,
                            spacing: 15,
                            children: [
                              Obx(() {
                                return SizedBox(
                                  height: 30,
                                  width: 150,
                                  child: RadioMenuButton(
                                    style: const ButtonStyle(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    value: "Cash",
                                    onChanged: contractReceiptController.isEditModeEnabled.value == true
                                        ? (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                              contractReceiptController.txtCreditCard.clear();
                                              contractReceiptController.selectedPaymentMode.value = "CASH";
                                            });
                                          }
                                        : (s) {},
                                    groupValue: selectedOption,
                                    child: const Text("Cash"),
                                  ),
                                );
                              }),
                              Obx(() {
                                return SizedBox(
                                  width: 150,
                                  height: 30,
                                  child: RadioMenuButton(
                                    style: const ButtonStyle(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    value: "Credit card",
                                    onChanged: contractReceiptController.isEditModeEnabled.value == true
                                        ? (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                              contractReceiptController.selectedPaymentMode.value = "CREDITCARD";
                                            });
                                          }
                                        : (_) {},
                                    groupValue: selectedOption,
                                    child: const Text("Credit card"),
                                  ),
                                );
                              }),
                              SizedBox(
                                width: Get.width * .2,
                                child: Obx(() {
                                  return Visibility(
                                    visible: selectedOption == "Credit card",
                                    child: CustomSearchField(
                                      enablests: contractReceiptController.isEditModeEnabled.value,
                                      label: "Credit Card",
                                      labelYn: true,
                                      hintLabel: "Credit Card",
                                      fieldColor: ThemeColors.primaryBlueColor,
                                      hintSize: 11,
                                      onSearchTap: () {
                                        if (contractReceiptController.isEditModeEnabled.value == true) {
                                          List searchColumn = [
                                            {"showItem": true, "columnName": "CODE", "showName": "Code"},
                                            {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                                          ];
                                          Get.dialog(
                                            barrierDismissible: false,
                                            lookUpDialogueExe(
                                              tableName: "CREDITCARDMASTER",
                                              filter: [],
                                              callBackFn: (value) {
                                                if (value != null) {
                                                  Get.back();
                                                  contractReceiptController.txtCreditCard.text = value["CODE"].toString();
                                                }
                                              },
                                              searchColumn: searchColumn,
                                            ),
                                          );
                                        }
                                      },
                                      controller: contractReceiptController.txtCreditCard,
                                    ),
                                  );
                                }),
                              )
                              // SizedBox(
                              //   height: 30,
                              //   width: 150,
                              //   child: RadioMenuButton(
                              //     style: const ButtonStyle(
                              //       splashFactory: NoSplash.splashFactory,
                              //     ),
                              //     value: "Cheque",
                              //     onChanged: (value) {
                              //       selectedOption = value.toString();
                              //     },
                              //     groupValue: selectedOption,
                              //     child: const Text("Cheque"),
                              //   ),
                              // )
                            ],
                          ),
                          gapHC(100),
                        ],
                      ),
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

AutoSizeText _tHead({required String title, Color? color}) {
  return AutoSizeText(title, maxLines: 1, style: GoogleFonts.poppins(color: color ?? ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold));
}

AutoSizeText _tValue({required String value, Color? color}) {
  return AutoSizeText(value,
      maxLines: 2,
      style: GoogleFonts.poppins(
        color: color ?? ThemeColors.white,
        fontSize: 13,
      ));
}
