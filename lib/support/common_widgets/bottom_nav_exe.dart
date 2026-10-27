import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_theme.dart';

Padding cBottomNav(height) => Padding(
      padding: EdgeInsets.zero,
      child: Container(
        height: height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: ThemeGradient.gradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 150,
            ),
            Text("BEAMS ERP Solutions", style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 12, fontWeight: FontWeight.normal)),
            SizedBox(
                width: 150,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "v1.0",
                      style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 12, fontWeight: FontWeight.normal),
                    ))),
          ],
        ),
      ),
    );
