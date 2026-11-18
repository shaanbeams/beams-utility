import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gas_utility_app/modules/app/app.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:window_manager/window_manager.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    if (Platform.isWindows) {
      await windowManager.ensureInitialized();

      // Set the minimum window size
      windowManager.setMinimumSize(const Size(600, 700));
 

      Global.isWindows = true;
    }
  }
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}
