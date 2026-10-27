import 'package:flutter/material.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

 // Make sure to import this

import 'package:intl/intl.dart';

// Future<String> showCustomDatePicker2({String? date}) async {
//   DateTime initialDate = DateTime.now();

//   if (date != null && date.isNotEmpty) {
//     try {
//       // Try parsing standard ISO format first
//       initialDate = DateTime.parse(date);
//     } catch (_) {
//       try {
//         // If it fails, parse using DateFormat matching your incoming string style
//         initialDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').parse(date);
//       } catch (e) {
//         // Ultimate fallback if parsing fails completely
//         print("Error parsing date: $e. Falling back to DateTime.now()");
//         initialDate = DateTime.now();
//       }
//     }
//   }

//   print("Initial Date: $initialDate");
//   String formattedDate1 = DateFormat('d MMM, yyyy').format(initialDate);
//   DateTime pickedDate = initialDate; // Keep track of initial date as default picked date

//   ValueNotifier<String> selectedDate = ValueNotifier(formattedDate1);

//   await showDialog<DateTime>(
//     context: Get.context!,
//     builder: (BuildContext context) {
//       return Dialog(
//         backgroundColor: Colors.white,
//         child: Container(
//           height: Get.height * .6,
//           width: Get.width * .35,
//           child: Column(
//             children: [
//               ValueListenableBuilder(
//                   valueListenable: selectedDate,
//                   builder: (context, val, child) {
//                     return Container(
//                       width: double.infinity,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                         gradient: ThemeGradient.gradient,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Select Date",
//                               style: GoogleFonts.poppins(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 selectedDate.value,
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//               Expanded(
//                 child: Theme(
//                   data: Theme.of(context).copyWith(
//                       colorScheme: const ColorScheme.light(
//                     primary: ThemeColors.primaryBlueColor,
//                   )),
//                   child: CalendarDatePicker(
//                     initialDate: initialDate,
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                     onDateChanged: (DateTime newDate) {
//                       print(newDate);
//                       selectedDate.value =
//                           DateFormat('d MMM, yyyy').format(newDate);
//                       pickedDate = newDate;
//                     },
//                   ),
//                 ),
//               ),
//               // Buttons
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: PrimaryButton(
//                           buttonLabel: "Done",
//                           onPressed: () {
//                             Get.back();
//                           }),
//                     ),
//                     gapWC(10),
//                     Expanded(
//                       child: PrimaryButton(
//                           buttonTextColor: ThemeColors.primaryBlueColor,
//                           isOutlined: true,
//                           buttonLabel: "Cancel",
//                           onPressed: () {
//                             Get.back();
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );

//  // Change this at the end of showCustomDatePicker:
// return pickedDate.toIso8601String(); 
// // OR return DateFormat('yyyy-MM-dd HH:mm:ss').format(pickedDate);
// }
Future<String?> showCustomDatePicker2({String? date}) async {
  DateTime initialDate = DateTime.now();

  if (date != null && date.isNotEmpty) {
    try {
      initialDate = DateTime.parse(date);
    } catch (_) {
      try {
        initialDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').parse(date);
      } catch (e) {
        initialDate = DateTime.now();
      }
    }
  }

  String formattedDate1 = DateFormat('d MMM, yyyy').format(initialDate);
  
  // Keep temporary selection separate from the final picked date until "Done" is pressed
  DateTime tempSelectedDate = initialDate;
  ValueNotifier<String> selectedDate = ValueNotifier(formattedDate1);

  // Track whether user actually pressed Done
  bool isConfirmed = false;

  await showDialog<DateTime>(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Container(
          height: Get.height * .6,
          width: Get.width * .35,
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: selectedDate,
                  builder: (context, val, child) {
                    return Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        gradient: ThemeGradient.gradient,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Date",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                selectedDate.value,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                    primary: ThemeColors.primaryBlueColor,
                  )),
                  child: CalendarDatePicker(
                    initialDate: initialDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (DateTime newDate) {
                      tempSelectedDate = newDate; // Update temp tracker
                      selectedDate.value = DateFormat('d MMM, yyyy').format(newDate); // Live preview
                    },
                  ),
                ),
              ),
              // Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          buttonLabel: "Done",
                          onPressed: () {
                            isConfirmed = true; // Mark as confirmed
                            Get.back();
                          }),
                    ),
                    gapWC(10),
                    Expanded(
                      child: PrimaryButton(
                          buttonTextColor: ThemeColors.primaryBlueColor,
                          isOutlined: true,
                          buttonLabel: "Cancel",
                          onPressed: () {
                            isConfirmed = false; // Discard changes
                            Get.back();
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  // If user cancelled, return the original incoming date (or null/empty depending on your design)
  if (!isConfirmed) {
    return date ?? initialDate.toIso8601String();
  }

  return tempSelectedDate.toIso8601String();
}

Future<String> showCustomDatePicker({String? date}) async {
  DateTime initialDate =date!=null?DateTime.parse(date): DateTime.now();
  print("Initial Date: $initialDate");
  String formattedDate1 = DateFormat('d MMM, yyyy').format(initialDate);
   DateTime pickedDate = DateTime.now() ;

  ValueNotifier<String> selectedDate = ValueNotifier(formattedDate1);


  // Format: "12 Aug, 2024"

  // // Format: "12.08.2024"
  // String formattedDate2 = DateFormat('dd.MM.yyyy').format(now);

  // Combine both formats

  await showDialog<DateTime>(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Container(
          height: Get.height * .6,
          width: Get.width * .35,
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: selectedDate,
                  builder: (context, val, child) {
                    return Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        gradient: ThemeGradient.gradient
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Date",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                selectedDate.value,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                    primary: ThemeColors.primaryBlueColor,
                  )),
                  child: CalendarDatePicker(
                    
                    initialDate: initialDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (DateTime date) {
                      print(date);
                      selectedDate.value =
                          DateFormat('d MMM, yyyy').format(date);
                          pickedDate=date;
                    },
                  ),
                ),
              ),
              // Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          buttonLabel: "Done",
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                    gapWC(10),
                    Expanded(
                      child: PrimaryButton(
                          buttonTextColor: ThemeColors.primaryBlueColor,
                          isOutlined: true,
                          buttonLabel: "Cancel",
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return  pickedDate.toString() ;
}

Future<String> showCustomDatePickerExe({String? date}) async {
  DateTime now = DateTime.now();
  String formattedDate1 = DateFormat('d MMM, yyyy').format(now);

  ValueNotifier<String> selectedDate = ValueNotifier(formattedDate1);

  // Format: "12 Aug, 2024"

  // // Format: "12.08.2024"
  // String formattedDate2 = DateFormat('dd.MM.yyyy').format(now);

  // Combine both formats

  await showDialog<DateTime>(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: Get.height * .6,
          width: Get.width * .35,
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: selectedDate,
                  builder: (context, val, child) {
                    return Container(
                      width: double.infinity,
                      height: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        gradient:ThemeGradient.gradient
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select Date",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                selectedDate.value,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                    primary: ThemeColors.primaryBlueColor,
                  )),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (DateTime date) {
                      selectedDate.value =
                          DateFormat('d MMM, yyyy').format(date);
                    },
                  ),
                ),
              ),
              // Buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          buttonLabel: "Done",
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                    gapWC(10),
                    Expanded(
                      child: PrimaryButton(
                          buttonTextColor: ThemeColors.primaryBlueColor,
                          isOutlined: true,
                          buttonLabel: "Cancel",
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  // if (pickedDate != null && pickedDate != selectedDate) {
  //   // setState(() {
  //   //   selectedDate = pickedDate;
  //   // });
  // }
  return selectedDate.value;
}
