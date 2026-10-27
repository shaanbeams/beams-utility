import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.buttonLabel,
    this.buttonWidth,
    required this.onPressed,
    this.buttonColor,
    this.buttonTextColor,
    this.isOutlined =false,
    this.isGradient =false
  });

  final String buttonLabel;
  final double? buttonWidth;
  final Function() onPressed;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final bool? isOutlined;
  final bool? isGradient;


  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(
        milliseconds: 100,
      ),
      onPressed: onPressed,
      child:isOutlined==true?Container(
        width: buttonWidth,
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color:Colors.transparent,
            border: Border.all(
              color:buttonTextColor?? Colors.white
            ),
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            buttonLabel,
            style: GoogleFonts.poppins(
                color:buttonTextColor?? Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ): Container(
        width: buttonWidth,
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: isGradient==true?ThemeGradient.gradient:null,
            color:buttonColor?? ThemeColors.primaryBlueColor,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            buttonLabel,
            style: GoogleFonts.poppins(
                color:buttonTextColor?? Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
