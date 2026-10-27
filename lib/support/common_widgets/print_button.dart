// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class PrintButton extends StatelessWidget {
  const PrintButton({
    super.key, this.onPressed,
  });
final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 100),
      onPressed:onPressed?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: ThemeColors.primaryBlueColor,
          borderRadius:
              const BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Print",
              style: GoogleFonts.poppins(
                  color: ThemeColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
              child:
                  Image.asset("assets/icons/Printer.png"),
            ),
          ],
        ),
      ),
    );
  }
}