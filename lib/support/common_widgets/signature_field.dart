import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';

class SignatureField extends StatefulWidget {
  SignatureField(
      {super.key,
      this.curveRadius,
      required this.isEnabled,
      required this.signatureController,
      required this.lstrSignature});
  final double? curveRadius;
  final bool isEnabled;
  final Rx<Uint8List> lstrSignature;
  final SignatureController signatureController;

  @override
  State<SignatureField> createState() => _SignatureFieldState();
}

class _SignatureFieldState extends State<SignatureField> {
  // final ContractController contractController = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    // return Obx(
    //   () =>
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            "Signature",
            style: GoogleFonts.poppins(
                color: ThemeColors.primaryBlueColor,
                fontSize: 13,
                fontWeight: FontWeight.normal),
          ),
        ),
        Stack(
          children: [
            DottedBorder(
              dashPattern: [6, 3],
              strokeWidth: 2,
              color: ThemeColors.black.withOpacity(0.5),
              radius: Radius.circular(30),
              padding: EdgeInsets.all(6),
              borderType: BorderType.RRect,
              // child: contractController.isEditModeEnabled.value
              child: widget.isEnabled
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      // child:Container(
                      //   height: 160,
                      //   child: Center(child: Text("Clicke here to add Signature")),
                      // )

                      child: Global.isWindows
                          ? Signature(
                              // dynamicPressureSupported: ,
                              backgroundColor: Colors.white,
                              height: 160,
                              controller:
                                  // contractController.signatureController,
                                  widget.signatureController,
                            )
                          : Bounce(
                              duration: Duration(milliseconds: 100),
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  backgroundColor: ThemeColors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  insetPadding: EdgeInsets.zero,
                                  content: SizedBox(
                                    width: Get.width - 40,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Sign here",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: ThemeColors.black,
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            DottedBorder(
                                              dashPattern: const [6, 2],
                                              strokeWidth: 2,
                                              color: ThemeColors.black
                                                  .withOpacity(0.5),
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(30),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Signature(
                                                  controller: widget
                                                      .signatureController,
                                                  backgroundColor:
                                                      ThemeColors.white,
                                                  height: 200,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: 10,
                                                top: 10,
                                                child: Bounce(
                                                  duration: Duration(
                                                      milliseconds: 100),
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.signatureController
                                                          .clear();
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor: widget
                                                              .isEnabled
                                                          ? ThemeColors
                                                              .primaryGreenColor
                                                          : ThemeColors.grey,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      )),
                                                ))
                                          ],
                                        ),
                                        gapHC(10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: PrimaryButton(
                                                  buttonLabel: "Ok",
                                                  onPressed: () {
                                                    setState(() {
                                                      Get.back();
                                                    });
                                                  }),
                                            ),
                                            gapWC(5),
                                            Expanded(
                                              child: PrimaryButton(
                                                buttonColor: ThemeColors
                                                    .primaryBlueColor,
                                                buttonTextColor: ThemeColors
                                                    .primaryBlueColor,
                                                buttonLabel: "Cancel",
                                                onPressed: () {
                                                  setState(() {
                                                    widget.signatureController
                                                        .clear();
                                                    Get.back();
                                                  });
                                                },
                                                isOutlined: true,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                              },
                              child: SizedBox(
                                height: 160,
                                child: widget.signatureController.isEmpty
                                    ? Center(
                                        child:
                                            Text("Click here to add Signature"))
                                    : IgnorePointer(
                                        ignoring: true,
                                        child: Signature(
                                          // dynamicPressureSupported: ,
                                          backgroundColor: Colors.white,
                                          height: 160,
                                          controller:
                                              widget.signatureController,
                                        ),
                                      ),
                              ),
                            ),
                    )
                  : Obx(() => ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Container(
                          padding: EdgeInsets.all(40),
                          height: 160,
                          width: double.infinity,
                          child: widget.lstrSignature.value.isNotEmpty
                              ? Image.memory(
                                  widget.lstrSignature.value,
                                )
                              : Image.asset(
                                  "assets/icons/signature.png",
                                ),
                        ),
                      )),
            ),
            Positioned(
                right: 10,
                top: 10,
                child: Bounce(
                  duration: Duration(milliseconds: 100),
                  onPressed: () {
                    setState(() {
                      widget.signatureController.clear();
                    });
                  },
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: widget.isEnabled
                          ? ThemeColors.primaryGreenColor
                          : ThemeColors.grey,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ))
          ],
        ),
      ],
      // ),
    );
  }
}
