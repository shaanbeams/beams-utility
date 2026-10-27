import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/companySelection/view/company_Selection_page.dart';
import 'package:gas_utility_app/modules/splash/functions/splash_function.dart';
import 'package:gas_utility_app/modules/splash/controller/splash_controller.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../support/global.dart';
import '../../../support/helper.dart';
import '../../login/view/login_page.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SplashController splashController = SplashController();
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
              child: Opacity(
                  opacity: 0.15,
                  child: Lottie.asset(
                    "assets/lotties/background.json",
                    height: 200,
                  )),
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 4),
                  child: PrimaryButton(
                    buttonLabel: "Start",
                    onPressed: () async {

                      SplashFunctions.initPlatformState();
                      Global.mainCompany = await SpHelper.fromSpString("mainCompany");
                      Global.mainCompanyName = await SpHelper.fromSpString("MainCompanyName");
                      SplashController.initPlatformState();
                      if (Global.mainCompany != "") {
                        Global.selectedCompanyCodeWithName = await SpHelper.fromSpString("selectedCompanyCodeWithName");
                        Global.selectedCompanyCode = await SpHelper.fromSpString("selectedCompanyCode");
                        Global.selectedCompanyYear = await SpHelper.fromSpString("selectedCompanyYear");
                        if (Global.selectedCompanyYear == "" || Global.selectedCompanyCodeWithName == "") {
                          Get.offAll(() => CompanySelectionPage());
                        } else {
                          Global.rememberPassword = await SpHelper.fromSpBool("rememberPassword");
                          Global.loginUserName = await SpHelper.fromSpString("loginUserName");
                          Global.loginPassword = await SpHelper.fromSpString("loginPassword");
                          Get.offAll(() => LoginPage());
                        }
                      } else {
                        Get.dialog(
                            barrierDismissible: false,
                            AlertDialog(
                              content: Column(
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
                                  gapHC(10),
                                  PrimaryInputField(
                                    labelYn: false,
                                    hintText: "Company Code",
                                    txtRadius: 15,
                                    txtController: splashController.txtMainCompany,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: PrimaryButton(
                                      buttonLabel: "Add Main Company",
                                      onPressed: () {
                                        // if (Get.isDialogOpen == true) {
                                        //   Get.back();
                                        // }
                                        SplashFunctions.fnSelectMainCompany(maincompanyCode: splashController.txtMainCompany.text);
                                      },
                                      isGradient: true,
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }
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
                          "BEAMS IT solutions",
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
