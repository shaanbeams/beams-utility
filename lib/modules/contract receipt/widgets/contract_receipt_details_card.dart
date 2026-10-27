import 'package:flutter/material.dart';
import 'package:gas_utility_app/modules/contract%20receipt/controller/contract_receipt_controller.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailCard extends StatelessWidget {
  DetailCard(
      {super.key,
      required this.tenantName,
      required this.contractNo,
      required this.buildingNo,
      required this.apartmentNo,
      required this.buildingName});

  ContractReceiptController contractReceiptController =
      Get.put(ContractReceiptController());

  final String tenantName, contractNo, buildingNo, apartmentNo, buildingName;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          gradient: ThemeGradient.gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(30)),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tHead(
                title: "Contract No : ",
              ),
              _tValue(value: contractNo),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tHead(
                title: "Building No : ",
              ),
              _tValue(value: buildingNo),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tHead(
                title: "Apartment No : ",
              ),
              _tValue(value: apartmentNo),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _tHead(
                title: "Building Name : ",
              ),
              Expanded(child: _tValue(value: buildingName)),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tHead(
                title: "Tenant Name : ",
              ),
              _tValue(value: tenantName),
            ],
          ),
        ],
      ),
    );
  }
}

Text _tHead({required String title, Color? color}) {
  return Text(
    title,
    style: GoogleFonts.poppins(
        color: color ?? ThemeColors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

Text _tValue({required String value, Color? color}) {
  return Text(
    value,
    style: GoogleFonts.poppins(
      color: color ?? ThemeColors.white,
      fontSize: 11,
    ),
    textAlign: TextAlign.center,
  );
}
