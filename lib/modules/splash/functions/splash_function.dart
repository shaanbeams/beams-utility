import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gas_utility_app/modules/companySelection/view/company_Selection_page.dart';
import 'package:gas_utility_app/modules/companySelection/view/company_selection_page_exe.dart';
import 'package:gas_utility_app/modules/splash/repository/splash_repository.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';

import '../../../support/global.dart';

class SplashFunctions {
  static SplashRepository splashRepo = SplashRepository();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static var deviceId = '';
  static var deviceName = '';

  static fnSelectMainCompany({required String maincompanyCode}) async {
    splashRepo.selectMainCompany(maincompany: maincompanyCode).then(
      (values) async {
        var value;
        try {
          value = jsonDecode(values);
        } catch (e) {
          value = values;
        }
        print(value);
        if (value[0]["Table1"].isNotEmpty) {
          Global.mainCompany = maincompanyCode.toString();
          Global.mainCompanyName = value[0]["Table1"][0]["COMPANY_NAME"];

          await SpHelper.toSpString("mainCompany", maincompanyCode.toString());
          await SpHelper.toSpString("MainCompanyName", value[0]["Table1"][0]["COMPANY_NAME"]);

          if (Global.isWindows) {
            Get.offAll(CompanySelectionPageExe());
          } else {
            Get.offAll(CompanySelectionPage());
          }
        } else {
          Get.snackbar("", "Company Selection Failed");
        }

        // Get.offAll(CompanySelectionPageExe());
      },
    );
    // .then((val) {
    //   fnLoginSuccess();
    // });
  }

  static Future<void> initPlatformState() async {
    // var deviceData = <String, dynamic>{};
    try {
      if (kIsWeb) {
        _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      // deviceData = <String, dynamic>{
      //   'Error:': 'Failed to get platform version.'
      // };
    }
    // if (!mounted) return;

   
    Global.wstrDeviceName = deviceName;
    Global.wstrDeviceId = deviceId;
  }

  static _readAndroidBuildData(AndroidDeviceInfo build) {
    deviceId = build.id;
    deviceName = build.model;
  }

  static _readIosDeviceInfo(IosDeviceInfo data) {
    deviceId = data.name;
    deviceName = data.systemName;
  }

  static _readLinuxDeviceInfo(LinuxDeviceInfo data) {}
  static _readWebBrowserInfo(WebBrowserInfo data) {
    deviceId = describeEnum(data.browserName);
    deviceName = describeEnum(data.browserName);
  }

  static _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    deviceId = data.systemGUID ?? '';
    deviceName = data.computerName;
  }

  static _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    deviceId = data.computerName;
    deviceName = data.computerName;
  }
}
