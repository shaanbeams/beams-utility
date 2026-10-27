import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/login/view/login_page_exe.dart';
import 'package:gas_utility_app/modules/companySelection/view/company_selection_page_exe.dart';
import 'package:gas_utility_app/modules/splash/controller/splash_controller.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../support/global.dart';
import '../../../support/helper.dart';
import '../functions/splash_function.dart';

class SplashScreenExe extends StatelessWidget {
  SplashScreenExe({Key? key}) : super(key: key);
  final SplashController splashController = SplashController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: ThemeGradientExe.gradient),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                child: Row(
                    children: List.generate(
                  4,
                  (index) {
                    return Opacity(
                        opacity: 0.2,
                        child: Lottie.asset(
                          reverse: index % 2 == 0 ? true : false,
                          "assets/lotties/background.json",
                          // height: 200,
                        ));
                  },
                )),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height / 5),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    height: 150,
                  ),
                ),
                // Opacity(
                //     opacity: 0.2,
                //     child: Lottie.asset(
                //       "assets/lotties/loader4.json",
                //       height: 200,
                //     )),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .4,
                  ),
                  child: PrimaryButton(
                    buttonLabel: "Start",
                    onPressed: () async {
                      SplashFunctions.initPlatformState();
                      Global.mainCompany = await SpHelper.fromSpString("mainCompany");
                      Global.mainCompanyName = await SpHelper.fromSpString("MainCompanyName");

                      if (Global.mainCompany != "") {
                        Global.selectedCompanyCodeWithName = await SpHelper.fromSpString("selectedCompanyCodeWithName");
                        Global.selectedCompanyYear = await SpHelper.fromSpString("selectedCompanyYear");
                        Global.selectedCompanyCode = await SpHelper.fromSpString("selectedCompanyCode");
                        if (Global.selectedCompanyYear == "" || Global.selectedCompanyCodeWithName == "") {
                          Get.offAll(() => CompanySelectionPageExe());
                        } else {
                          Global.rememberPassword = await SpHelper.fromSpBool("rememberPassword");
                          Global.loginUserName = await SpHelper.fromSpString("loginUserName");
                          Global.loginPassword = await SpHelper.fromSpString("loginPassword");
                          Get.offAll(() => LoginPageExe());
                        }
                      } else {
                        Get.dialog(
                            barrierDismissible: false,
                            AlertDialog(
                              content: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Enter Your Main Company Code",
                                      style: GoogleFonts.poppins(
                                        color: ThemeColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    PrimaryInputField(
                                      hintText: "Company Code",
                                      txtRadius: 15,
                                      txtController: splashController.txtMainCompany,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: PrimaryButton(
                                        buttonLabel: "Add Main Company",
                                        onPressed: () async {
                                          // if (Get.isDialogOpen == true) {
                                          //   Get.back();
                                          // }
                                          ///INITIATING TO GLOBAL////
                                          SplashFunctions.fnSelectMainCompany(maincompanyCode: splashController.txtMainCompany.text);
                                        },
                                        isGradient: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }

                      // Get.to(() => CompanySelectionPageExe());
                    },
                    buttonColor: Colors.white,
                    buttonTextColor: ThemeColors.primaryBlueColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 40),
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
