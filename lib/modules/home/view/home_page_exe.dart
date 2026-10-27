import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/home/view/widgets/curved_shape_painter.dart';
import 'package:gas_utility_app/modules/home/view/widgets/home_menu_item.dart';
import 'package:gas_utility_app/modules/login/view/login_page_exe.dart';
import 'package:gas_utility_app/support/common_widgets/bottom_nav_exe.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/global.dart';
import '../../../support/helper.dart';
import '../controller/home_controller.dart';

class HomePageExe extends StatelessWidget {
  HomePageExe({super.key});
  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Stack(
              children: [
                CustomPaint(
                  size: Get.size,
                  painter: CurvedShapePainterExe(
                    Get.size,
                  ), // Pass dynamic size to painter
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: Column(
                      children: [
                        ///HEADER///
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BEAMS GAS MANAGEMENT",
                                style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Bounce(
                                duration: Duration(milliseconds: 200),
                                onPressed: () async {
                                  Global.rememberPassword = await SpHelper.fromSpBool("rememberPassword");
                                  Global.loginUserName = await SpHelper.fromSpString("loginUserName");
                                  Global.loginPassword = await SpHelper.fromSpString("loginPassword");
                                  Get.offAll(() => LoginPageExe());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: ThemeColors.white, width: 1.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Logout",
                                        style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                      gapWC(10),
                                      Image.asset(
                                        "assets/icons/exit.png",
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        gapHC(10),

                        ///Text///

                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: ThemeColors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                "Dashboard",
                                style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: ThemeColors.white,
                              ),
                            ),
                          ],
                        ),
                        gapHC(10),

                        ///BODY///
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [BoxShadow(color: Color(0x41000000), blurRadius: 10, offset: Offset(1, 4), blurStyle: BlurStyle.normal, spreadRadius: 1)],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.only(right: 10, left: 20, bottom: 30, top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Menu Category",
                                      style: GoogleFonts.poppins(color: ThemeColors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: Get.width * .3,
                                      child: CupertinoSearchTextField(
                                        onChanged: (value) {
                                          homeController.findMenu(searchWord: value);
                                        },
                                        borderRadius: BorderRadius.circular(50),
                                        suffixIcon: Icon(Icons.search),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ],
                                ),
                                gapHC(20),
                                Expanded(
                                  child: Obx(
                                    () => SingleChildScrollView(
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.start,
                                        alignment: WrapAlignment.start,
                                        spacing: 20,
                                        runSpacing: 10,
                                        children: homeController.filteredMenuList.map((menuItem) {
                                          return HomeMenuItemExe(
                                            IconPath: menuItem.iconPath, // Use the iconPath from the filtered list
                                            IconLabel: menuItem.name, // Use the name from the filtered list
                                            onPressed: () {
                                              menuItem.onPressed();
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   child: SingleChildScrollView(
                                //     child: Wrap(
                                //       crossAxisAlignment: WrapCrossAlignment.start,
                                //       alignment: WrapAlignment.start,
                                //       spacing: 20,
                                //       runSpacing: 10,
                                //       children:
                                //
                                //       [
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/user assign.png",
                                //           IconLabel: "Assign User \n List",
                                //           onPressed: () {
                                //             Get.dialog(
                                //
                                //                 // barrierDismissible: false,
                                //                 const AssignUserListDialogueExe());
                                //           },
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract.png",
                                //           IconLabel: "Contract",
                                //           onPressed: () {
                                //             Get.to(() => const ContractPageExe());
                                //           },
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {
                                //             Get.to(() => const ContractReceiptPagesExe());
                                //           },
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //         HomeMenuItemExe(
                                //           IconPath: "assets/icons/contract receipt.png",
                                //           IconLabel: "Contract \nReceipt",
                                //           onPressed: () {},
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        gapHC(40),
                        // Apply Padding with EdgeInsets.zero here
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: cBottomNav(Get.height * .07),
        );
      },
    );
  }
}

//
