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
    this.isOutlined = false,
    this.isGradient = false,
    this.isLoading = false, // Added loading parameter
    this.loadingText = "Loading", // Added loading parameter
  });

  final String buttonLabel;
  final double? buttonWidth;
  final VoidCallback onPressed; // VoidCallback is cleaner than Function()
  final Color? buttonColor;
  final Color? buttonTextColor;
  final bool? isOutlined;
  final bool? isGradient;
  final bool isLoading;
  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    final textColor = buttonTextColor ?? Colors.white;

    return Bounce(
      duration: const Duration(milliseconds: 100),
      // Disable click action while loading
      onPressed: isLoading ? () {} : onPressed,
      child: Container(
        width: buttonWidth,
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isOutlined == true
              ? Colors.transparent
              : (buttonColor ?? ThemeColors.primaryBlueColor),
          gradient: (isOutlined == true || isGradient != true)
              ? null
              : ThemeGradient.gradient,
          border: isOutlined == true
              ? Border.all(color: textColor)
              : null,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$loadingText...',
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : Text(
                  buttonLabel,
                  style: GoogleFonts.poppins(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}