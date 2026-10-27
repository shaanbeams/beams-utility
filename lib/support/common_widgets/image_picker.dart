import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({super.key, this.label, this.enable = true, this.image});

  final String? label;
  final bool? enable;
  final Uint8List? image;
  @override
  Widget build(BuildContext context) {
    // ContractController contractController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  label!,
                  style: GoogleFonts.poppins(color: ThemeColors.primaryBlueColor, fontSize: 13, fontWeight: FontWeight.normal),
                ),
              )
            : Container(),
        Stack(
          children: [
            DottedBorder(
              dashPattern: const [6, 2],
              strokeWidth: 2,
              color: ThemeColors.black.withOpacity(0.5),
              borderType: BorderType.RRect,
              radius: const Radius.circular(30),
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Container(
                          padding: EdgeInsets.all(image!.isNotEmpty?0:40),
                          height: 160,
                          width: double.infinity,
                          child:image!.isNotEmpty?Image.memory(image!, fit: BoxFit.fill): Image.asset(
                            "assets/icons/image.png",
                            height: 15,
                          )),
                    ),
            ),
            Positioned(
              right: 0,
              child: CircleAvatar(
                backgroundColor: enable == true ? ThemeColors.primaryGreenColor : ThemeColors.grey,
                radius: 16,
                child: Icon(
                  Icons.add,
                  color: ThemeColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
