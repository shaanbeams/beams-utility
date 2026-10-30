// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gas_utility_app/support/custom_theme.dart';
// import 'package:gas_utility_app/support/helper.dart';

// import '../global.dart';

// class PrimaryInputField extends StatefulWidget {
//   final String? hintText;
//   final IconData? icon;
//   final String? suffixIcon;
//   final Function(String)? onChanged;
//   final ValueChanged<String>? onSubmit;
//   final VoidCallback? onEditingComplete;
//   final TextInputType? textType;
//   final TextEditingController? txtController;
//   final double? txtWidth;
//   final double? txtRadius;
//   final FocusNode? focusNode;
//   final Function? suffixIconOnclick;
//   final bool? enablests;
//   final bool? autoFocus;
//   final bool? labelYn;
//   final Color? labelColor;
//   final double? fontSize;
//   final int? maxlength;
//   final bool? isTextArea;
//   final bool? isPassword;
//   final String? label;
//   final List<TextInputFormatter>? formatter;
//   //===================inorder to disable the field========//
//   final bool? disable;

//   PrimaryInputField(
//       {super.key,
//       required this.hintText,
//       this.icon,
//       this.onChanged,
//       this.textType,
//       this.txtController,
//       this.txtWidth,
//       this.txtRadius,
//       this.suffixIcon,
//       this.onSubmit,
//       this.focusNode,
//       this.suffixIconOnclick,
//       this.enablests,
//       this.autoFocus,
//       this.labelYn = true,
//       this.onEditingComplete,
//       this.fontSize,
//       this.labelColor,
//       this.maxlength,
//       this.isPassword,
//       this.isTextArea = false,
//       this.formatter,
//       this.label,
//       this.disable = false});

//   @override
//   State<PrimaryInputField> createState() => _PrimaryInputFieldState();
// }

// class _PrimaryInputFieldState extends State<PrimaryInputField> {
//   @override
//   void initState() {
//     super.initState();
//     if (widget.txtController != null &&
//         widget.textType == TextInputType.number) {
//       widget.txtController!.text =
//           _restrictToThreeDecimals(widget.txtController!.text);
//     }
//   }

//   var showPassWord = false;

//   @override
//   Widget build(BuildContext context) {
//     return TextFieldContainer(
//       txtRadius: widget.txtRadius ?? 15,
//       txtWidth: widget.txtWidth ?? 0.8,
//       labelName: widget.label ?? widget.hintText ?? '',
//       labelYn: widget.labelYn,
//       labelColor: widget.labelColor,
//       disable: widget.disable,
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               obscureText: widget.isPassword == true && showPassWord == false
//                   ? true
//                   : false,
//               enabled: widget.enablests ?? true,
//               focusNode: widget.focusNode,
//               autofocus: widget.autoFocus ?? false,
//               controller: widget.txtController,
//               onChanged: (s) {
//                 final formattedValue = widget.textType == TextInputType.number
//                     ? _restrictToThreeDecimals(s)
//                     : s;

//                 if (widget.txtController != null) {
//                   widget.txtController!.text = formattedValue;

//                   widget.txtController!.selection = TextSelection.collapsed(
//                     offset: formattedValue.length,
//                   );
//                 }

//                 if (widget.onChanged != null) {
//                   setState(() {
//                     widget.onChanged!(formattedValue);
//                   });
//                 }
//               },
//               maxLines: widget.isTextArea == true ? 3 : 1,
//               maxLength: widget.maxlength == 0 ? 1000 : widget.maxlength,
//               cursorColor: widget.labelColor ?? ThemeColors.black,
//               onEditingComplete: widget.onEditingComplete,
//               decoration: InputDecoration(
//                 counterText: "",
//                 hintText: widget.hintText,
//                 hintStyle: TextStyle(
//                     fontSize: 12,
//                     color: widget.disable == true
//                         ? Colors.grey.withOpacity(0.5)
//                         : widget.labelColor != null
//                             ? Colors.white.withOpacity(0.5)
//                             : Colors.black.withOpacity(0.5)),
//                 border: InputBorder.none,
//               ),
//               style: TextStyle(
//                   fontSize: widget.fontSize,
//                   color: widget.disable == true
//                       ? Colors.grey.withOpacity(0.5)
//                       : widget.labelColor ?? ThemeColors.black),
//               keyboardType: widget.textType,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//               onFieldSubmitted: widget.onSubmit,
//               inputFormatters: [
//                 // if (widget.textType == TextInputType.number)
//                 //   FilteringTextInputFormatter.allow(
//                 //     RegExp(r'^\d+\.?\d{0,3}$'),
//                 //   ),
//                 if (widget.formatter != null)
//                   ...widget.formatter!
//                 else
//                   QuoteToBacktickFormatter(),
//               ],
//             ),
//           ),
//           widget.suffixIcon != null
//               ? GestureDetector(
//                   onTap: () {
//                     widget.suffixIconOnclick ?? defaultSuffixIconFunction();
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(5),
//                     child: Image.asset(
//                       showPassWord == false
//                           ? widget.suffixIcon!
//                           : "assets/icons/password_close.png",
//                       height: 30,
//                     ),
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }

//   // Default function for suffix icon, used to toggle password visibility
//   defaultSuffixIconFunction() {
//     if (widget.isPassword == true) {
//       setState(() {
//         showPassWord = !showPassWord;
//       });
//     }
//   }
// }

// class TextFieldContainer extends StatelessWidget {
//   final Widget? child;
//   final double? txtWidth;
//   final double? txtRadius;
//   final String? labelName;
//   final bool? labelYn;
//   final Color? labelColor;
//   final bool? disable;

//   const TextFieldContainer({
//     super.key,
//     this.child,
//     this.txtWidth,
//     this.txtRadius,
//     this.labelName,
//     this.labelYn,
//     this.labelColor,
//     this.disable = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         labelYn == true && !Global.isWindows
//             ? Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   labelName ?? "",
//                   style: TextStyle(
//                       fontSize: 12, color: labelColor ?? Colors.black),
//                 ),
//               )
//             : Container(
//                 // height: Global().isWindows(context) ? 0 : 17,
//                 height: 0,
//               ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             border: Border.all(
//               color: disable == true
//                   ? Colors.grey.withOpacity(0.5)
//                   : labelColor ?? ThemeColors.grey,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(txtRadius!)),
//           ),
//           // boxOutlineDecoration(Colors.transparent, txtRadius!, labelColor,true),
//           child: child,
//         ),
//       ],
//     );
//   }
// }

// BoxDecoration boxOutlineDecoration(color, double radius, [labelColor]) =>
//     BoxDecoration(
//       color: color,
//       border: Border.all(
//         color: labelColor ?? ThemeColors.grey,
//         width: 2,
//       ),
//       borderRadius: BorderRadius.all(Radius.circular(radius)),
//     );

// // Input formatters to restrict input for decimal numbers with up to 3 decimal places
// List<TextInputFormatter> mfnInputDecFormatters() {
//   List<TextInputFormatter> inputFormatters = [];
//   inputFormatters
//       .add(FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')));

//   return inputFormatters;
// }

// String _restrictToThreeDecimals(String value) {
//   if (value.isEmpty) return value;

//   // Check if the input contains a decimal point
//   if (value.contains('.')) {
//     // Split into whole number and decimal part
//     final parts = value.split('.');

//     // Allow only the first 3 digits in the decimal part
//     final decimalPart = parts.length > 1
//         ? parts[1].substring(0, parts[1].length.clamp(0, 3))
//         : '';
//     return '${parts[0]}.${decimalPart}';
//   }

//   // If no decimal point, return the value as-is
//   return value;
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/helper.dart';

import '../global.dart';

class PrimaryInputField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final String? suffixIcon;
  final Function(String)? onChanged;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onEditingComplete;
  final TextInputType? textType;
  final TextEditingController? txtController;
  final double? txtWidth;
  final double? txtRadius;
  final FocusNode? focusNode;
  final Function? suffixIconOnclick;
  final bool? enablests;
  final bool? autoFocus;
  final bool? labelYn;
  final Color? labelColor;
  final double? fontSize;
  final int? maxlength;
  final bool? isTextArea;
  final bool? isPassword;
  final String? label;
  final List<TextInputFormatter>? formatter;
  //===================inorder to disable the field========//
  final bool? disable;

  PrimaryInputField(
      {super.key,
      required this.hintText,
      this.icon,
      this.onChanged,
      this.textType,
      this.txtController,
      this.txtWidth,
      this.txtRadius,
      this.suffixIcon,
      this.onSubmit,
      this.focusNode,
      this.suffixIconOnclick,
      this.enablests,
      this.autoFocus,
      this.labelYn = true,
      this.onEditingComplete,
      this.fontSize,
      this.labelColor,
      this.maxlength,
      this.isPassword,
      this.isTextArea = false,
      this.formatter,
      this.label,
      this.disable = false});

  @override
  State<PrimaryInputField> createState() => _PrimaryInputFieldState();
}

class _PrimaryInputFieldState extends State<PrimaryInputField> {
  @override
  void initState() {
    super.initState();
    if (widget.txtController != null &&
        widget.textType == TextInputType.number) {
      widget.txtController!.text =
          _restrictToThreeDecimals(widget.txtController!.text);
    }
  }

  var showPassWord = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      txtRadius: widget.txtRadius ?? 10,
      txtWidth: widget.txtWidth ?? 0.8,
      labelName: widget.label ?? widget.hintText ?? '',
      labelYn: widget.labelYn,
      labelColor: widget.labelColor,
      disable: widget.disable,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              obscureText: widget.isPassword == true && showPassWord == false
                  ? true
                  : false,
              enabled: widget.enablests ?? true,
              focusNode: widget.focusNode,
              autofocus: widget.autoFocus ?? false,
              controller: widget.txtController,
              onChanged: widget.onChanged,
              //  (s) {
              //   final formattedValue = widget.textType == TextInputType.number
              //       ? _restrictToThreeDecimals(s)
              //       : s;

              //   if (widget.txtController != null) {
              //     widget.txtController!.text = formattedValue;

              //     widget.txtController!.selection = TextSelection.collapsed(
              //       offset: formattedValue.length,
              //     );
              //   }

              //   if (widget.onChanged != null) {
              //     setState(() {
              //       widget.onChanged!(formattedValue);
              //     });
              //   }
              // },
              maxLines: widget.isTextArea == true ? 3 : 1,
              maxLength: widget.maxlength == 0 ? 1000 : widget.maxlength,
              cursorColor: widget.labelColor ?? ThemeColors.black,
              onEditingComplete: widget.onEditingComplete,
              decoration: InputDecoration(
                isDense: true, // Collapses extra vertical whitespace
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8, // Controls the exact internal height
                  horizontal: 0,
                ),
                counterText: "",
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontSize: 12,
                    color: widget.disable == true
                        ? Colors.grey.withOpacity(0.5)
                        : widget.labelColor != null
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5)),
                border: InputBorder.none,
              ),
              style: TextStyle(
                  fontSize: widget.fontSize ?? 13,
                  color: widget.disable == true
                      ? Colors.grey.withOpacity(0.5)
                      : widget.labelColor ?? ThemeColors.black),
              keyboardType: widget.textType,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onFieldSubmitted: widget.onSubmit,
              inputFormatters: [
                if (widget.textType == TextInputType.number)
                  DecimalTextInputFormatter(decimalRange: 3),
                if (widget.formatter != null)
                  ...widget.formatter!
                else if (widget.textType != TextInputType.number)
                  QuoteToBacktickFormatter(),
              ],
              // inputFormatters: [
              //   if (widget.formatter != null)
              //     ...widget.formatter!
              //   else
              //     QuoteToBacktickFormatter(),
              // ],
            ),
          ),
          widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    widget.suffixIconOnclick ?? defaultSuffixIconFunction();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Image.asset(
                      showPassWord == false
                          ? widget.suffixIcon!
                          : "assets/icons/password_close.png",
                      height:
                          18, // Reduced from 30 to prevent height stretching
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  

  defaultSuffixIconFunction() {
    if (widget.isPassword == true) {
      setState(() {
        showPassWord = !showPassWord;
      });
    }
  }
}
class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatter({this.decimalRange = 3});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final regex = RegExp('^\\d*\\.?\\d{0,$decimalRange}\$');
    return regex.hasMatch(newValue.text) ? newValue : oldValue;
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  final double? txtWidth;
  final double? txtRadius;
  final String? labelName;
  final bool? labelYn;
  final Color? labelColor;
  final bool? disable;

  const TextFieldContainer({
    super.key,
    this.child,
    this.txtWidth,
    this.txtRadius,
    this.labelName,
    this.labelYn,
    this.labelColor,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Prevents column from stretching
      children: [
        if (labelYn == true && !Global.isWindows)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              labelName ?? "",
              style: TextStyle(
                fontSize: 11,
                color: labelColor ?? Colors.black,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: disable == true
                  ? Colors.grey.withOpacity(0.5)
                  : labelColor ?? ThemeColors.grey,
              width: 1.5, // Slightly slimmer border
            ),
            borderRadius: BorderRadius.all(Radius.circular(txtRadius ?? 10)),
          ),
          child: child,
        ),
      ],
    );
  }
}

BoxDecoration boxOutlineDecoration(color, double radius, [labelColor]) =>
    BoxDecoration(
      color: color,
      border: Border.all(
        color: labelColor ?? ThemeColors.grey,
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

List<TextInputFormatter> mfnInputDecFormatters() {
  List<TextInputFormatter> inputFormatters = [];
  inputFormatters
      .add(FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')));
  return inputFormatters;
}

String _restrictToThreeDecimals(String value) {
  if (value.isEmpty) return value;

  if (value.contains('.')) {
    final parts = value.split('.');
    final decimalPart = parts.length > 1
        ? parts[1].substring(0, parts[1].length.clamp(0, 3))
        : '';
    return '${parts[0]}.${decimalPart}';
  }

  return value;
}
