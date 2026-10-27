// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounce/flutter_bounce.dart';
// import 'package:gas_utility_app/support/country_list.dart';
// import 'package:gas_utility_app/support/custom_theme.dart';

// class SelectCountryDialogue extends StatefulWidget {
//   const SelectCountryDialogue({Key? key, required this.onSelected})
//       : super(key: key);

//   final Function(Country) onSelected;

//   @override
//   State<SelectCountryDialogue> createState() => _SelectCountryDialogueState();
// }

// class _SelectCountryDialogueState extends State<SelectCountryDialogue> {
//   List<Country> filteredCountries = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     filteredCountries =
//         countryList; // Initialize with the full list of countries
//     searchController.addListener(filterCountries); // Listen for search changes
//   }

//   void filterCountries() {
//     String query = searchController.text.toLowerCase().trim();
//     setState(() {
//       filteredCountries = countryList
//           .where((country) =>
//               country.name.toLowerCase().contains(query) ||
//               country.dialCode.contains(query)) // Filter by matching the query
//           .toList();
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return AlertDialog(
//       backgroundColor: Colors.transparent,
//       contentPadding: EdgeInsets.zero,
//       insetPadding: const EdgeInsets.only(left: 0, right: 0),
//       content: ConstrainedBox(
//         constraints: BoxConstraints(maxHeight: height * 0.6),
//         child: Container(
//           width: width * 0.9,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(30)),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 decoration: const BoxDecoration(
//                     color: Colors.black,
//                     gradient:ThemeGradient.gradient,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     )),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Expanded(
//                             child: Center(
//                               child: Text(
//                                 "Select Country",
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Icon(
//                               Icons.close,
//                               size: 30,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//                       child: CupertinoSearchTextField(
//                         controller: searchController,
//                         placeholder: "Search Country",
//                         itemColor: Colors.white,
//                         backgroundColor: Colors.white.withOpacity(0.1),
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: filteredCountries.isNotEmpty
//                     ? Padding(
//                         padding: const EdgeInsets.only(bottom: 10.0),
//                         child: ListView.builder(
//                           shrinkWrap: true, // Wrap content instead of expanding
//                           itemCount: filteredCountries
//                               .length, // Display filtered countries
//                           itemBuilder: (context, index) {
//                             return Bounce(
//                               duration: const Duration(milliseconds: 100),
//                               onPressed: () {
//                                 widget.onSelected(filteredCountries[index]);
//                                 Navigator.pop(context);
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 5),
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(20),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.2),
//                                         spreadRadius: 2,
//                                         blurRadius: 5,
//                                         offset: const Offset(0, 5),
//                                       ),
//                                     ]),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 50,
//                                       child: Text(
//                                           "+ ${filteredCountries[index].dialCode}",
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold)),
//                                     ),
//                                     const SizedBox(
//                                       height: 40,
//                                       child: VerticalDivider(
//                                         color: Colors.black,
//                                         thickness: 1,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10.0),
//                                         child: Text(
//                                           filteredCountries[index].name,
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : const Center(
//                         child: Text("No matching countries found"),
//                       ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/support/country_list.dart';
import 'package:gas_utility_app/support/custom_theme.dart';

class SelectCountryDialogue extends StatefulWidget {
  const SelectCountryDialogue({Key? key, required this.onSelected})
      : super(key: key);

  final Function(Country) onSelected;

  @override
  State<SelectCountryDialogue> createState() => _SelectCountryDialogueState();
}

class _SelectCountryDialogueState extends State<SelectCountryDialogue> {
  List<Country> filteredCountries = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = countryList;
    searchController.addListener(filterCountries);
  }

  void filterCountries() {
    String query = searchController.text.toLowerCase().trim();
    setState(() {
      filteredCountries = countryList
          .where((country) =>
              country.name.toLowerCase().contains(query) ||
              country.dialCode.contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height * 0.6),
        child: Container(
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  gradient: ThemeGradient.gradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Perfectly Centered Title with Stack
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text(
                          "Select Country",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Search Bar
                    CupertinoSearchTextField(
                      controller: searchController,
                      placeholder: "Search Country",
                      itemColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.15),
                      style: const TextStyle(color: Colors.white),
                      placeholderStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),

              // Country List Section
              Expanded(
                child: filteredCountries.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          return Bounce(
                            duration: const Duration(milliseconds: 100),
                            onPressed: () {
                              widget.onSelected(country);
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.08),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 55,
                                    child: Text(
                                      "+${country.dialCode}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 20,
                                    color: Colors.grey.shade300,
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                  ),
                                  Expanded(
                                    child: Text(
                                      country.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: Text(
                            "No matching countries found",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}