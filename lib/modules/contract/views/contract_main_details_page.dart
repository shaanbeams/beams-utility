// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/controller/contract_controller.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/custom_date_picker.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/image_picker.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/common_widgets/signature_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/enums.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContractMainPage extends StatelessWidget {
  ContractMainPage({
    super.key,
  });

  final ContractController contractController =
      Get.put(ContractController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Price Details",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.info_outline),
                const Spacer(),
                Bounce(
                  onPressed: () {
                    contractController.isEditModeEnabled.value = true;
                    contractController.saveMode.value = SaveModes.edit;
                  },
                  duration: const Duration(milliseconds: 100),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: ThemeColors.primaryBlueColor,
                    child: Icon(Icons.edit_outlined,
                        color: ThemeColors.white, size: 20),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    label: "Status",
                    hintLabel: "Status",
                    hintSize: 11,
                    onSearchTap: () {
                      if (contractController.isEditModeEnabled.value) {
                        List searchColumn = [
                          {
                            "showItem": true,
                            "columnName": "CODE",
                            "showName": "Code"
                          },
                          {
                            "showItem": true,
                            "columnName": "DESCP",
                            "showName": "Description"
                          },
                        ];
                        Get.dialog(
                          barrierDismissible: false,
                          lookUpDialogue(
                            tableName: "GCONNECTION_STATUS",
                            callBackFn: (value) {
                              contractController.txtStatusController.text =
                                  value["CODE"].toString();
                              Get.back();
                            },
                            filter: [],
                            searchColumn: searchColumn,
                          ),
                        );
                      }
                    },
                    controller: contractController.txtStatusController,
                  ),
                ),
                Expanded(
                  child: PrimaryInputField(
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    hintText: "Gas Meter No.",
                    txtController: contractController.txtGasMeterNoController,
                  ),
                ),
              ],
            ),
            gapHC(5),
            Row(
              children: [
                Expanded(
                  child: PrimaryInputField(
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    hintText: "Reading Conversion",
                    txtController: contractController.txtReadingConvController,
                  ),
                ),
                gapWC(10),
                Expanded(
                  child: PrimaryInputField(
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    hintText: "Consumption conversion",
                    txtController:
                        contractController.txtConsumptionConvController,
                  ),
                ),
              ],
            ),
            gapHC(5),
            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintText: "Total Amount",
              txtController: contractController.txtTotalAmountController,
            ),
            gapHC(5),
            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintText: "Unit Price ( AED )",
              txtController: contractController.txtUnitPriceController,
            ),
            gapHC(10),
            DetailsExpansion(),
            gapHC(5),
            Row(
              children: [
                Expanded(
                  child: PrimaryInputField(
                    enablests: contractController.isEditModeEnabled.value,
                    labelYn: true,
                    hintText: "Start Reading",
                    txtController: contractController.txtStartReadingController,
                  ),
                ),
                gapWC(10),
                Expanded(
                    child: PrimaryInputField(
                  textType: TextInputType.number,
                  enablests: contractController.isEditModeEnabled.value,
                  labelYn: true,
                  hintText: "Last Reading ",
                  txtController: contractController.txtLastReadingController,
                )
                    // formatter: [
                    //   FilteringTextInputFormatter.digitsOnly,
                    //   LengthLimitingTextInputFormatter(
                    //       2),
                    //  RangeInputFormatterForMonth(),
                    // ]),
                    ),
              ],
            ),
            gapHC(5),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last reading Date",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                              Helper.convertDateFormat2(
                                  dateTime:
                                      contractController.lastReadingDate.value),
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Bounce(
                      onPressed: contractController.isEditModeEnabled.value
                          ? () async {
                              var date = await showCustomDatePicker2(
                                  date:
                                      contractController.lastReadingDate.value);
                              contractController.lastReadingDate.value =
                                  date ?? "";
                            }
                          : () {},
                      duration: const Duration(milliseconds: 100),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            contractController.isEditModeEnabled.value
                                ? ThemeColors.primaryBlueColor
                                : ThemeColors.grey,
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: ThemeColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            gapHC(5),
            PrimaryInputField(
              enablests: contractController.isEditModeEnabled.value,
              labelYn: true,
              hintText: "Remarks",
              isTextArea: true,
            ),
            gapHC(5),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: () async {
                        if (contractController.isEditModeEnabled.value) {
                          Helper.fnImageToBase64().then(
                            (bytes) {
                              contractController.lbytesImage1.value =
                                  bytes ?? Uint8List(0);
                            },
                          );
                        }
                      },
                      child: CustomImagePicker(
                        label: "EID Front image",
                        image: contractController.lbytesImage1.value,
                        enable: contractController.isEditModeEnabled.value,
                      ),
                    ),
                  ),
                  gapWC(10),
                  Expanded(
                    child: Bounce(
                      duration: Duration(milliseconds: 100),
                      onPressed: () async {
                        if (contractController.isEditModeEnabled.value) {
                          // contractController.fnImageToBase64(2);
                          Helper.fnImageToBase64().then(
                            (bytes) {
                              contractController.lbytesImage2.value =
                                  bytes ?? Uint8List(0);
                            },
                          );
                          ;
                        }
                      },
                      child: CustomImagePicker(
                        label: "Back image",
                        image: contractController.lbytesImage2.value,
                        enable: contractController.isEditModeEnabled.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            gapHC(5),
            Obx(
              () => SignatureField(
                isEnabled: contractController.isEditModeEnabled.value == true,
                lstrSignature: contractController.lstrSignature,
                signatureController: contractController.signatureController,
                curveRadius: 10,
              ),
            ),
            gapHC(60),
          ],
        ),
      ),
    );
  }
}

// class _detailsExpansion extends StatelessWidget {
//   _detailsExpansion({
//     super.key,
//   });
//   ContractController contractController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: ExpansionTile(
//         collapsedIconColor: Colors.white,
//         iconColor: Colors.white,
//         title: Text("Amount Details",
//             style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold)),
//         children: [
//           Row(
//             children: [
//               Expanded(flex: 5, child: Container()),
//               Expanded(
//                   flex: 3,
//                   child: Center(
//                     child: Text("Amount",
//                         style: GoogleFonts.poppins(
//                             color: ThemeColors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold)),
//                   )),
//               Expanded(
//                   flex: 2,
//                   child: Center(
//                     child: Text("VAT %",
//                         style: GoogleFonts.poppins(
//                             color: ThemeColors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold)),
//                   ))
//             ],
//           ),
//           _amountDetailsItem(
//             headValue: "Monthly Amount",
//             amountValueController: contractController.txtMonthlyController,
//             vatAmountController: contractController.txtMonthlyVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Boiler gas Amount",
//             amountValueController: contractController.txtBoilerGasController,
//             vatAmountController: contractController.txtBoilerGasVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Insurance Amount",
//             amountValueController: contractController.txtInsuranceController,
//             vatAmountController: contractController.txtInsuranceVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Deposit Amount",
//             amountValueController: contractController.txtDepositController,
//             vatAmountController: contractController.txtDepositVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Connection Amount",
//             amountValueController: contractController.txtConnectionController,
//             vatAmountController: contractController.txtConnectionVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Maintenance Amount",
//             amountValueController: contractController.txtMaintananceController,
//             vatAmountController: contractController.txtMaintananceVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Disconnection Amount",
//             amountValueController:
//                 contractController.txtDisconnectionController,
//             vatAmountController:
//                 contractController.txtDisconnectionVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Clearance Amount",
//             amountValueController: contractController.txtClearanceController,
//             vatAmountController: contractController.txtClearanceVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Registration Amount",
//             amountValueController: contractController.txtRegistrationController,
//             vatAmountController:
//                 contractController.txtRegistrationVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Administration Amount",
//             amountValueController:
//                 contractController.txtAdministrationController,
//             vatAmountController:
//                 contractController.txtAdministrationVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Bill meter Reading Amount",
//             amountValueController:
//                 contractController.txtBillMeterReadingController,
//             vatAmountController:
//                 contractController.txtBillMeterReadingVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Facility Amount",
//             amountValueController: contractController.txtFacilityController,
//             vatAmountController: contractController.txtFacilityVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Delay Payment Amount",
//             amountValueController: contractController.txtDelayController,
//             vatAmountController: contractController.txtDelayVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Security Amount",
//             amountValueController: contractController.txtSecurityController,
//             vatAmountController: contractController.txtSecurityVATController,
//           ),
//           _amountDetailsItem(
//             headValue: "Other Amount 1",
//             amountValueController: contractController.txtOther1Controller,
//             vatAmountController: contractController.txtOtherVAT1Controller,
//           ),
//           _amountDetailsItem(
//             headValue: "Other Amount 2",
//             amountValueController: contractController.txtOther2Controller,
//             vatAmountController: contractController.txtOtherVAT2Controller,
//           ),
//           _amountDetailsItem(
//             headValue: "Other Amount 3",
//             amountValueController: contractController.txtOther3Controller,
//             vatAmountController: contractController.txtOtherVAT3Controller,
//           ),
//         ],
//       ),
//     );
//   }
// }

class DetailsExpansion extends StatefulWidget {
  const DetailsExpansion({super.key});

  @override
  State<DetailsExpansion> createState() => _DetailsExpansionState();
}

class _DetailsExpansionState extends State<DetailsExpansion> {
  final ContractController contractController = Get.find();

  // List of field definitions to cleanly map inputs dynamically
  final List<Map<String, dynamic>> _amountFields = [
    {
      "title": "Monthly Amount",
      "amount": (ContractController c) => c.txtMonthlyController,
      "vat": (ContractController c) => c.txtMonthlyVATController
    },
    {
      "title": "Boiler Gas Amount",
      "amount": (ContractController c) => c.txtBoilerGasController,
      "vat": (ContractController c) => c.txtBoilerGasVATController
    },
    {
      "title": "Insurance Amount",
      "amount": (ContractController c) => c.txtInsuranceController,
      "vat": (ContractController c) => c.txtInsuranceVATController
    },
    {
      "title": "Deposit Amount",
      "amount": (ContractController c) => c.txtDepositController,
      "vat": (ContractController c) => c.txtDepositVATController
    },
    {
      "title": "Connection Amount",
      "amount": (ContractController c) => c.txtConnectionController,
      "vat": (ContractController c) => c.txtConnectionVATController
    },
    {
      "title": "Maintenance Amount",
      "amount": (ContractController c) => c.txtMaintananceController,
      "vat": (ContractController c) => c.txtMaintananceVATController
    },
    {
      "title": "Disconnection Amount",
      "amount": (ContractController c) => c.txtDisconnectionController,
      "vat": (ContractController c) => c.txtDisconnectionVATController
    },
    {
      "title": "Clearance Amount",
      "amount": (ContractController c) => c.txtClearanceController,
      "vat": (ContractController c) => c.txtClearanceVATController
    },
    {
      "title": "Registration Amount",
      "amount": (ContractController c) => c.txtRegistrationController,
      "vat": (ContractController c) => c.txtRegistrationVATController
    },
    {
      "title": "Administration Amount",
      "amount": (ContractController c) => c.txtAdministrationController,
      "vat": (ContractController c) => c.txtAdministrationVATController
    },
    {
      "title": "Bill Meter Reading",
      "amount": (ContractController c) => c.txtBillMeterReadingController,
      "vat": (ContractController c) => c.txtBillMeterReadingVATController
    },
    {
      "title": "Facility Amount",
      "amount": (ContractController c) => c.txtFacilityController,
      "vat": (ContractController c) => c.txtFacilityVATController
    },
    {
      "title": "Delay Payment",
      "amount": (ContractController c) => c.txtDelayController,
      "vat": (ContractController c) => c.txtDelayVATController
    },
    {
      "title": "Security Amount",
      "amount": (ContractController c) => c.txtSecurityController,
      "vat": (ContractController c) => c.txtSecurityVATController
    },
    {
      "title": "Other Amount 1",
      "amount": (ContractController c) => c.txtOther1Controller,
      "vat": (ContractController c) => c.txtOtherVAT1Controller
    },
    {
      "title": "Other Amount 2",
      "amount": (ContractController c) => c.txtOther2Controller,
      "vat": (ContractController c) => c.txtOtherVAT2Controller
    },
    {
      "title": "Other Amount 3",
      "amount": (ContractController c) => c.txtOther3Controller,
      "vat": (ContractController c) => c.txtOtherVAT3Controller
    },
  ];

  @override
  void initState() {
    super.initState();
    // Listen to changes on all text controllers to trigger state updates for the total
    for (var field in _amountFields) {
      TextEditingController amtCtrl = field["amount"](contractController);
      TextEditingController vatCtrl = field["vat"](contractController);

      amtCtrl.addListener(_onValueChanged);
      vatCtrl.addListener(_onValueChanged);
    }
  }

  void _onValueChanged() {
    // Calls setState so the total calculation widget rebuilds when text changes
    setState(() {});
    contractController.txtTotalAmountController.text =
        _calculateGrandTotal().toStringAsFixed(2);
    contractController.totalAmountString.value =
        _calculateGrandTotal().toStringAsFixed(2);
  }

  @override
  void dispose() {
    // Clean up listeners to prevent memory leaks
    for (var field in _amountFields) {
      TextEditingController amtCtrl = field["amount"](contractController);
      TextEditingController vatCtrl = field["vat"](contractController);

      amtCtrl.removeListener(_onValueChanged);
      vatCtrl.removeListener(_onValueChanged);
    }
    super.dispose();
  }

  // Calculate total amount + VAT dynamically
  double _calculateGrandTotal() {
    double total = 0.0;
    for (var field in _amountFields) {
      TextEditingController amtCtrl = field["amount"](contractController);
      TextEditingController vatCtrl = field["vat"](contractController);

      double amount = double.tryParse(amtCtrl.text) ?? 0.0;
      double vatPercent = double.tryParse(vatCtrl.text) ?? 0.0;

      // Add amount plus its calculated VAT portion
      double itemTotal = amount + (amount * (vatPercent / 100));
      total += itemTotal;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: ThemeColors.primaryBlueColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          collapsedBackgroundColor: ThemeColors.black,
          collapsedIconColor: Colors.white,
          iconColor: ThemeColors.primaryBlueColor,
          collapsedTextColor: ThemeColors.white,
          title: Text(
            "Amount Details",
            style: GoogleFonts.poppins(
              // color:  ThemeColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            // Header Row
            Row(
              children: [
                const Expanded(flex: 6, child: SizedBox()),
                Expanded(
                  flex: 10,
                  child: Center(
                    child: Text(
                      "Amount",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF6B7280),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "VAT %",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: ThemeColors.primaryBlueColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Dynamically Rendered List Items
            ..._amountFields.map((field) {
              return _buildAmountDetailsItem(
                headValue: field["title"],
                amountValueController: field["amount"](contractController),
                vatAmountController: field["vat"](contractController),
              );
            }),

            // Grand Total Footer Box
            // Container(
            //   margin: const EdgeInsets.all(12),
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //   decoration: BoxDecoration(
            //     color: Colors.blue.shade50,
            //     borderRadius: BorderRadius.circular(8),
            //     border: Border.all(color: Colors.blue.shade100),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Grand Total (incl. VAT):",
            //         style: GoogleFonts.poppins(
            //           color: const Color(0xFF1E3A8A),
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       Text(
            //         _calculateGrandTotal().toStringAsFixed(2),
            //         style: GoogleFonts.poppins(
            //           color: const Color(0xFF1D4ED8),
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountDetailsItem({
    required String headValue,
    required TextEditingController amountValueController,
    required TextEditingController vatAmountController,
  }) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        // borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: Text(
              headValue,
              style: GoogleFonts.poppins(
                color: const Color(0xFF374151),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 8,
            child: SizedBox(
              height: 38,
              child: TextField(
                textAlign: TextAlign.end,
                controller: amountValueController,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF111827),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "0.00",
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.grey.shade400, fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 38,
              child: TextField(
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  DecimalVATTextInputFormatter(decimalRange: 2),
                ],
                controller: vatAmountController,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF111827),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "%",
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.grey.shade400, fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _amountDetailsItem extends StatelessWidget {
  _amountDetailsItem({
    super.key,
    required this.headValue,
    required this.amountValueController,
    required this.vatAmountController,
  });

  final String headValue;
  final TextEditingController amountValueController, vatAmountController;
  ContractController contractController = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Obx(() => Row(children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Text(
                      headValue,
                      style: GoogleFonts.poppins(
                        color: ThemeColors.black,
                        fontSize: 12,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: PrimaryInputField(
                      enablests: true,
                      hintText: "",
                      txtRadius: 10,
                      txtController: amountValueController,
                      textType: TextInputType.number)),
              gapWC(2),
              Expanded(
                  flex: 2,
                  child: PrimaryInputField(
                      enablests: contractController.isEditModeEnabled.value,
                      hintText: "",
                      txtRadius: 10,
                      txtController: vatAmountController,
                      textType: TextInputType.number))
            ])));
  }
}

class DecimalVATTextInputFormatter extends TextInputFormatter {
  final int decimalRange;
  final bool allowNegative;

  DecimalVATTextInputFormatter({
    this.decimalRange = 2,
    this.allowNegative = false,
  }) : assert(decimalRange >= 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    // Build regex based on whether negative numbers are allowed
    final pattern = allowNegative
        ? r'^-?\d*\.?\d{0,' + decimalRange.toString() + r'}$'
        : r'^\d*\.?\d{0,' + decimalRange.toString() + r'}$';

    final regex = RegExp(pattern);

    if (regex.hasMatch(newValue.text)) {
      // Prevent redundant leading zeros (e.g., "00", "005")
      if (_hasInvalidLeadingZeros(newValue.text)) {
        return oldValue;
      }
      return newValue;
    }

    return oldValue;
  }

  bool _hasInvalidLeadingZeros(String text) {
    if (text.startsWith('0') && text.length > 1 && text[1] != '.') {
      return true;
    }
    if (text.startsWith('-0') && text.length > 2 && text[2] != '.') {
      return true;
    }
    return false;
  }
}
