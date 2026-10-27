import 'package:flutter/material.dart';
import 'package:gas_utility_app/support/custom_theme.dart';

class CurvedShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // // Create a gradient
    // const Gradient gradient = LinearGradient(
    //   colors: [ThemeColors.primaryBlueColor, ThemeColors.primaryRedColor],
    //   stops: [0.5, 1.0], // Start and end colors
    //   begin: Alignment.topLeft, // Gradient direction
    //   end: Alignment.topRight,
    // );

    // Define the Paint object
    final paint = Paint()
      ..shader = ThemeGradient.gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start drawing the shape
    path.moveTo(0, 0);
    path.lineTo(size.width, 0); // Top line
    path.lineTo(size.width, size.height / 3); // Right line

    // Curved bottom line
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 3 + 50,
      0,
      size.height / 3,
    );

    path.lineTo(0, 0); // Close the shape

    // Draw the path using the gradient paint
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CurvedShapePainterExe extends CustomPainter {
  final Size screenSize;

  CurvedShapePainterExe(this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    // // Create a gradient
    // const Gradient gradient = LinearGradient(
    //   colors: [ThemeColors.primaryBlueColor, ThemeColors.primaryRedColor], // Start and end colors
    //   begin: Alignment.topLeft, // Gradient direction
    //   end: Alignment.topRight,
    // );

    // Define the Paint object
    final paint = Paint()
      ..shader = ThemeGradient.gradient.createShader(Rect.fromLTWH(0, 0, screenSize.width, screenSize.height))
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start drawing the shape
    path.moveTo(0, 0);
    path.lineTo(screenSize.width, 0); // Top line
    path.lineTo(screenSize.width, screenSize.height / 3.8); // Right line

    // Adjust curvature based on screen width
    double curveHeight = screenSize.width > 600 ? 100 : 50; // More curve for larger screens

    // Curved bottom line
    path.quadraticBezierTo(
      screenSize.width / 2,
      screenSize.height / 3.8 + curveHeight,
      0,
      screenSize.height / 3.8,
    );

    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
