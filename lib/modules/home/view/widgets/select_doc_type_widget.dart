import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/assignUserList/view/assign_user_list_dialogue.dart';
import 'package:gas_utility_app/modules/assignUserList/view/assign_user_list_dialogue_exe.dart';
import 'package:gas_utility_app/modules/contract%20receipt/view/contract_receipt_page.dart';
import 'package:gas_utility_app/modules/contract%20receipt/view/contract_receipt_page_exe.dart';
import 'package:gas_utility_app/modules/contract/views/contract_page.dart';
import 'package:gas_utility_app/modules/contract/views_exe/contract_page_exe.dart';
import 'package:gas_utility_app/modules/contractDisconnection/view/contract_disconnection_page.dart';
import 'package:gas_utility_app/modules/disconnectionRequest/view/disconnection_request_page.dart';
import 'package:gas_utility_app/modules/disconnectionRequest/view/disconnection_request_page_exe.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/view/diconnection_temp_page.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/view/disconnection_temp_page_exe.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/view/gas_meter_invoice_page.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/view/gas_meter_invoice_page_exe.dart';
import 'package:gas_utility_app/modules/gasMeterReading/view/gas_meter_reading_page.dart';
import 'package:gas_utility_app/modules/gasMeterReading/view/gas_meter_reading_page_exe.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/view/gas_meter_receipt_page.dart';
import 'package:gas_utility_app/modules/gasMeterReceipt/view/gas_meter_receipt_page_exe.dart';
import 'package:gas_utility_app/modules/home/controller/home_controller.dart';
import 'package:gas_utility_app/modules/readingCorrection/view/reading_correction_page.dart';
import 'package:gas_utility_app/modules/readingCorrection/view/reading_correction_page_exe.dart';
import 'package:gas_utility_app/modules/recconnectionTemp/view/temp_reconnection_page.dart';
import 'package:gas_utility_app/modules/recconnectionTemp/view/temp_reconnection_page_exe.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/constants.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../contractDisconnection/view/contract_disconnection_page_exe.dart';
import '../../../finalSettlement/view/final_settlement_page.dart';

selectDoctTypeDialogue({bool? assignDialogueIsRequired = false, HomeMenuEnum? homeMenu, required String prvDocType}) {
  HomeController homeController = Get.put(HomeController());

  homeController.fnSelectDocType(docType: prvDocType);
  Global.isWindows
      ? Get.dialog(LayoutBuilder(
          builder: (context, constraints) {
            return AlertDialog(
              content: Container(
                width: 500,
                // height: Get.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose a DocType',
                          style: GoogleFonts.poppins(
                            color: ThemeColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    gapHC(10),
                    Obx(
                      () => homeController.docIsLoading.isTrue
                          ? SizedBox(
                              height: 500,
                              child: Center(
                                child: Lottie.asset(
                                  "assets/lotties/loader.json",
                                  height: 100,
                                ),
                              ),
                            )
                          : Container(
                              height: 500,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: homeController.docTypes.length,
                                itemBuilder: (context, index) {
                                  return Bounce(
                                    onPressed: () {
                                      Global.selectedDocType = homeController.docTypes[index]["DOCTYPE"];
                                      Get.back();
                                      _navigateTo(homeMenu);
                                    },
                                    duration: const Duration(milliseconds: 100),
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(color: ThemeColors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                      ]),
                                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              child: Text(
                                                "${homeController.docTypes[index]["DOCTYPE"]}",
                                                style: GoogleFonts.poppins(
                                                  color: ThemeColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ":  ${homeController.docTypes[index]["ENGLISH_CAPTION"]}",
                                              style: GoogleFonts.poppins(
                                                color: ThemeColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    )
                  ],
                ),
              ),
            );
          },
        ))
      : Get.bottomSheet(
          LayoutBuilder(builder: (context, constraints) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Choose a DocType',
                        style: GoogleFonts.poppins(
                          color: ThemeColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  gapHC(10),
                  Obx(
                    () => homeController.docIsLoading.isTrue
                        ? Expanded(
                            child: Center(
                              child: Lottie.asset(
                                "assets/lotties/loader.json",
                                height: 100,
                              ),
                            ),
                          )
                        : homeController.docTypes.length != 0
                            ? Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: homeController.docTypes.length,
                                  itemBuilder: (context, index) {
                                    return Bounce(
                                      onPressed: () {
                                        Global.selectedDocType = homeController.docTypes[index]["DOCTYPE"];
                                        Get.back();
                                        _navigateTo(homeMenu);
                                      },
                                      duration: const Duration(milliseconds: 100),
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(color: ThemeColors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                        ]),
                                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                                        child: SizedBox(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                child: Text(
                                                  "${homeController.docTypes[index]["DOCTYPE"]} : ",
                                                  style: GoogleFonts.poppins(
                                                    color: ThemeColors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${homeController.docTypes[index]["ENGLISH_CAPTION"]}",
                                                  style: GoogleFonts.poppins(
                                                    color: ThemeColors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/icons/folder.png",
                                      height: 100,
                                      color: ThemeColors.grey.withOpacity(0.5),
                                    ),
                                    Text("Nothing to show",
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.primaryBlueColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ],
                                ),
                              ),
                  )
                ],
              ),
            );
          }),
          backgroundColor: Colors.transparent, // Optional background color
          isDismissible: true, // Allows user to swipe away
        );
}

_navigateTo(HomeMenuEnum? homeMenu) {
  switch (homeMenu) {
    case HomeMenuEnum.assignUserList:
      {
        Get.dialog(
          Global.isWindows ? AssignUserListDialogueExe() : AssignUserListDialogue(),
          barrierDismissible: false,
        );
      }
    case HomeMenuEnum.contract:
      {
        Get.to(() => Global.isWindows ? ContractPageExe() : ContractPage());
      }
    case HomeMenuEnum.contractReceipt:
      {
        Get.to(() => Global.isWindows ? const ContractReceiptPagesExe() : ContractReceiptPage());
      }
    case HomeMenuEnum.gasMeterReading:
      {
        Get.to(() => Global.isWindows ? GasMeterReadingPageExe() : GasMeterReadingPage());
      }
    case HomeMenuEnum.gasInvoice:
      {
        Get.to(() => Global.isWindows ? GasMeterInvoicePageExe() : GasMeterReadingInvoicePage());
      }
    case HomeMenuEnum.gasMeterReceipt:
      {
        Get.to(() => Global.isWindows ? GasMeterReadingReceiptPageExe() : GasMeterReadingReceiptPage());
      }
    case HomeMenuEnum.readingCorrection:
      Get.to(() => Global.isWindows ? ReadingCorrectionPageExe() : ReadingCorrectionPage());
    case null:
    case HomeMenuEnum.disconnectionTemp:
      Get.to(() => Global.isWindows ? DisconnectionTemporaryPageExe() : DisconnectionTemporaryPage());
    case HomeMenuEnum.reconnectionTemp:
      Get.to(() => Global.isWindows ? ReconnectionTemporaryPageExe() : ReconnectionTemporaryPage());
    case HomeMenuEnum.disconnectionRequest:
      Get.to(() => Global.isWindows ? DisconnectionRequestPageExe() : DisconnectionRequestPage());
    case HomeMenuEnum.contractDisconnection:
      Get.to(() => Global.isWindows ? const ContractDisconnectionPageExe() : ContractDisconnectionPage());
    // TODO: Handle this case.
    case HomeMenuEnum.finalSettlement:
      Get.to(() => Global.isWindows ? FinalSettlementPage() : FinalSettlementPage());
  }
}

/////////////////////////////////////////////DEMO/////////////////////////////////////////////////
Future<String> selectDoctTypeDialogueNext({HomeMenuEnum? homeMenu, required String prvDocType}) async {
  HomeController homeController = Get.put(HomeController());
  String docType = '';
  homeController.fnSelectDocType(docType: prvDocType);
  await Get.bottomSheet(
    LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose a DocType',
                  style: GoogleFonts.poppins(
                    color: ThemeColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            gapHC(10),
            Obx(
              () => homeController.docIsLoading.isTrue
                  ? Expanded(
                      child: Center(
                        child: Lottie.asset(
                          "assets/lotties/loader.json",
                          height: 100,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeController.docTypes.length,
                        itemBuilder: (context, index) {
                          return Bounce(
                            onPressed: () {
                              Global.selectedDocType = homeController.docTypes[index]["DOCTYPE"];
                              docType = homeController.docTypes[index]["DOCTYPE"];
                              Get.back();
                            },
                            duration: const Duration(milliseconds: 100),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(color: ThemeColors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                              ]),
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        "${homeController.docTypes[index]["DOCTYPE"]}",
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ":  ${homeController.docTypes[index]["ENGLISH_CAPTION"]}",
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            )
          ],
        ),
      );
    }),
    backgroundColor: Colors.transparent, // Optional background color
    isDismissible: true, // Allows user to swipe away
  );

  return docType;
}
