// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:google_fonts/google_fonts.dart';
 

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    super.key,
    this.fnonAddButtonPressed,
    this.isEditIconEnabled = false,
    this.fnonCancelPressed,
    this.fnonSaveButtonPressed,
    this.fnonNextButtonPressed,
    this.fnonPreviousButtonPressed,
    this.fnonFirstButtonPressed,
    this.fnonLastButtonPressed,
    this.netAmountisRequired = false,
    this.isAddButtonRequired = false,
    this.netAmount,
  });

  final Function()? fnonAddButtonPressed;
  final Function()? fnonNextButtonPressed;
  final Function()? fnonPreviousButtonPressed;
  final Function()? fnonFirstButtonPressed;
  final Function()? fnonLastButtonPressed;
  final Function()? fnonSaveButtonPressed;
  final Function()? fnonCancelPressed;
  final bool? isEditIconEnabled, netAmountisRequired, isAddButtonRequired;
  final String? netAmount;
  // ContractController contractController = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    return
        //  Obx(
        //   () =>
        Container(
      height: netAmountisRequired == true
          ? isEditIconEnabled == true
              ? 110
              : 85
          : isEditIconEnabled == true
              ? 80
              : 50,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -10),
            ),
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          gradient: ThemeGradient.gradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          netAmountisRequired == true
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 5, 10),
                  child: Row(
                    children: [
                      Text(
                        "Net Amount : ",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.white,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child:Helper.dirhamFormatter(value: netAmount ?? "0.00", colour: Colors.white,fontSize:20 ) 
                        
                        // CustomDirhamSymbolTextView(
                        //   amount: double.parse(netAmount ?? "0.00"),
                        //   symbolColor: Colors.white,
                        //   symbolFontSize: 20,
                        //   includeDecimal: true,
                        //   spacing: 1,
                        //   isFormatted: true,
                        //   amountStyle: const TextStyle(
                        //     fontSize: 20,
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //     fontFamily: 'Roboto',
                        //   ),
                        // ),
                        //  Text(
                        //     double.parse(netAmount ?? "0.00")
                        //         .toStringAsFixed(3),
                        //     style: GoogleFonts.poppins(
                        //       color: ThemeColors.white,
                        //       fontSize: 20,
                        //     )),
                      )
                    ],
                  ),
                )
              : Container(),
          isEditIconEnabled == true
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(children: [
                    Expanded(
                        child: PrimaryButton(
                      buttonLabel: "Save",
                      onPressed: fnonSaveButtonPressed ?? () {},
                      buttonColor: ThemeColors.white,
                      buttonTextColor: ThemeColors.primaryBlueColor,
                    )),
                    gapWC(10),
                    Expanded(
                        child: PrimaryButton(
                            isOutlined: true,
                            buttonLabel: "Cancel",
                            onPressed: fnonCancelPressed ?? () {}))
                  ]),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: fnonFirstButtonPressed ?? () {},
                      child: Image.asset(
                        "assets/icons/Skip_first.png",
                        height: 32,
                      ),
                    ),
                    Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: fnonPreviousButtonPressed ?? () {},
                      child: Image.asset(
                        "assets/icons/previuos.png",
                        height: 32,
                      ),
                    ),
                    isAddButtonRequired!
                        ? Bounce(
                            duration: Duration(milliseconds: 100),
                            onPressed: fnonAddButtonPressed ?? () {},
                            child: Image.asset(
                              "assets/icons/add item.png",
                              height: 32,
                            ),
                          )
                        : Container(),
                    // Visibility(
                    //   visible: isAddButtonRequired!,
                    //   child: Bounce(
                    //     duration: Duration(milliseconds: 100),
                    //     onPressed: fnonAddButtonPressed ?? () {},
                    //     child: Image.asset(
                    //       "assets/icons/add item.png",
                    //       height: 32,
                    //     ),
                    //   ),
                    // ),
                    Bounce(
                      onPressed: fnonNextButtonPressed ?? () {},
                      duration: Duration(milliseconds: 100),
                      child: Image.asset(
                        "assets/icons/next.png",
                        height: 32,
                      ),
                    ),
                    Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: fnonLastButtonPressed ?? () {},
                      child: Image.asset(
                        "assets/icons/Skip_last.png",
                        height: 32,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
    // );
  }
}
