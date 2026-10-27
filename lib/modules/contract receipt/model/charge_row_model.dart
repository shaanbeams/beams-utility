import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ChargeRow {
  String name;
  RxDouble amount = 0.0.obs;
  RxDouble amountReceived = 0.0.obs;
  // RxDouble taxAmtReceived = 0.0.obs;
  RxDouble currentAmt = 0.0.obs;
  RxDouble total = 0.0.obs;
  RxDouble balance = 0.0.obs;
  RxDouble taxPerc = 0.0.obs;
  RxDouble currTaxAmount = 0.0.obs;
  RxDouble dailyBasicsAmt = 0.0.obs;
  late FocusNode focusNode;
  late TextEditingController txtCurrentAmt;

  ChargeRow({
    required this.name,
    double amount = 0.0,
    double amountReceived = 0.0,
    // double taxAmtReceived = 0.0,
    double currentAmt = 0.0,
    double total = 0.0,
    double taxTaxPerc = 0.0,
    double dailyBasicsAmt = 0.0,
    double balance = 0.0,
    double currTaxAmount = 0.0,
  }) {
    // Initialize the reactive fields
    this.amount = amount.obs;
    this.amountReceived = amountReceived.obs;
    // this.taxAmtReceived = taxAmtReceived.obs;
    this.currentAmt = currentAmt.obs;
    this.total = total.obs;
    this.currTaxAmount = currTaxAmount.obs;
    this.dailyBasicsAmt = dailyBasicsAmt.obs;
    this.taxPerc = taxTaxPerc.obs;
    this.balance = balance.obs;

    // Initialize the FocusNode and TextEditingController
    focusNode = FocusNode();
    txtCurrentAmt = TextEditingController(text: "0.0");
  }

  // Don't forget to dispose of FocusNode and TextEditingController when done
  void dispose() {
    focusNode.dispose();
    txtCurrentAmt.dispose();
  }
}
