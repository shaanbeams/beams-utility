import 'package:flutter/services.dart';

class RangeInputFormatterForMonth extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    int? newValueInt = int.tryParse(newValue.text);
    if (newValueInt != null && newValueInt >= 1 && newValueInt <= 12) {
      return newValue;
    }
    return oldValue;
  }
}
