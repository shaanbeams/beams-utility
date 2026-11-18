import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uae_dirham_symbol/uae_dirham_symbol.dart';

class Helper {
//
//Function to pick image
//
  static Future<Uint8List?> fnImageToBase64() async {
    final ImagePicker picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    final bytes = image != null ? File(image.path).readAsBytesSync() : null;
    return bytes;
  }

  //
  //Function to check if the platform is Windows or if the device is a tablet
  //

  static bool checkPlatform(context) {
    Global.isWindows = Platform.isWindows || _isTablet(context);
    return Global.isWindows;
  }

  static bool _isTablet(context) {
    final size = MediaQuery.of(context).size;
    final diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));
    return diagonal > 2000.0; // Adjust this value as needed for your use case
    // return diagonal > 1100.0; // Adjust this value as needed for your use case
  }

  /// Robust internal date parser to prevent FormatExceptions across all date formats
  static DateTime _parseDateTime(String dateTime) {
    String normalized = dateTime.trim();
    try {
      // Handle space-separated ISO strings (e.g., "2026-10-26 11:10:38.577")
      if (normalized.contains(' ') && !normalized.contains('T')) {
        normalized = normalized.replaceFirst(' ', 'T');
      }
      return DateTime.parse(normalized);
    } catch (_) {
      // Try parsing common custom patterns including 12-hour AM/PM formats
      List<String> formats = [
        'dd/MM/yyyy hh:mm:ss a',
        'MM/dd/yyyy hh:mm:ss a',
        'dd/MM/yyyy HH:mm:ss',
        'yyyy-MM-dd HH:mm:ss',
        'dd-MM-yyyy',
      ];

      for (String fmt in formats) {
        try {
          return DateFormat(fmt).parse(dateTime);
        } catch (_) {
          continue;
        }
      }

      return DateTime.now(); // Ultimate fallback if all patterns fail
    }
  }

  //
  // Function to format Date
  // Example:
  // Input: "20/10/2024 12:00:00 AM"
  // Output: "20-10-2024"
  //

  static convertDateFormat1({required String dateTime}) {
    try {
      String formattedDate = DateFormat("dd-MM-yyyy")
          .format(DateFormat("dd/MM/yyyy hh:mm:ss a").parse(dateTime));
      return formattedDate;
    } catch (e) {
      return dateTime;
    }
  }

  static convertDateFormat5({required String dateTime}) {
    String formattedDate =
        DateFormat("dd-MM-yyyy").format(_parseDateTime(dateTime));
    return formattedDate;
  }

  // Example:
  // Input: "2024-10-20T12:00:00" or "2026-10-26 11:10:38.577807"
  // Output: "20-10-2024"
  //

  static convertDateFormat2({required String dateTime}) {
    print("dateTime: $dateTime");

    String formattedDate =
        DateFormat("dd-MM-yyyy").format(_parseDateTime(dateTime));
    return formattedDate;
  }

static  Widget dirhamFormatter(
      {required String value,   Color? colour, double? fontSize}) {
    return CustomDirhamSymbolTextView(
      amount: double.parse(value),
      symbolColor: colour??Colors.black,
      symbolFontSize: fontSize ?? 14,
      includeDecimal: true,
      spacing: 1,
      isFormatted: true,
      amountStyle: TextStyle(
        fontSize: fontSize??14,
        color: colour??Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
    );
  }

  // Example:
  // Input: "20-10-2024"
  // Output: "2024-10-20 00:00:00.000"
  //

  static String convertDateFormat3({required String dateTime}) {
    DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(dateTime);
    String formattedDate =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(parsedDate);
    return formattedDate;
  }

  // Example:
  // Input: "25/01/2025 02:30:45 PM"
  // Output: "2025-01-25 14:30:45.000"
  //

  static convertDateFormat4({required String dateTime}) {
    // DateTime parsedDate = DateFormat("dd/MM/yyyy hh:mm:ss a").parse(dateTime);
    // String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(parsedDate);
    // return formattedDate;

    /// Converts supported date formats to yyyy-MM-dd HH:mm:ss.SSS.
    ///
    /// Supports ISO dates and custom dates with AM/PM.
    String convertDateFormat4({required String dateTime}) {
      if (dateTime.trim().isEmpty) {
        return '';
      }

      try {
        // Handles ISO formats:
        // 2026-10-26T11:45:42.779112
        // 2026-10-26 11:45:42.779112
        DateTime parsedDate;

        try {
          parsedDate = DateTime.parse(dateTime.trim());
        } catch (_) {
          // Handles formats such as:
          // 26/10/2026 11:45:42 AM
          parsedDate = DateFormat(
            'dd/MM/yyyy hh:mm:ss a',
          ).parse(dateTime.trim());
        }

        return DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(parsedDate);
      } catch (e) {
        logger.e('convertDateFormat4 failed for "$dateTime": $e');
        rethrow;
      }
    }
  }

  //
  // Function to format Date
  // Example:
  // Input: "2024-10-20T12:34:56"
  // Output: "2024-10-20 00:00:00.000"
  //

  static convertDateTime({required String dateTime}) {
    DateTime date = _parseDateTime(dateTime);
    return DateTime(date.year, date.month, date.day).toString();
  }

  // Function to Get Days
  static dateDifferance({required String previousDateString}) {
    DateTime previousDate =
        DateFormat('dd/MM/yyyy hh:mm:ss a').parse(previousDateString);
    DateTime currentDate = DateTime.now();
    int differenceInDays = currentDate.difference(previousDate).inDays;
    return differenceInDays + 1;
  }

  static dateDifferanceNew({required String previousDateString}) {
    DateTime previousDate =
        DateFormat('dd/MM/yyyy hh:mm:ss a').parse(previousDateString);
    DateTime currentDate = DateTime.now();
    int differenceInDays = currentDate.difference(previousDate).inDays;
    return differenceInDays + 1;
  }

  //
  //Converts a given value `dbl` to a double.
  //

  static mfnDbl(dbl) {
    var lstrDbl = 0.0;
    try {
      lstrDbl = double.parse((dbl ?? '0.0').toString());
    } catch (e) {
      lstrDbl = 0.00;
    }
    return lstrDbl;
  }

  //
  //Function to get the access token from the API.
  //

  static Future<String?> fngetTocken() async {
    final response = await ApiService().fnGetToken().catchError((error) {
      print(error);
    });
    if (response != null) {
      return response["access_token"];
    } else {
      return null;
    }
  }
}

class QuoteToBacktickFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll("'", '`').replaceAll('"', '`');
    if (text == newValue.text) return newValue;
    return newValue.copyWith(text: text); // copyWith keeps the selection
  }
}

//
// Logger instance for logging messages with pretty formatting.
//
var logger = Logger(
  filter: null,
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
  ),
  output: null,
);

//
//Provides helper methods to save and retrieve data from SharedPreferences.
//
class SpHelper {
  /* save boolean */
  static toSpBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  /* save String */
  static toSpString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /* save int */
  static toSpInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  /* get bool */
  static Future<bool> fromSpBool(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? false;
    return value;
  }

  /* get int */
  static Future<int> fromSpInt(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(key) ?? 0;
    return value;
  }

  /* get String */
  static Future<String> fromSpString(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    return value;
  }
}

List generateSearchList(String searchValue, searchColumn, filter) {
  List result = [];
  List ww = searchColumn;

  for (var item in ww) {
    if (item['showItem'] == true) {
      result.add({
        'Column': item['columnName'],
        'Operator': 'LIKE',
        'Value': searchValue,
        'JoinType': 'OR',
      });
    }
  }
  result.addAll(filter);

  return result;
}

double fnCalVat(double value, double perc) {
  return value * (perc / 100);
}
