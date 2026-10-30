import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/home/controller/home_controller.dart';
import 'package:gas_utility_app/modules/home/view/widgets/curved_shape_painter.dart';
import 'package:gas_utility_app/modules/home/view/widgets/home_menu_item.dart';
import 'package:gas_utility_app/modules/home/view/widgets/home_menu_mobile_item.dart';
import 'package:gas_utility_app/modules/login/view/login_page.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = Get.put(HomeController());
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomPaint(
            size: Get.size,
            painter: CurvedShapePainter(),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                                  "assets/icons/beams Logo.png",
                                  height: 50,
                                ),
                    Text(
                      "BEAMS GAS",
                      style: TextStyle(
                          // fontFamily: 'Sofachrome',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Bounce(
                      duration: const Duration(milliseconds: 100),
                      onPressed: () async {
                        Global.rememberPassword =
                            await SpHelper.fromSpBool("rememberPassword");
                        Global.loginUserName =
                            await SpHelper.fromSpString("loginUserName");
                        Global.loginPassword =
                            await SpHelper.fromSpString("loginPassword");

                        Get.to(() => LoginPage());
                      },
                      child: Image.asset(
                        "assets/icons/exit.png",
                        height: 33,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(29, 20, 29, 10),
                          child: PrimaryInputField(
                            hintText: "Search menu",
                            suffixIcon: "assets/icons/search.png",
                            txtController: searchTextController,
                            labelYn: false,
                            onChanged: (value) {
                              homeController.findMenu(searchWord: value);
                            },
                          ),

                          //  CupertinoSearchTextField(

                          //   placeholder: "Search menu here",
                          //   borderRadius: BorderRadius.circular(50),
                          //   onChanged: (value) {
                          //     homeController.findMenu(searchWord: value);
                          //   },
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Menu Category",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Obx(
                          () => Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  homeController.filteredMenuList.isNotEmpty
                                      ? Wrap(
                                          spacing: 20,
                                          runSpacing: 10,
                                          children: homeController
                                              .filteredMenuList
                                              .map((menuItem) {
                                            return HomeMenuMobileItem(
                                              IconPath: menuItem.iconPath,
                                              IconLabel: menuItem.name,
                                              onPressed: () {
                                                menuItem.onPressed();
                                              },
                                            );
                                          }).toList(),
                                        )
                                      : Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50),
                                                child: Image.asset(
                                                  "assets/icons/folder.png",
                                                  height: 60,
                                                ),
                                              ),
                                              Text(
                                                "No Menu Found",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 30),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "powered by",
                                  style: GoogleFonts.poppins(
                                    color: ThemeColors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "BEAMS",
                                  style: GoogleFonts.poppins(
                                      color: ThemeColors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
