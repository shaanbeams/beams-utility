import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/splash/view/splash_screen.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';

import '../splash/view/splash_screen_exe.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          scaffoldBackgroundColor: ThemeColors.white,
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.all(ThemeColors.primaryBlueColor),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Helper.checkPlatform(context) ? SplashScreenExe() : SplashScreen());
  }
}
