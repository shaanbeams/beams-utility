import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/companySelection/view/company_selection_page_exe.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/primary_button.dart';
import '../../../support/common_widgets/primary_text_field.dart';
import '../../../support/global.dart';
import '../../../support/helper.dart';
import '../functions/login_function.dart';
import '../controller/login_controller.dart';
import '../repository/login_repository.dart';

class LoginPageExe extends StatelessWidget {
  LoginPageExe({super.key});
  final TextEditingController userNameController = TextEditingController(text: Global.rememberPassword == true ? Global.loginUserName : "");
  final TextEditingController passwordController = TextEditingController(text: Global.rememberPassword == true ? Global.loginPassword : "");
  final LogInController logInController = Get.put(LogInController());
  final LoginRepository loginRepo = LoginRepository();
  ValueNotifier<bool> rememberPassword = ValueNotifier(Global.rememberPassword);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        extendBody: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemeColors.white,
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
                    Spacer(),
                    Container(
                      alignment: Alignment.center,
                      width: Get.width * .3 < 350 ? 350 : Get.width * .3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(color: Color(0x41000000), blurRadius: 10, offset: Offset(1, 4), blurStyle: BlurStyle.normal, spreadRadius: 1)],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 38),
                            child: Image.asset(
                              "assets/icons/avatar.png",
                              height: 60,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              "proceed with your",
                              style: GoogleFonts.poppins(
                                color: ThemeColors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              "User Login ",
                              style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: PrimaryInputField(
                              hintText: "UserName",
                              txtController: userNameController,
                              suffixIcon: "assets/icons/person2.png",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: PrimaryInputField(
                              hintText: "Password",
                              txtController: passwordController,
                              suffixIcon: "assets/icons/password_open.png",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: Row(
                              children: [
                                // Obx(
                                //   () =>
                                ValueListenableBuilder(
                                    valueListenable: rememberPassword,
                                    builder: (context, val, child) {
                                      return CupertinoCheckbox(
                                        side: BorderSide(width: 2),
                                        value: rememberPassword.value,
                                        onChanged: (_) async {
                                          rememberPassword.value = !rememberPassword.value;
                                          await SpHelper.toSpBool("rememberPassword", rememberPassword.value);
                                        },
                                        activeColor: ThemeColors.primaryBlueColor,
                                      );
                                    }),

                                const Text("Remember Password"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: PrimaryButton(
                              buttonLabel: "Login",
                              buttonWidth: 140,
                              onPressed: () {
                                if (rememberPassword.value) {
                                  SpHelper.toSpString("loginUserName", userNameController.text);
                                  SpHelper.toSpString("loginPassword", passwordController.text);
                                }
                                LoginFunctions.fnLogin(username: userNameController.text, password: passwordController.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            logInController.loginErrorText.value,
                            style: GoogleFonts.poppins(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        )),
                    Spacer(),
                    Text.rich(
                      TextSpan(
                        text: 'You are logging in to ',
                        children: [
                          TextSpan(
                            text: Global.selectedCompanyCodeWithName == "" ? "CompanyName\n" : "${Global.selectedCompanyCodeWithName}\n",
                            style: const TextStyle(
                                color: ThemeColors.primaryBlueColor, // Set clickable text color
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => CompanySelectionPageExe());
                              },
                          ),
                          const TextSpan(text: ' for the year '),
                          TextSpan(
                            text: Global.selectedCompanyYear == "" ? "Year" : Global.selectedCompanyYear,
                            style: const TextStyle(
                              color: ThemeColors.primaryBlueColor, // Set clickable text color for year
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => CompanySelectionPageExe());
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    gapHC(Get.height * .04)
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
