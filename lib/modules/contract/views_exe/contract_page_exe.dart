import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract%20receipt/controller/contract_receipt_controller.dart';
import 'package:gas_utility_app/modules/contract/views_exe/contract_main_details_page_exe.dart';
import 'package:gas_utility_app/modules/contract/views_exe/contract_other_details_page_exe.dart';
import 'package:gas_utility_app/modules/contract/views_exe/contract_request_page_exe.dart';
import 'package:gas_utility_app/modules/home/view/home_page_exe.dart';
import 'package:gas_utility_app/modules/home/view/widgets/select_doc_type_widget.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue_exe.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/bottom_nav_exe.dart';
import '../../../support/common_widgets/primary_button.dart';
import '../../assignUserList/controller/assign_user_controller.dart';
import '../../contract receipt/view/contract_receipt_page_exe.dart';
import '../controller/contract_controller.dart';

class ContractPageExe extends StatefulWidget {
  ContractPageExe({super.key, this.isFromAssignPage = false});
  final bool? isFromAssignPage;
  State<ContractPageExe> createState() => _ContractPageExeState();
}

class _ContractPageExeState extends State<ContractPageExe> {
  late ValueNotifier<TabController> tabController;
  // final contractReceiptController = Get.put(ContractReceiptController());
  PageController pageController = PageController();

  /////////////////////////
  ContractController contractController = Get.put(ContractController());

  AssignUserController assignUserController = Get.put(AssignUserController());

  // TextEditingController txtReqDocTypeController = TextEditingController();
  //
  // TextEditingController txtReqNoController = TextEditingController();

  /////////////////////////

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog();
    });
    if (widget.isFromAssignPage == false) {
      contractController.fnclear();
      contractController.fngetLastContractDetails(mode: "LAST", docNo: "");
    } else {
      contractController.fngetContractDetails();
    }

    contractController.isEditModeEnabled.value = widget.isFromAssignPage == true;
    //  txtReqNoController.text=contractController.selectedContract.value?.contractNo??"";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contractController = Get.put(ContractController());
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        floatingActionButton: Obx(() => Padding(
              padding: EdgeInsets.all(Get.width * .01),
              child: Bounce(
                onPressed: () {
                  if (contractController.floatingIsExpanded.value == true) {
                    contractController.floatingIsExpanded(false);
                  } else {
                    contractController.floatingIsExpanded(true);
                  }
                },
                duration: const Duration(milliseconds: 100),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(contractController.floatingIsExpanded.value ? 80 : 15),
                    color: ThemeColors.primaryBlueColor,
                  ),
                  height: contractController.floatingIsExpanded.value
                      ? Get.width * .1 > 80
                          ? 80
                          : Get.width * .08
                      : Get.width * .1 > 80 || Get.height < 80
                          ? 350
                          : Get.width * .4,
                  width: Get.width * .1 > 80 ? 80 : Get.width * .08,
                  child: contractController.floatingIsExpanded.value
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
                                  contractController.fngetLastContractDetails(mode: "FIRST", docNo: "");
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
                                  contractController.fngetLastContractDetails(mode: "PREVIOUS", docNo: contractController.txtcontractNoController.text);
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
                                  contractController.fngetLastContractDetails(mode: "NEXT", docNo: contractController.txtcontractNoController.text);
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
                                  contractController.fngetLastContractDetails(mode: "LAST", docNo: "");
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
              height: Get.height * .32 < 250 ? Get.height * .32 : 250,
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
                  borderRadius: BorderRadius.only(
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
                        "assets/icons/contract.png",
                        height: Get.width * .15 < 150 ? Get.width * .15 : 150,
                      ),
                    ],
                  ),
                  gapWC(20),
                  Expanded(
                    child: Column(
                      children: [
                        gapHC(Get.height * .05),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0, right: 20),
                                child: Text(
                                  "Contract",
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
                        gapHC(40),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0, bottom: 5),
                                  child: Text(
                                    "Request Doc Type",
                                    style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 13, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                    width: Get.width * .3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: PrimaryInputField(
                                        labelColor: ThemeColors.white,
                                        hintText: "Request Doc Type",
                                        enablests: false,
                                        txtController: contractController.txtReqDocTypeController,
                                      ),
                                    )),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0, bottom: 5),
                                  child: Text(
                                    "Contract No.",
                                    style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 13, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                    width: Get.width * .3,
                                    child: CustomSearchField(
                                      
                                      hintLabel: "Contract No.",
                                      enablests: widget.isFromAssignPage! ? false : true,
                                      controller: contractController.txtcontractNoController,
                                      onSearchTap: () {
                                        if (widget.isFromAssignPage == false) {
                                          List searchColumn = [
                                            {"showItem": true, "columnName": "CONTRACT_NO", "showName": "Contract No"},
                                            {"showItem": true, "columnName": "PARTYNAME", "showName": "Party Name"},
                                            {"showItem": true, "columnName": "BUILDING_CODE", "showName": "Building Code"},
                                            {"showItem": true, "columnName": "APARTMENT_CODE", "showName": "Apartment Code"},
                                          ];
                                          Get.dialog(
                                            lookUpDialogueExe(
                                              callBackFn: (value) {
                                                contractController.txtcontractNoController.text = value["CONTRACT_NO"].toString();
                                                contractController.fngetLastContractDetails(mode: "VIEW", docNo: contractController.txtcontractNoController.text);
                                                Get.back();
                                              },
                                              tableName: "GGASCONTRACT",
                                              filter: [],
                                              searchColumn: searchColumn,
                                            ),
                                          );
                                        }
                                      },
                                    )),
                              ],
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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        gapHC(Get.height * .06),
                        SizedBox(
                          width: Get.width * .13 < 180 ? 180 : Get.width * .13,
                          height: Get.height * .4,
                          child: Container(
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
                                borderRadius: BorderRadius.circular(50)),
                            height: 100,
                            width: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Bounce(
                                  onPressed: () {
                                    contractController.pageController.value.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                    contractController.selectedTabExe.value = 0;
                                    contractController.selectedTabString.value = "Connection Request Details";
                                  },
                                  duration: const Duration(milliseconds: 100),
                                  child: Obx(
                                    () => AutoSizeText(
                                      "Connection Request \nDetails",
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.white,
                                          fontSize: contractController.selectedTabExe.value == 0 ? 16 : 14,
                                          fontWeight: contractController.selectedTabExe.value == 0 ? FontWeight.bold : FontWeight.normal),
                                    ),
                                  ),
                                ),
                                Bounce(
                                  onPressed: () {
                                    contractController.pageController.value.animateToPage(
                                      1,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                    contractController.selectedTabExe.value = 1;
                                    contractController.selectedTabString.value = "Other Details";
                                  },
                                  duration: const Duration(milliseconds: 100),
                                  child: Obx(
                                    () => AutoSizeText(
                                      "Other Details",
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.white,
                                          fontSize: contractController.selectedTabExe.value == 1 ? 16 : 14,
                                          fontWeight: contractController.selectedTabExe.value == 1 ? FontWeight.bold : FontWeight.normal),
                                    ),
                                  ),
                                ),
                                Bounce(
                                  onPressed: () {
                                    contractController.pageController.value.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                    contractController.selectedTabExe.value = 2;
                                    contractController.selectedTabString.value = "Main Details";
                                  },
                                  duration: const Duration(milliseconds: 100),
                                  child: Obx(
                                    () => AutoSizeText(
                                      "Main Details",
                                      style: GoogleFonts.poppins(
                                          color: ThemeColors.white,
                                          fontSize: contractController.selectedTabExe.value == 2 ? 16 : 14,
                                          fontWeight: contractController.selectedTabExe.value == 2 ? FontWeight.bold : FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    gapWC(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width * .2 < 200 ? 120 : null,
                                  child: Obx(
                                    () => Text(
                                      contractController.selectedTabString.value,
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )

                                ///WITH EXPANDED
                                ,
                                gapWC(15),
                                const Icon(Icons.info_outline),
                                const Spacer(),
                                Obx(
                                  () => Bounce(
                                    duration: Duration(milliseconds: 100),
                                    onPressed: () {
                                      if (contractController.isEditModeEnabled.value) {
                                        contractController.fnSaveContract();
                                      } else {
                                        Get.dialog(
                                            barrierDismissible: false,
                                            AlertDialog(
                                              content: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Are you sure want to delete Contract?",
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
                                                                contractController.fnDelete(docNo: contractController.txtcontractNoController);
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
                                      }
                                    },
                                    child: Get.width * .3 > 190
                                        ? Container(
                                            height: 30,
                                            width: 95,
                                            decoration: BoxDecoration(
                                              color: contractController.isEditModeEnabled.value ? ThemeColors.primaryBlueColor : ThemeColors.primaryRedColor,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      contractController.isEditModeEnabled.value ? "Save" : "Delete",
                                                      maxLines: 1,
                                                      minFontSize: 12, // Ensures the text is still readable
                                                      style: GoogleFonts.poppins(
                                                        color: ThemeColors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  gapWC(10),
                                                  Icon(
                                                    contractController.isEditModeEnabled.value ? Icons.save : Icons.delete_forever,
                                                    color: ThemeColors.white,
                                                    size: 17,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 30,
                                            width: 50, // Use a fixed width instead of Expanded
                                            decoration: BoxDecoration(
                                              color: ThemeColors.primaryBlueColor,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                            child: Center(
                                              child: Icon(
                                                contractController.isEditModeEnabled.value ? Icons.save : Icons.edit_outlined,
                                                color: ThemeColors.white,
                                                size: 17,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                gapWC(15),
                                if (contractController.isEditModeEnabled.value == false)
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
                                      duration: Duration(milliseconds: 100),
                                      onPressed: () {
                                        selectDoctTypeDialogueNext(prvDocType: "GCR").then(
                                          (value) {
                                            Get.delete<ContractReceiptController>();
                                            Get.to(() => ContractReceiptPagesExe(
                                                  contractNo: contractController.txtcontractNoController.text,
                                                  isFromContractPage: true,
                                                ));
                                          },
                                        );
                                      })
                              ],
                            ),
                          ),

                          ///BODY
                          Expanded(
                            child: PageView(
                              onPageChanged: (value) {},
                              physics: NeverScrollableScrollPhysics(),
                              controller: contractController.pageController.value,
                              scrollDirection: Axis.vertical,
                              children: [ContractRequestPageExe(), ContractOtherDetailsPageExe(), ContractMainPageExe()],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: cBottomNav(Get.height * .04),
      );
    });
  }
}
