import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/companySelection/controller/company_selection_controller.dart';
import 'package:gas_utility_app/modules/splash/view/splash_screen_exe.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/primary_button.dart';
import '../../../support/helper.dart';
import '../../login/view/login_page_exe.dart';

class CompanySelectionPageExe extends StatelessWidget {
  CompanySelectionPageExe({Key? key}) : super(key: key);

  ValueNotifier<String> selectedOptionCompany = ValueNotifier("");
  ValueNotifier<String> selectedOptionCompanyYear = ValueNotifier("");
  CompanySelectionController _companySelectionController = Get.put(CompanySelectionController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: SizedBox(
        width: Get.width,
        child: Row(
          children: [
            Hero(
              tag: "BEAMS-SIDEBAR",
              child: Container(
                height: Get.height,
                width: Get.width / 3,
                decoration: const BoxDecoration(
                    gradient: ThemeGradientExe.gradient,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
                child: Column(
                  children: [
                    gapHC(150),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: AutoSizeText(
                        "BEAMS GAS\n MANAGEMENT",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "powered by",
                              style: GoogleFonts.poppins(
                                color: ThemeColors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "BEAMS",
                              style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    gapHC(75),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: Get.height * .7,
                    width: Get.width * .3 < 350 ? 350 : Get.width * .3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(color: Color(0x41000000), blurRadius: 10, offset: Offset(1, 4), blurStyle: BlurStyle.normal, spreadRadius: 1)],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // fnGetPageData();
                                },
                                child: Container(
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: Colors.transparent,
                                      ),
                                      gapWC(10),
                                      Icon(
                                        Icons.refresh,
                                        color: Colors.transparent,
                                      ),
                                      Spacer(),
                                      Center(
                                        child: Text('Select Company', style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                      ),
                                      Spacer(),
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
                                                          "Are you sure want to clear main company?",
                                                          style: GoogleFonts.poppins(
                                                            color: ThemeColors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        // gapHC(5),
                                                        // Text(
                                                        //   "Deleted ",
                                                        //   style: GoogleFonts.poppins(
                                                        //     color: ThemeColors.black,
                                                        //     fontSize: 12,
                                                        //     fontWeight: FontWeight.bold,
                                                        //   ),
                                                        // ),
                                                        gapHC(10),

                                                        gapHC(10),
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
                                                                  buttonLabel: "Clear",
                                                                  buttonColor: ThemeColors.primaryDeleteRedColor,
                                                                  onPressed: () async {
                                                                    await SpHelper.toSpString("mainCompany", "");
                                                                    await SpHelper.toSpString("selectedCompanyCode", "");
                                                                    await SpHelper.toSpString("selectedCompanyYear", "");
                                                                    await SpHelper.toSpString("MainCompanyName", "");
                                                                    await SpHelper.toSpString("selectedCompanyCodeWithName", "");
                                                                    Get.offAll(SplashScreenExe());
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
                                          child: Icon(Icons.clear)),
                                      gapWC(10),
                                      Bounce(
                                          onPressed: () {
                                            _companySelectionController.fnGetCompany();
                                          },
                                          duration: Duration(milliseconds: 100),
                                          child: Icon(Icons.refresh)),
                                    ],
                                  ),
                                ),
                              ),
                              gapHC(10),
                              Expanded(
                                child: Obx(
                                  () => ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: _companySelectionController.companyList.length,
                                      itemBuilder: (ctx, index) {
                                        return SizedBox(
                                          height: 40,
                                          child: ValueListenableBuilder(
                                              valueListenable: selectedOptionCompany,
                                              builder: (context, val, child) {
                                                return RadioMenuButton(
                                                  style: const ButtonStyle(
                                                    splashFactory: NoSplash.splashFactory,
                                                  ),
                                                  child: Text("${_companySelectionController.companyList[index]["COMPANY_CODE"]} - ${_companySelectionController.companyList[index]["COMPANY_NAME"]}"),
                                                  value: "${_companySelectionController.companyList[index]["COMPANY_CODE"]} - ${_companySelectionController.companyList[index]["COMPANY_NAME"]}",
                                                  onChanged: (value) async {
                                                    selectedOptionCompany.value = value.toString();
                                                    _companySelectionController.fnGetCompanyYear(yearCode: _companySelectionController.companyList[index]["COMPANY_CODE"]);

                                                    ///Assign to shared_preferences

                                                    await SpHelper.toSpString("selectedCompanyCodeWithName", value.toString());
                                                    await SpHelper.toSpString("selectedCompanyCode", "${_companySelectionController.companyList[index]["COMPANY_CODE"]}");

                                                    ///Assign to global
                                                    Global.selectedCompanyCodeWithName = value.toString();
                                                    Global.selectedCompanyCode = "${_companySelectionController.companyList[index]["COMPANY_CODE"]}";
                                                  },
                                                  groupValue: selectedOptionCompany.value,
                                                );
                                              }),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Center(
                                  child: Text('Select Yearcode', style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: _companySelectionController.yearList.length,
                                      itemBuilder: (ctx, index) {
                                        print(_companySelectionController.yearList);
                                        return SizedBox(
                                          height: 40,
                                          child: ValueListenableBuilder(
                                              valueListenable: selectedOptionCompanyYear,
                                              builder: (context, val, child) {
                                                return RadioMenuButton(
                                                  style: const ButtonStyle(
                                                    splashFactory: NoSplash.splashFactory,
                                                  ),
                                                  child: Text(_companySelectionController.yearList[index]["YEARCODE"]),
                                                  value: "${_companySelectionController.yearList[index]["YEARCODE"]}",
                                                  onChanged: (value) async {
                                                    selectedOptionCompanyYear.value = value.toString();

                                                    ///Assign to global
                                                    Global.selectedCompanyYear = value.toString();

                                                    ///Assign to shared_preferences
                                                    await SpHelper.toSpString("selectedCompanyYear", value.toString());
                                                  },
                                                  groupValue: selectedOptionCompanyYear.value,
                                                );
                                              }),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 40,
                            width: 250,
                            child: Center(
                                child: PrimaryButton(
                                    buttonLabel: "Update",
                                    onPressed: () {
                                      Get.to(() => LoginPageExe());
                                    })),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
    });
  }
}
