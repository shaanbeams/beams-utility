// import 'package:flutter/material.dart';
// import 'package:flutter_bounce/flutter_bounce.dart';
// import 'package:gas_utility_app/modules/contract%20receipt/controller/contract_receipt_controller.dart';
// import 'package:gas_utility_app/modules/contract%20receipt/view/contract_receipt_page.dart';
// import 'package:gas_utility_app/modules/contract/controller/contract_controller.dart';
// import 'package:gas_utility_app/modules/contract/views/contract_main_details_page.dart';
// import 'package:gas_utility_app/modules/contract/views/contract_other_details_page.dart';
// import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
// import 'package:gas_utility_app/modules/home/view/widgets/select_doc_type_widget.dart';
// import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
// import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
// import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
// import 'package:gas_utility_app/support/custom_theme.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';

// import '../../../support/common_widgets/common_funtions.dart';
// import '../../../support/global.dart';
// import 'contract_request_page.dart';

// class ContractPage extends StatefulWidget {
//   ContractPage({super.key, this.isFromAssignPage = false});

//   final bool? isFromAssignPage;

//   @override
//   State<ContractPage> createState() => _ContractPageState();
// }

// class _ContractPageState extends State<ContractPage>
//     with SingleTickerProviderStateMixin {
//   late ValueNotifier<TabController> tabController;
//   ValueNotifier<bool> tabChanged = ValueNotifier(false);
//   PageController pageController = PageController();

//   late ContractController contractController = Get.put(ContractController());
//   // final ContractController contractController = Get.find<ContractController>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showLoadingDialog();
//     });

//     if (widget.isFromAssignPage == false) {
//       contractController.fngetLastContractDetails(mode: "LAST", docNo: "");
//     } else {
//       contractController.fngetContractDetails();
//       fnGetGasDocMaster(docType: Global.selectedDocType).then(
//         (value) {
//           contractController.txtCostCenterController.text = value[0]["CCCODE"];
//           contractController.txtDivisionController.text = value[0]["DIVCODE"];
//           contractController.txtBranchController.text = value[0]["BRNCODE"];
//         },
//       );
//     }
//     contractController.isEditModeEnabled.value =
//         widget.isFromAssignPage == true;
//     tabController = ValueNotifier(TabController(length: 3, vsync: this));
//   }

//   @override
//   void dispose() {
//     tabController.value.dispose();
//     pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       floatingActionButton: Obx(() => Container(
//             child: contractController.isEditModeEnabled.value == true
//                 ? Container()
//                 : Padding(
//                     padding: const EdgeInsets.only(bottom: 70),
//                     child: PrimaryButton(
//                       buttonLabel: "Pay Now",
//                       onPressed: () {
//                         selectDoctTypeDialogueNext(prvDocType: "GCR").then(
//                           (value) {
//                             // Get.delete<ContractReceiptController>();
//                             // Get.to(() => ContractReceiptPagesExe(
//                             //       contractNo: contractController.txtcontractNoController.text,
//                             //       isFromContractPage: true,
//                             //     ));
//                             Get.delete<ContractReceiptController>();
//                             Get.off(() => ContractReceiptPage(
//                                 isFromContractPage: true,
//                                 contractNo: contractController
//                                     .txtcontractNoController.text));
//                           },
//                         );
                       
//                       },
//                       buttonColor: ThemeColors.primaryGreenColor,
//                       buttonWidth: 150,
//                     )),
//           )),
//       bottomNavigationBar: Obx(() => CustomBottomNavBar(
//             fnonFirstButtonPressed: () {
//               contractController.fngetLastContractDetails(
//                   mode: "FIRST", docNo: "");
//             },
//             fnonPreviousButtonPressed: () {
//               contractController.fngetLastContractDetails(
//                   mode: "PREVIOUS",
//                   docNo: contractController.txtcontractNoController.text);
//             },
//             fnonLastButtonPressed: () {
//               contractController.fngetLastContractDetails(
//                   mode: "LAST", docNo: "");
//             },
//             fnonNextButtonPressed: () {
//               contractController.fngetLastContractDetails(
//                   mode: "NEXT",
//                   docNo: contractController.txtcontractNoController.text);
//             },
//             fnonSaveButtonPressed: () {
//               contractController.fnSaveContract();
//             },
//             fnonCancelPressed: widget.isFromAssignPage == true
//                 ? () {
//                     Get.back();
//                   }
//                 : () {
//                     contractController.isEditModeEnabled.value = false;
//                   },
//             fnonAddButtonPressed: () {
//               contractController.isEditModeEnabled.value =
//                   !contractController.isEditModeEnabled.value;
//             },
//             isEditIconEnabled: contractController.isEditModeEnabled.value,
//           )),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: Get.size.height / 3.8,
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.7),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//                 gradient: ThemeGradient.gradient,
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(30),
//                 )),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 50,bottom: 20),
//                   child: Row(
//                     children: [
//                       Bounce(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         duration: const Duration(milliseconds: 100),
//                         child: const Padding(
//                             padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                             child: Icon(
//                               Icons.arrow_back_ios_new_rounded,
//                               color: ThemeColors.white,
//                             )),
//                       ),
//                       Image.asset(
//                         "assets/icons/contract.png",
//                         height: 40,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Text(
//                           "Contract",
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                               color: ThemeColors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Obx(()=>
//                 Row(
//                   children: [
//                     Expanded(
//                         child: CustomSearchField(
//                       labelColor: Colors.white,
//                       label: "Request Doc Type",
//                       labelYn: true,
//                       hintLabel: "Request Doc Type",
//                       controller: contractController.txtReqDocTypeController,
//                     )),
//                     Expanded(
//                         child: CustomSearchField(
//                       controller: contractController.txtcontractNoController,
//                       labelColor: ThemeColors.white,
//                       label: "Contract No.",
//                       labelYn: true,
//                       hintLabel: "Contract No.",
//                       // fieldColor: ThemeColors.primaryBlueColor,
//                       hintSize: 12,
//                       onSearchTap: () {
//                         List searchColumn = [
//                           {
//                             "showItem": true,
//                             "columnName": "CONTRACT_NO",
//                             "showName": "Contract No"
//                           },
//                           {
//                             "showItem": true,
//                             "columnName": "PARTYNAME",
//                             "showName": "Party Name"
//                           },
//                           {
//                             "showItem": true,
//                             "columnName": "BUILDING_CODE",
//                             "showName": "Building Code"
//                           },
//                           {
//                             "showItem": true,
//                             "columnName": "APARTMENT_CODE",
//                             "showName": "Apartment Code"
//                           },
//                         ];
//                         Get.dialog(
//                           barrierDismissible: false,
//                           lookUpDialogue(
//                             callBackFn: (value) {
//                               contractController.txtcontractNoController.text =
//                                   value["CONTRACT_NO"].toString();
//                               contractController.fngetLastContractDetails(
//                                   mode: "VIEW",
//                                   docNo: contractController
//                                       .txtcontractNoController.text);
//                               Get.back();
//                             },
//                             tableName: "GGASCONTRACT",
//                             filter: [],
//                             searchColumn: searchColumn,
//                           ),
//                         );
//                       },
//                     )),
//                   ],
//                 ),
//                 // ),
//               ],
//             ),
//           ),
//           ValueListenableBuilder(
//               valueListenable: tabChanged,
//               builder: (context, val, child) {
//                 return _tabBar(
//                   tabController: tabController,
//                   pageController: pageController,
//                 );
//               }),
//           Expanded(
//               child: PageView(
//                   controller: pageController,
//                   onPageChanged: (value) {
//                     // setState(() {
//                     tabController.value.animateTo(
//                       value,
//                     );
//                     tabController.value.index = value;
//                     tabChanged.value = !tabChanged.value;
//                     // });
//                   },
//                   children: [
//                 ConnectionRequestPage(),
//                 ContractOtherPage(),
//                 ContractMainPage()
//               ])),
//         ],
//       ),
//     );
//   }
// }

// // class _tabBar extends StatefulWidget {
// //   _tabBar({
// //     super.key,
// //     required this.tabController,
// //     required this.pageController,
// //   });
// //   final ValueNotifier<TabController> tabController;
// //   final PageController pageController;

// //   @override
// //   State<_tabBar> createState() => _tabBarState();
// // }

// // class _tabBarState extends State<_tabBar> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Align(
// //       alignment: Alignment.centerLeft,
// //       child: Container(
// //         margin: const EdgeInsets.only(top: 5),
// //         child: TabBar(
// //           onTap: (value) {
// //             // setState(() {});
// //             widget.pageController.animateToPage(value,
// //                 duration: const Duration(milliseconds: 300),
// //                 curve: Curves.ease);
// //             // pageController.jumpToPage(value);
// //             widget.tabController.value.index = value;
// //           },
// //           tabAlignment: TabAlignment.start,
// //           splashFactory: NoSplash.splashFactory,
// //           controller: widget.tabController.value,
// //           automaticIndicatorColorAdjustment: false,
// //           dividerColor: Colors.transparent,
// //           indicatorSize: TabBarIndicatorSize.label,
// //           isScrollable: true,
// //           labelPadding: const EdgeInsets.symmetric(horizontal: 5),
// //           indicator: BoxDecoration(
// //             gradient: ThemeGradient.gradient,
// //             borderRadius: BorderRadius.circular(30),
// //           ),
// //           tabs: [
// //             Tab(
// //               child: Container(
// //                 height: 20,
// //                 padding: const EdgeInsets.symmetric(horizontal: 10),
// //                 alignment: Alignment.center,
// //                 child: Text(
// //                   "Connection Request",
// //                   style: TextStyle(
// //                     color: widget.tabController.value.index == 0
// //                         ? Colors.white
// //                         : Colors.black,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Tab(
// //               child: Container(
// //                 height: 20,
// //                 padding: const EdgeInsets.symmetric(horizontal: 10),
// //                 alignment: Alignment.center,
// //                 child: Text(
// //                   "Other",
// //                   style: TextStyle(
// //                     color: widget.tabController.value.index == 1
// //                         ? Colors.white
// //                         : Colors.black,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Tab(
// //               child: Container(
// //                 height: 20,
// //                 padding: const EdgeInsets.symmetric(horizontal: 10),
// //                 alignment: Alignment.center,
// //                 child: Text(
// //                   "Main",
// //                   style: TextStyle(
// //                     color: widget.tabController.value.index == 2
// //                         ? Colors.white
// //                         : Colors.black,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// class _tabBar extends StatefulWidget {
//   _tabBar({
//     super.key,
//     required this.tabController,
//     required this.pageController,
//   });
//   final ValueNotifier<TabController> tabController;
//   final PageController pageController;

//   @override
//   State<_tabBar> createState() => _tabBarState();
// }

// class _tabBarState extends State<_tabBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.only(top: 5),
//         // 1. Force the overall TabBar height here (e.g. 28 - 32 dp)
//         height: 30 ,
//         child: TabBar(
//           // 2. Remove default vertical padding inside the TabBar
//           padding: EdgeInsets.zero,
//           onTap: (value) {
//             widget.pageController.animateToPage(
//               value,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.ease,
//             );
//             widget.tabController.value.index = value;
//             setState(() {}); // Re-render to update selected text color
//           },
//           tabAlignment: TabAlignment.start,
//           splashFactory: NoSplash.splashFactory,
//           controller: widget.tabController.value,
//           automaticIndicatorColorAdjustment: false,
//           dividerColor: Colors.transparent,
//           indicatorSize: TabBarIndicatorSize.label,
//           isScrollable: true,
//           labelPadding: const EdgeInsets.symmetric(horizontal: 4),
//           indicator: BoxDecoration(
//             gradient: ThemeGradient.gradient,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           tabs: [
//             Tab(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Connection Request",
//                   style: TextStyle(
//                     fontSize: 14, // Reduced font size to fit smaller height
//                     color: widget.tabController.value.index == 0
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Other",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: widget.tabController.value.index == 1
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             Tab(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Main",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: widget.tabController.value.index == 2
//                         ? Colors.white
//                         : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract%20receipt/controller/contract_receipt_controller.dart';
import 'package:gas_utility_app/modules/contract%20receipt/view/contract_receipt_page.dart';
import 'package:gas_utility_app/modules/contract/controller/contract_controller.dart';
import 'package:gas_utility_app/modules/contract/views/contract_main_details_page.dart';
import 'package:gas_utility_app/modules/contract/views/contract_other_details_page.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/home/view/widgets/select_doc_type_widget.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/common_widgets/common_funtions.dart';
import '../../../support/global.dart';
import 'contract_request_page.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({super.key, this.isFromAssignPage = false});

  final bool? isFromAssignPage;

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final PageController _pageController = PageController();
  late final ContractController contractController = Get.put(ContractController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog();
    });

    if (widget.isFromAssignPage == false) {
      contractController.fngetLastContractDetails(mode: "LAST", docNo: "");
    } else {
      contractController.fngetContractDetails();
      fnGetGasDocMaster(docType: Global.selectedDocType).then(
        (value) {
          contractController.txtCostCenterController.text = value[0]["CCCODE"];
          contractController.txtDivisionController.text = value[0]["DIVCODE"];
          contractController.txtBranchController.text = value[0]["BRNCODE"];
        },
      );
    }
    contractController.isEditModeEnabled.value =
        widget.isFromAssignPage == true;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Obx(() => contractController.isEditModeEnabled.value
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: PrimaryButton(
                buttonLabel: "Pay Now",
                onPressed: () {
                  selectDoctTypeDialogueNext(prvDocType: "GCR").then((value) {
                    Get.delete<ContractReceiptController>();
                    Get.off(() => ContractReceiptPage(
                          isFromContractPage: true,
                          contractNo:
                              contractController.txtcontractNoController.text,
                        ));
                  });
                },
                buttonColor: ThemeColors.primaryGreenColor,
                buttonWidth: 150,
              ),
            )),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
        netAmount: contractController.totalAmountString.value,
        netAmountisRequired:true,
            fnonFirstButtonPressed: () {
              contractController.fngetLastContractDetails(
                  mode: "FIRST", docNo: "");
            },
            fnonPreviousButtonPressed: () {
              contractController.fngetLastContractDetails(
                  mode: "PREVIOUS",
                  docNo: contractController.txtcontractNoController.text);
            },
            fnonLastButtonPressed: () {
              contractController.fngetLastContractDetails(
                  mode: "LAST", docNo: "");
            },
            fnonNextButtonPressed: () {
              contractController.fngetLastContractDetails(
                  mode: "NEXT",
                  docNo: contractController.txtcontractNoController.text);
            },
            fnonSaveButtonPressed: () {
              contractController.fnSaveContract();
            },
            fnonCancelPressed: widget.isFromAssignPage == true
                ? () {
                    Get.back();
                  }
                : () {
                    contractController.isEditModeEnabled.value = false;
                  },
            fnonAddButtonPressed: () {
              contractController.isEditModeEnabled.value =
                  !contractController.isEditModeEnabled.value;
            },
            isEditIconEnabled: contractController.isEditModeEnabled.value,
          )),
      body: Column(
        children: [
          // Header Container with intrinsic sizing to eliminate dead space
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.35),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
              gradient: ThemeGradient.gradient,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Bounce(
                          onPressed: () => Get.back(),
                          duration: const Duration(milliseconds: 100),
                          child: const Padding(
                            padding: EdgeInsets.only(right: 14),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: ThemeColors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/icons/contract.png",
                          height: 32,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Contract",
                          style: GoogleFonts.poppins(
                            color: ThemeColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomSearchField(
                            labelColor: Colors.white,
                            label: "Request Doc Type",
                            labelYn: true,
                            hintLabel: "Request Doc Type",
                            controller:
                                contractController.txtReqDocTypeController,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomSearchField(
                            controller:
                                contractController.txtcontractNoController,
                            labelColor: ThemeColors.white,
                            label: "Contract No.",
                            labelYn: true,
                            hintLabel: "Contract No.",
                            hintSize: 12,
                            onSearchTap: () {
                              List searchColumn = [
                                {
                                  "showItem": true,
                                  "columnName": "CONTRACT_NO",
                                  "showName": "Contract No"
                                },
                                {
                                  "showItem": true,
                                  "columnName": "PARTYNAME",
                                  "showName": "Party Name"
                                },
                                {
                                  "showItem": true,
                                  "columnName": "BUILDING_CODE",
                                  "showName": "Building Code"
                                },
                                {
                                  "showItem": true,
                                  "columnName": "APARTMENT_CODE",
                                  "showName": "Apartment Code"
                                },
                              ];
                              Get.dialog(
                                barrierDismissible: false,
                                lookUpDialogue(
                                  callBackFn: (value) {
                                    contractController
                                            .txtcontractNoController.text =
                                        value["CONTRACT_NO"].toString();
                                    contractController
                                        .fngetLastContractDetails(
                                            mode: "VIEW",
                                            docNo: contractController
                                                .txtcontractNoController.text);
                                    Get.back();
                                  },
                                  tableName: "GGASCONTRACT",
                                  filter: const [],
                                  searchColumn: searchColumn,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Smooth Tab Bar
          _CustomTabBar(
            tabController: _tabController,
            pageController: _pageController,
          ),

          // Page Views
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
              children:   [
                ConnectionRequestPage(),
                ContractOtherPage(),
                ContractMainPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  const _CustomTabBar({
    required this.tabController,
    required this.pageController,
  });

  final TabController tabController;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: 36,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black87,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        indicator: BoxDecoration(
          gradient: ThemeGradient.gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );
        },
        tabs: const [
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text("Connection Request"),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text("Customer Details"),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text("Price details"),
            ),
          ),
        ],
      ),
    );
  }
}