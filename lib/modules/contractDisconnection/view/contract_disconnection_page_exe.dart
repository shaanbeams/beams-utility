import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contractDisconnection/controller/contract_disconnection_controller.dart';
import 'package:gas_utility_app/support/common_widgets/bottom_nav_exe.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/common_widgets/gap.dart';
import '../../../support/common_widgets/lookup_search_field.dart';
import '../../../support/common_widgets/primary_button.dart';
import '../../../support/common_widgets/primary_text_field.dart';
import '../../home/view/home_page_exe.dart';

class ContractDisconnectionPageExe extends StatefulWidget {
  const ContractDisconnectionPageExe({super.key, this.isFromReadingPage = false});

  final bool isFromReadingPage;

  @override
  State<ContractDisconnectionPageExe> createState() => _ContractDisconnectionPageExeState();
}

class _ContractDisconnectionPageExeState extends State<ContractDisconnectionPageExe> {
  late ValueNotifier<TabController> tabController;

  PageController pageController = PageController();

  ContractDisconnectionController contractDisconnectionController = Get.put(ContractDisconnectionController(), permanent: true);
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

    contractDisconnectionController.fnGetLastContractDisconnection(mode: "LAST", docNo: "");
    fnGetGasDocMaster(docType: Global.selectedDocType).then(
      (value) {
        Global.ccCode = value[0]["CCCODE"];
        Global.divCode = value[0]["DIVCODE"];
        Global.brnCode = value[0]["BRNCODE"];
      },
    );
    // }

    contractDisconnectionController.getDeductionCharges();
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
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: cBottomNav(Get.height * .04),
        floatingActionButton: Obx(() => contractDisconnectionController.isEditModeEnabled.value == true
            ? Container()
            : Padding(
                padding: EdgeInsets.all(Get.width * .01),
                child: Bounce(
                  onPressed: () {
                    if (contractDisconnectionController.floatingIsExpanded.value == true) {
                      contractDisconnectionController.floatingIsExpanded(false);
                    } else {
                      contractDisconnectionController.floatingIsExpanded(true);
                    }
                  },
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(contractDisconnectionController.floatingIsExpanded.value ? 80 : 15),
                      color: ThemeColors.primaryBlueColor,
                    ),
                    height: contractDisconnectionController.floatingIsExpanded.value
                        ? Get.width * .1 > 80
                            ? 80
                            : Get.width * .08
                        : Get.width * .1 > 80 || Get.height < 80
                            ? 350
                            : Get.width * .4,
                    width: Get.width * .1 > 80 ? 80 : Get.width * .08,
                    child: contractDisconnectionController.floatingIsExpanded.value
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
                                    contractDisconnectionController.fnGetLastContractDisconnection(mode: "FIRST", docNo: "");
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
                                    contractDisconnectionController.fnGetLastContractDisconnection(mode: "PREVIOUS", docNo: contractDisconnectionController.txtDocNumController.text);
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
                                    contractDisconnectionController.fnGetLastContractDisconnection(mode: "NEXT", docNo: contractDisconnectionController.txtDocNumController.text);
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
                                    contractDisconnectionController.fnGetLastContractDisconnection(mode: "LAST", docNo: "");
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
                        "assets/icons/discoonection.PNG",
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
                                  "Contract Disconnection",
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
                                      controller: contractDisconnectionController.txtDocNumController,
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
                                        //       contractDisconnectionController.txtReqDocNo.text = value["DOCNO"];
                                        //       contractDisconnectionController.fngetLastContractDetails(mode: "VIEW", docNo: value["DOCNO"]);
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
                                    widget.isFromReadingPage == true || contractDisconnectionController.docdate.value == null
                                        ? Text(
                                            widget.isFromReadingPage == true
                                                ? Helper.convertDateFormat2(dateTime: DateTime.now().toString())
                                                : contractDisconnectionController.docdate.value != null
                                                    ? Helper.convertDateFormat1(dateTime: contractDisconnectionController.docdate.value!)
                                                    : Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
                                            style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: Get.width * .19 > 200 ? 16 : 12, fontWeight: FontWeight.normal),
                                          )
                                        : Obx(
                                            () => Text(
                                              Helper.convertDateFormat1(dateTime: contractDisconnectionController.docdate.value!),
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
                    return contractDisconnectionController.isEditModeEnabled.value
                        ? Bounce(
                            duration: const Duration(milliseconds: 100),
                            onPressed: () {
                              contractDisconnectionController.isEditModeEnabled(false);
                              contractDisconnectionController.fnGetLastContractDisconnection(mode: "LAST", docNo: "");
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
                                                      // contractDisconnectionController.fnDeleteGasInvoiceReceipt();
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
                        if (contractDisconnectionController.isEditModeEnabled.value == true) {
                          // contractDisconnectionController.fnSaveMeterReading();
                        } else {
                          // contractDisconnectionController.clearAll();
                          contractDisconnectionController.isEditModeEnabled(true);
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
                              contractDisconnectionController.isEditModeEnabled.value ? "Save" : "Add",
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
            gapHC(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: SingleChildScrollView(
                  child: Obx(
                    () => Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 15,
                      spacing: 50,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        ///MAIN PART//////

                        SizedBox(
                          width: Get.width > 1300 ? Get.width - 1200 : Get.width,
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
                                crossAxisAlignment: WrapCrossAlignment.center,
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
                                            controller: contractDisconnectionController.txtContractNoController,
                                            fieldColor: ThemeColors.primaryBlueColor,
                                            enablests: contractDisconnectionController.isEditModeEnabled.value,
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
                                            txtController: contractDisconnectionController.txtBuildingCodeController,
                                            // fieldColor: ThemeColors.primaryBlueColor,
                                            enablests: contractDisconnectionController.isEditModeEnabled.value,

                                            onChanged: (p0) {},
                                            hintText: "Building Code",
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
                                                    contractDisconnectionController.lastReadingDate.value != null && contractDisconnectionController.lastReadingDate.value!.isNotEmpty
                                                        ? Helper.convertDateFormat1(dateTime: contractDisconnectionController.lastReadingDate.value!)
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
                                            enablests: contractDisconnectionController.isEditModeEnabled.value,
                                            txtController: contractDisconnectionController.txtApartmentCodeController,
                                            onChanged: (p0) {},
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Connection Date",
                                                style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Text(
                                                    contractDisconnectionController.connectionDate.value != null && contractDisconnectionController.connectionDate.value!.isNotEmpty
                                                        ? Helper.convertDateFormat1(dateTime: contractDisconnectionController.connectionDate.value!)
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
                                            enablests: contractDisconnectionController.isEditModeEnabled.value,
                                            txtController: contractDisconnectionController.txtBuildingNameController,
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
                                            enablests: contractDisconnectionController.isEditModeEnabled.value,
                                            txtController: contractDisconnectionController.txtTenantNameController,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              gapHC(30),
                            ],
                          ),
                        ),

                        ///Deduction Details?//////
                        SizedBox(
                          width: Get.width > 1300 ? 500 : Get.width,
                          // ConstrainedBox(
                          // constraints: BoxConstraints(maxWidth: Get.width * .35 < 600 ? 600 : Get.width * .35, minWidth: 600),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      "Deduction Details",
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
                                          flex: 3,
                                          child: Container(),
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
                                      itemCount: contractDisconnectionController.deductionChargeRows.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Obx(
                                            () => _amountDetailsItem(
                                              headValue: contractDisconnectionController.deductionChargeRows[index].name,
                                              amountValueController: contractDisconnectionController.deductionChargeRows[index].txtCurrentAmt,
                                              vatPercController: contractDisconnectionController.deductionChargeRows[index].taxPerc.toString(),
                                              vatAmountController: contractDisconnectionController.deductionChargeRows[index].currTaxAmount.value.toStringAsFixed(3),
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
                                              _tHead(title: "Total Amount", color: ThemeColors.primaryBlueColor),
                                              const Spacer(),
                                              // Obx(
                                              //   () => Text(
                                              //     textAlign: TextAlign.center,
                                              //     gasMeterReadingInvoiceController.totalCurrAmount.value.toStringAsFixed(2),
                                              //     style: GoogleFonts.poppins(
                                              //       color: ThemeColors.black,
                                              //       fontSize: 13,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _tHead(title: "Total Tax Amount", color: ThemeColors.primaryBlueColor),
                                              const Spacer(),
                                              // Obx(
                                              //   () => Text(
                                              //     textAlign: TextAlign.center,
                                              //     gasMeterReadingInvoiceController.totalCurrTaxAmount.value.toStringAsFixed(2),
                                              //     style: GoogleFonts.poppins(
                                              //       color: ThemeColors.black,
                                              //       fontSize: 13,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _tHead(title: "Net Amount (Inc Tax)", color: ThemeColors.primaryBlueColor),
                                              const Spacer(),
                                              // Obx(
                                              //   () => Text(
                                              //     textAlign: TextAlign.center,
                                              //     gasMeterReadingInvoiceController.netAmount.value.toStringAsFixed(2),
                                              //     style: GoogleFonts.poppins(
                                              //       color: ThemeColors.black,
                                              //       fontSize: 13,
                                              //     ),
                                              //   ),
                                              // ),
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

                        ///INVOICE PART?//////
                        SizedBox(
                          width: Get.width > 1300 ? 500 : Get.width,
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
                                          flex: 3,
                                          child: Container(),
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
                                      itemCount: contractDisconnectionController.chargeRows.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Obx(
                                            () => _amountDetailsItem(
                                              headValue: contractDisconnectionController.chargeRows[index].name,
                                              amountValueController: contractDisconnectionController.chargeRows[index].txtCurrentAmt,
                                              vatPercController: contractDisconnectionController.chargeRows[index].taxPerc.toString(),
                                              vatAmountController: contractDisconnectionController.chargeRows[index].currTaxAmount.value.toStringAsFixed(3),
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
                                              // Obx(
                                              //   () => Text(
                                              //     textAlign: TextAlign.center,
                                              //     gasMeterReadingInvoiceController.totalCurrAmount.value.toStringAsFixed(2),
                                              //     style: GoogleFonts.poppins(
                                              //       color: ThemeColors.black,
                                              //       fontSize: 13,
                                              //     ),
                                              //   ),
                                              // ),
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
                                              // Obx(
                                              //   () => Text(
                                              //     textAlign: TextAlign.center,
                                              //     gasMeterReadingInvoiceController.totalCurrTaxAmount.value.toStringAsFixed(2),
                                              //     style: GoogleFonts.poppins(
                                              //       color: ThemeColors.black,
                                              //       fontSize: 13,
                                              //     ),
                                              //   ),
                                              // ),
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
                                              // Obx(
                                              //   () => Text(
                                              //     textAlign: TextAlign.center,
                                              //     gasMeterReadingInvoiceController.netAmount.value.toStringAsFixed(2),
                                              //     style: GoogleFonts.poppins(
                                              //       color: ThemeColors.black,
                                              //       fontSize: 13,
                                              //     ),
                                              //   ),
                                              // ),
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

Text _tHead({required String title, Color? color}) {
  return Text(
    title,
    style: GoogleFonts.poppins(color: color ?? ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold),
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
            widget.pageController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
                    color: widget.tabController.value.index == 0 ? Colors.white : Colors.black,
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
                    color: widget.tabController.value.index == 1 ? Colors.white : Colors.black,
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
    required this.headValue,
    required this.amountValueController,
    required this.vatAmountController,
    required this.vatPercController,
  });

  final String headValue;
  final TextEditingController amountValueController;
  String vatAmountController, vatPercController;
  ContractDisconnectionController contractDisconnectionController = Get.find();

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
          child:
              PrimaryInputField(enablests: contractDisconnectionController.isEditModeEnabled.value, hintText: "", txtRadius: 10, txtController: amountValueController, textType: TextInputType.number)),
      gapWC(10),
      Expanded(flex: 1, child: PrimaryInputField(enablests: false, hintText: "", txtRadius: 10, txtController: TextEditingController(text: vatPercController), textType: TextInputType.number)),
      gapWC(10),
      Expanded(flex: 2, child: PrimaryInputField(enablests: false, hintText: "", txtRadius: 10, txtController: TextEditingController(text: vatAmountController), textType: TextInputType.number))
    ]);
  }
}
