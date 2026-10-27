import 'package:flutter/material.dart';
import 'package:gas_utility_app/support/common_widgets/select_country_dialogue.dart';
import 'package:gas_utility_app/support/country_list.dart';
import 'package:gas_utility_app/support/global.dart';

class PhoneNumberField extends StatelessWidget {
  PhoneNumberField({
    super.key,
    required this.controller,
    this.labelYn = false,
    required this.hintLabel,
    this.enablests =false,
  });

  final TextEditingController controller;
  final bool? labelYn;
  final String hintLabel;
  final FocusNode focusNode = FocusNode();
  final ValueNotifier<Country> selectedCountry = ValueNotifier(PhoneNumberFunctions.getCountryDetails(countryCode: "AE")!);
  final ValueNotifier<String> validationString = ValueNotifier("");
  final bool? enablests;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: validationString,
        builder: (context, val, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Global.isWindows == false)
                if (labelYn == true || controller.text != "")
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      hintLabel,
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  )
                else
                    Container(),
              _buildPhoneNumberField(context),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20),
              //   child: Text(
              //     validationString.value,
              //     style: const TextStyle(fontSize: 12, color: Colors.red),
              //   ),
              // )
            ],
          );
        });
  }

  Widget _buildPhoneNumberField(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: validationString.value.isNotEmpty ? Colors.red : Colors.grey.withOpacity(0.8),
        width: 1.5,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCountry,
          builder: (context, val, child) {
            return GestureDetector(
              onTap: enablests == false ? () {} : () => _selectCountry(context),
              child: _buildCountryCode(),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: VerticalDivider(),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: selectedCountry,
            builder: (context, val, child) {
              return TextFormField(
                enabled: enablests,
                focusNode: focusNode,
                controller: controller,
                // 1. Forces the text cursor and characters to vertical center
                textAlignVertical: TextAlignVertical.center,
                onChanged: (number) {
                  validationString.value = PhoneNumberFunctions.validateNumberOnly(
                    number,
                    selectedCountry.value.maxLength,
                  );
                },
                maxLength: selectedCountry.value.maxLength,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  // 2. Collapses default 48dp height requirement
                  isDense: true,
                  // 3. Removes asymmetric internal top/bottom padding
                  contentPadding: EdgeInsets.zero,
                  hintText: hintLabel,
                  counterText: "",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.phone,
              );
            },
          ),
        ),
      ],
    ),
  );
}

  Widget _buildCountryCode() {
    return SizedBox(
      width: 66,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "+${selectedCountry.value.dialCode}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void _selectCountry(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return SelectCountryDialogue(
          onSelected: (countrySelected) {
            selectedCountry.value = countrySelected;
          },
        );
      },
    );
  }
}

class PhoneNumberFunctions {
  static Country? getCountryDetails({required String countryCode}) {
    return countryList.firstWhere((element) => element.code == countryCode);
  }

  static String validateNumberOnly(String input, int expectedLength) {
    if (input.isEmpty) return "";

    final RegExp numberRegExp = RegExp(r'^\d+$');

    if (!numberRegExp.hasMatch(input)) {
      return "Only numbers are allowed.";
    }

    if (input.length != expectedLength) {
      return "The phone number should be $expectedLength digits long.";
    }

    return "";
  }
}
