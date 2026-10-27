import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/login/functions/login_function.dart';
import 'package:gas_utility_app/modules/login/controller/login_controller.dart';
import 'package:gas_utility_app/modules/login/repository/login_repository.dart';
import 'package:gas_utility_app/modules/companySelection/view/company_Selection_page.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/global.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController userNameController = TextEditingController(
      text: Global.rememberPassword == true ? Global.loginUserName : "");
  final TextEditingController passwordController = TextEditingController(
      text: Global.rememberPassword == true ? Global.loginPassword : "");
  final LogInController logInController = Get.put(LogInController());
  final LoginRepository loginRepo = LoginRepository();
  final ValueNotifier<bool> rememberPassword =
      ValueNotifier(Global.rememberPassword);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header Stack
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          height: mediaQuery.size.height * 0.28,
                          decoration: const BoxDecoration(
                            gradient: ThemeGradient.gradient,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                        ),
                        SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/icons/beams Logo.png",
                                  height: 60,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "BEAMS GAS UTILITY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ThemeColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Image.asset(
                      "assets/icons/avatar.png",
                      height: 55,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "proceed with your",
                      style: GoogleFonts.poppins(
                        color: ThemeColors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "User Login",
                      style: GoogleFonts.poppins(
                        color: ThemeColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Inputs
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: PrimaryInputField(
                        txtController: userNameController,
                        hintText: "UserName",
                        suffixIcon: "assets/icons/person2.png",
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: PrimaryInputField(
                        txtController: passwordController,
                        hintText: "Password",
                        suffixIcon: "assets/icons/password_open.png",
                        isPassword: true,
                      ),
                    ),

                    // Remember Password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                      child: Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: rememberPassword,
                            builder: (context, val, child) {
                              return CupertinoCheckbox(
                                side: const BorderSide(
                                  width: 2,
                                  color: ThemeColors.primaryBlueColor,
                                ),
                                value: val,
                                onChanged: (newVal) async {
                                  rememberPassword.value = newVal ?? false;
                                  await SpHelper.toSpBool(
                                    "rememberPassword",
                                    rememberPassword.value,
                                  );
                                },
                                activeColor: ThemeColors.primaryBlueColor,
                              );
                            },
                          ),
                          const Text("Remember Password"),
                        ],
                      ),
                    ),

                    // Login Button
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: PrimaryButton(
                        buttonLabel: "Login",
                        buttonWidth: 140,
                        onPressed: () {
                          if (rememberPassword.value) {
                            SpHelper.toSpString(
                                "loginUserName", userNameController.text);
                            SpHelper.toSpString(
                                "loginPassword", passwordController.text);
                          }

                          LoginFunctions.fnLogin(
                            username: userNameController.text,
                            password: passwordController.text,
                          );
                        },
                      ),
                    ),

                    // Error Text
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          logInController.loginErrorText.value,
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    // Flexible gap to push company & footer down on large screens
                    const Spacer(),

                    // Company & Year Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text.rich(
                        TextSpan(
                          text: 'You are logging in to\n ',
                          children: [
                            TextSpan(
                              text: Global.selectedCompanyCodeWithName.isEmpty
                                  ? "CompanyName\n"
                                  : "${Global.selectedCompanyCodeWithName}\n",
                              style: const TextStyle(
                                color: ThemeColors.primaryBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => CompanySelectionPage());
                                },
                            ),
                            const TextSpan(text: ' for the year '),
                            TextSpan(
                              text: Global.selectedCompanyYear.isEmpty
                                  ? "Year"
                                  : Global.selectedCompanyYear,
                              style: const TextStyle(
                                color: ThemeColors.primaryBlueColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => CompanySelectionPage());
                                },
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Powered by footer
                    // SafeArea(
                    //   top: false,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(bottom: 16),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "powered by",
                    //           style: GoogleFonts.poppins(
                    //             color: ThemeColors.black,
                    //             fontSize: 12,
                    //           ),
                    //         ),
                    //         gapWC(10),
                    //         Text(
                    //           "BEAMS IT solutions",
                    //           style: GoogleFonts.poppins(
                    //             color: ThemeColors.black,
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}