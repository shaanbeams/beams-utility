import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/login/view/login_page.dart';
import 'package:gas_utility_app/modules/splash/view/splash_screen.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/global.dart';
import '../../../support/helper.dart';
import '../controller/company_selection_controller.dart';

class CompanySelectionPage extends StatelessWidget {
  CompanySelectionPage({Key? key}) : super(key: key);

  ValueNotifier<String> selectedOptionCompany = ValueNotifier("");
  ValueNotifier<String> selectedOptionCompanyYear = ValueNotifier("");
  CompanySelectionController _companySelectionController = Get.put(CompanySelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)), gradient: ThemeGradient.gradient),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Text('Choose Company & Yearcode', style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                gapHC(20),
                Text('DEVICE ID: ${Global.wstrDeviceId}',
                    style: GoogleFonts.poppins(
                      color: ThemeColors.white,
                      fontSize: 10,
                    )),
                gapHC(20),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Flexible(
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
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                                                gapHC(20),

                                             
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
                                                            Get.offAll(SplashScreen());
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
                      ))
                    ],
                  ),
                ),
                Flexible(
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
                SafeArea(
                  child: SizedBox(
                    height: 40,
                    width: 250,
                    child: Center(
                        child: PrimaryButton(
                            buttonLabel: "Update",
                            onPressed: () {
                              Get.to(() => LoginPage());
                            })),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
