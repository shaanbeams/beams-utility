import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMenuMobileItem extends StatelessWidget {
  const HomeMenuMobileItem({
    super.key,
    required this.IconPath,
    required this.IconLabel,
    required this.onPressed,
  });

  final String IconPath, IconLabel;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onPressed,
      duration: Duration(milliseconds: 100),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(15)),
        height: 80,
        width: Get.size.width / 2.3,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                IconPath,
                height: 40,
               
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  IconLabel,
                  style: GoogleFonts.poppins(
                      color: ThemeColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeMenuItemExe extends StatelessWidget {
  const HomeMenuItemExe({
    super.key,
    required this.IconPath,
    required this.IconLabel,
    required this.onPressed,
  });

  final String IconPath, IconLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onPressed,
      duration: Duration(milliseconds: 200),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(30)),
        height: 127,
        width: 150,
        child: Column(
          children: [
            Image.asset(
              IconPath,
              height: 57,
              color: ThemeColors.primaryBlueColor,
            ),
            Text(
              IconLabel,
              style: GoogleFonts.poppins(
                color: ThemeColors.black,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
