// // To parse this JSON data, do
// //
// //     final contractReceiptModel = contractReceiptModelFromJson(jsonString);

// import 'dart:convert';

// ContractReceiptModel contractReceiptModelFromJson(String str) => ContractReceiptModel.fromJson(json.decode(str));

// // String contractReceiptModelToJson(ContractReceiptModel data) => json.encode(data.toJson());

// class ContractReceiptModel {
//     final String? contractNo;
//     final String? doctype;
//     final String? partycode;
//     final String? partyname;
//     final String? buildingCode;
//     final String? buildingDescp;
//     final String? apartmentCode;
//     final String? connectionDate;
//     final String? insAmt;
//     final String? depAmt;
//     final String? connectionAmt;
//     final String? maintenanceAmt;
//     final String? disconnectionAmt;
//     final String? registrationAmt;
//     final String? other1Amt;
//     final String? other2Amt;
//     final String? other3Amt;
//     final String? insuranceVatperc;
//     final String? depositVatperc;
//     final String? connectionVatperc;
//     final String? maintenanceVatperc;
//     final String? disconnectionVatperc;
//     final String? registrationVatperc;
//     final String? otheramtVatperc;
//     final String? otheramt2Vatperc;
//     final String? otheramt3Vatperc;
//     final String? insAmtReceived;
//     final String? depAmtReceived;
//     final String? connectionAmtReceived;
//     final String? maintenanceAmtReceived;
//     final String? disconnectionAmtReceived;
//     final String? registrationAmtReceived;
//     final String? other1AmtReceived;
//     final String? other2AmtReceived;
//     final String? other3AmtReceived;
//     final String? insTaxReceived;
//     final String? depTaxReceived;
//     final String? connectionTaxReceived;
//     final String? maintenanceTaxReceived;
//     final String? disconnectionTaxReceived;
//     final String? registrationTaxReceived;
//     final String? other1TaxReceived;
//     final String? other2TaxReceived;
//     final String? other3TaxReceived;

//     ContractReceiptModel({
//         this.contractNo,
//         this.doctype,
//         this.partycode,
//         this.partyname,
//         this.buildingCode,
//         this.buildingDescp,
//         this.apartmentCode,
//         this.connectionDate,
//         this.insAmt,
//         this.depAmt,
//         this.connectionAmt,
//         this.maintenanceAmt,
//         this.disconnectionAmt,
//         this.registrationAmt,
//         this.other1Amt,
//         this.other2Amt,
//         this.other3Amt,
//         this.insuranceVatperc,
//         this.depositVatperc,
//         this.connectionVatperc,
//         this.maintenanceVatperc,
//         this.disconnectionVatperc,
//         this.registrationVatperc,
//         this.otheramtVatperc,
//         this.otheramt2Vatperc,
//         this.otheramt3Vatperc,
//         this.insAmtReceived,
//         this.depAmtReceived,
//         this.connectionAmtReceived,
//         this.maintenanceAmtReceived,
//         this.disconnectionAmtReceived,
//         this.registrationAmtReceived,
//         this.other1AmtReceived,
//         this.other2AmtReceived,
//         this.other3AmtReceived,
//         this.insTaxReceived,
//         this.depTaxReceived,
//         this.connectionTaxReceived,
//         this.maintenanceTaxReceived,
//         this.disconnectionTaxReceived,
//         this.registrationTaxReceived,
//         this.other1TaxReceived,
//         this.other2TaxReceived,
//         this.other3TaxReceived,
//     });

//     ContractReceiptModel copyWith({
//         String? contractNo,
//         String? doctype,
//         String? partycode,
//         String? partyname,
//         String? buildingCode,
//         String? buildingDescp,
//         String? apartmentCode,
//         String? connectionDate,
//         String? insAmt,
//         String? depAmt,
//         String? connectionAmt,
//         String? maintenanceAmt,
//         String? disconnectionAmt,
//         String? registrationAmt,
//         String? other1Amt,
//         String? other2Amt,
//         String? other3Amt,
//         String? insuranceVatperc,
//         String? depositVatperc,
//         String? connectionVatperc,
//         String? maintenanceVatperc,
//         String? disconnectionVatperc,
//         String? registrationVatperc,
//         String? otheramtVatperc,
//         String? otheramt2Vatperc,
//         String? otheramt3Vatperc,
//         String? insAmtReceived,
//         String? depAmtReceived,
//         String? connectionAmtReceived,
//         String? maintenanceAmtReceived,
//         String? disconnectionAmtReceived,
//         String? registrationAmtReceived,
//         String? other1AmtReceived,
//         String? other2AmtReceived,
//         String? other3AmtReceived,
//         String? insTaxReceived,
//         String? depTaxReceived,
//         String? connectionTaxReceived,
//         String? maintenanceTaxReceived,
//         String? disconnectionTaxReceived,
//         String? registrationTaxReceived,
//         String? other1TaxReceived,
//         String? other2TaxReceived,
//         String? other3TaxReceived,
//     }) =>
//         ContractReceiptModel(
//             contractNo: contractNo ?? this.contractNo,
//             doctype: doctype ?? this.doctype,
//             partycode: partycode ?? this.partycode,
//             partyname: partyname ?? this.partyname,
//             buildingCode: buildingCode ?? this.buildingCode,
//             buildingDescp: buildingDescp ?? this.buildingDescp,
//             apartmentCode: apartmentCode ?? this.apartmentCode,
//             connectionDate: connectionDate ?? this.connectionDate,
//             insAmt: insAmt ?? this.insAmt,
//             depAmt: depAmt ?? this.depAmt,
//             connectionAmt: connectionAmt ?? this.connectionAmt,
//             maintenanceAmt: maintenanceAmt ?? this.maintenanceAmt,
//             disconnectionAmt: disconnectionAmt ?? this.disconnectionAmt,
//             registrationAmt: registrationAmt ?? this.registrationAmt,
//             other1Amt: other1Amt ?? this.other1Amt,
//             other2Amt: other2Amt ?? this.other2Amt,
//             other3Amt: other3Amt ?? this.other3Amt,
//             insuranceVatperc: insuranceVatperc ?? this.insuranceVatperc,
//             depositVatperc: depositVatperc ?? this.depositVatperc,
//             connectionVatperc: connectionVatperc ?? this.connectionVatperc,
//             maintenanceVatperc: maintenanceVatperc ?? this.maintenanceVatperc,
//             disconnectionVatperc: disconnectionVatperc ?? this.disconnectionVatperc,
//             registrationVatperc: registrationVatperc ?? this.registrationVatperc,
//             otheramtVatperc: otheramtVatperc ?? this.otheramtVatperc,
//             otheramt2Vatperc: otheramt2Vatperc ?? this.otheramt2Vatperc,
//             otheramt3Vatperc: otheramt3Vatperc ?? this.otheramt3Vatperc,
//             insAmtReceived: insAmtReceived ?? this.insAmtReceived,
//             depAmtReceived: depAmtReceived ?? this.depAmtReceived,
//             connectionAmtReceived: connectionAmtReceived ?? this.connectionAmtReceived,
//             maintenanceAmtReceived: maintenanceAmtReceived ?? this.maintenanceAmtReceived,
//             disconnectionAmtReceived: disconnectionAmtReceived ?? this.disconnectionAmtReceived,
//             registrationAmtReceived: registrationAmtReceived ?? this.registrationAmtReceived,
//             other1AmtReceived: other1AmtReceived ?? this.other1AmtReceived,
//             other2AmtReceived: other2AmtReceived ?? this.other2AmtReceived,
//             other3AmtReceived: other3AmtReceived ?? this.other3AmtReceived,
//             insTaxReceived: insTaxReceived ?? this.insTaxReceived,
//             depTaxReceived: depTaxReceived ?? this.depTaxReceived,
//             connectionTaxReceived: connectionTaxReceived ?? this.connectionTaxReceived,
//             maintenanceTaxReceived: maintenanceTaxReceived ?? this.maintenanceTaxReceived,
//             disconnectionTaxReceived: disconnectionTaxReceived ?? this.disconnectionTaxReceived,
//             registrationTaxReceived: registrationTaxReceived ?? this.registrationTaxReceived,
//             other1TaxReceived: other1TaxReceived ?? this.other1TaxReceived,
//             other2TaxReceived: other2TaxReceived ?? this.other2TaxReceived,
//             other3TaxReceived: other3TaxReceived ?? this.other3TaxReceived,
//         );

//     factory ContractReceiptModel.fromJson(Map<String, dynamic> json) => ContractReceiptModel(
//         contractNo: json["CONTRACT_NO"],
//         doctype: json["DOCTYPE"],
//         partycode: json["PARTYCODE"],
//         partyname: json["PARTYNAME"],
//         buildingCode: json["BUILDING_CODE"],
//         buildingDescp: json["BUILDING_DESCP"],
//         apartmentCode: json["APARTMENT_CODE"],
//         connectionDate: json["CONNECTION_DATE"],
//         insAmt: json["INS_AMT"],
//         depAmt: json["DEP_AMT"],
//         connectionAmt: json["CONNECTION_AMT"],
//         maintenanceAmt: json["MAINTENANCE_AMT"],
//         disconnectionAmt: json["DISCONNECTION_AMT"],
//         registrationAmt: json["REGISTRATION_AMT"],
//         other1Amt: json["OTHER1_AMT"],
//         other2Amt: json["OTHER2_AMT"],
//         other3Amt: json["OTHER3_AMT"],
//         insuranceVatperc: json["INSURANCE_VATPERC"],
//         depositVatperc: json["DEPOSIT_VATPERC"],
//         connectionVatperc: json["CONNECTION_VATPERC"],
//         maintenanceVatperc: json["MAINTENANCE_VATPERC"],
//         disconnectionVatperc: json["DISCONNECTION_VATPERC"],
//         registrationVatperc: json["REGISTRATION_VATPERC"],
//         otheramtVatperc: json["OTHERAMT_VATPERC"],
//         otheramt2Vatperc: json["OTHERAMT2_VATPERC"],
//         otheramt3Vatperc: json["OTHERAMT3_VATPERC"],
//         insAmtReceived: json["INS_AMT_RECEIVED"],
//         depAmtReceived: json["DEP_AMT_RECEIVED"],
//         connectionAmtReceived: json["CONNECTION_AMT_RECEIVED"],
//         maintenanceAmtReceived: json["MAINTENANCE_AMT_RECEIVED"],
//         disconnectionAmtReceived: json["DISCONNECTION_AMT_RECEIVED"],
//         registrationAmtReceived: json["REGISTRATION_AMT_RECEIVED"],
//         other1AmtReceived: json["OTHER1_AMT_RECEIVED"],
//         other2AmtReceived: json["OTHER2_AMT_RECEIVED"],
//         other3AmtReceived: json["OTHER3_AMT_RECEIVED"],
//         insTaxReceived: json["INS_TAX_RECEIVED"],
//         depTaxReceived: json["DEP_TAX_RECEIVED"],
//         connectionTaxReceived: json["CONNECTION_TAX_RECEIVED"],
//         maintenanceTaxReceived: json["MAINTENANCE_TAX_RECEIVED"],
//         disconnectionTaxReceived: json["DISCONNECTION_TAX_RECEIVED"],
//         registrationTaxReceived: json["REGISTRATION_TAX_RECEIVED"],
//         other1TaxReceived: json["OTHER1_TAX_RECEIVED"],
//         other2TaxReceived: json["OTHER2_TAX_RECEIVED"],
//         other3TaxReceived: json["OTHER3_TAX_RECEIVED"],
//     );

// }
import 'dart:convert';

import 'package:get/get.dart';

// To parse this JSON data, do
//
//     final contractReceiptModel = contractReceiptModelFromJson(jsonString);

ContractReceiptModel contractReceiptModelFromJson(String str) => ContractReceiptModel.fromJson(json.decode(str));

class ContractReceiptModel {
  // Making the fields observable using Rx
  RxString? contractNo;
  RxString? doctype;
  RxString? partycode;
  RxString? partyname;
  RxString? buildingCode;
  RxString? buildingDescp;
  RxString? apartmentCode;
  RxString? connectionDate;
  RxString? insAmt;
  RxString? depAmt;
  RxString? connectionAmt;
  RxString? maintenanceAmt;
  RxString? disconnectionAmt;
  RxString? registrationAmt;
  RxString? other1Amt;
  RxString? other2Amt;
  RxString? other3Amt;
  RxString? insuranceVatperc;
  RxString? depositVatperc;
  RxString? connectionVatperc;
  RxString? maintenanceVatperc;
  RxString? disconnectionVatperc;
  RxString? registrationVatperc;
  RxString? otheramtVatperc;
  RxString? otheramt2Vatperc;
  RxString? otheramt3Vatperc;
  RxString? insAmtReceived;
  RxString? depAmtReceived;
  RxString? connectionAmtReceived;
  RxString? maintenanceAmtReceived;
  RxString? disconnectionAmtReceived;
  RxString? registrationAmtReceived;
  RxString? other1AmtReceived;
  RxString? other2AmtReceived;
  RxString? other3AmtReceived;
  RxString? insTaxReceived;
  RxString? depTaxReceived;
  RxString? connectionTaxReceived;
  RxString? maintenanceTaxReceived;
  RxString? disconnectionTaxReceived;
  RxString? registrationTaxReceived;
  RxString? other1TaxReceived;
  RxString? other2TaxReceived;
  RxString? other3TaxReceived;
  RxString? descp;

  ContractReceiptModel({
    String? contractNo,
    String? doctype,
    String? partycode,
    String? partyname,
    String? buildingCode,
    String? buildingDescp,
    String? apartmentCode,
    String? connectionDate,
    String? insAmt,
    String? depAmt,
    String? connectionAmt,
    String? maintenanceAmt,
    String? disconnectionAmt,
    String? registrationAmt,
    String? other1Amt,
    String? other2Amt,
    String? other3Amt,
    String? insuranceVatperc,
    String? depositVatperc,
    String? connectionVatperc,
    String? maintenanceVatperc,
    String? disconnectionVatperc,
    String? registrationVatperc,
    String? otheramtVatperc,
    String? otheramt2Vatperc,
    String? otheramt3Vatperc,
    String? insAmtReceived,
    String? depAmtReceived,
    String? connectionAmtReceived,
    String? maintenanceAmtReceived,
    String? disconnectionAmtReceived,
    String? registrationAmtReceived,
    String? other1AmtReceived,
    String? other2AmtReceived,
    String? other3AmtReceived,
    String? insTaxReceived,
    String? depTaxReceived,
    String? connectionTaxReceived,
    String? maintenanceTaxReceived,
    String? disconnectionTaxReceived,
    String? registrationTaxReceived,
    String? other1TaxReceived,
    String? other2TaxReceived,
    String? other3TaxReceived,
    String? descp,
  })  : contractNo = (contractNo ?? '').obs,
        doctype = (doctype ?? '').obs,
        partycode = (partycode ?? '').obs,
        partyname = (partyname ?? '').obs,
        buildingCode = (buildingCode ?? '').obs,
        buildingDescp = (buildingDescp ?? '').obs,
        apartmentCode = (apartmentCode ?? '').obs,
        connectionDate = (connectionDate ?? '').obs,
        insAmt = (insAmt ?? '').obs,
        depAmt = (depAmt ?? '').obs,
        connectionAmt = (connectionAmt ?? '').obs,
        maintenanceAmt = (maintenanceAmt ?? '').obs,
        disconnectionAmt = (disconnectionAmt ?? '').obs,
        registrationAmt = (registrationAmt ?? '').obs,
        other1Amt = (other1Amt ?? '').obs,
        other2Amt = (other2Amt ?? '').obs,
        other3Amt = (other3Amt ?? '').obs,
        insuranceVatperc = (insuranceVatperc ?? '').obs,
        depositVatperc = (depositVatperc ?? '').obs,
        connectionVatperc = (connectionVatperc ?? '').obs,
        maintenanceVatperc = (maintenanceVatperc ?? '').obs,
        disconnectionVatperc = (disconnectionVatperc ?? '').obs,
        registrationVatperc = (registrationVatperc ?? '').obs,
        otheramtVatperc = (otheramtVatperc ?? '').obs,
        otheramt2Vatperc = (otheramt2Vatperc ?? '').obs,
        otheramt3Vatperc = (otheramt3Vatperc ?? '').obs,
        insAmtReceived = (insAmtReceived ?? '').obs,
        depAmtReceived = (depAmtReceived ?? '').obs,
        connectionAmtReceived = (connectionAmtReceived ?? '').obs,
        maintenanceAmtReceived = (maintenanceAmtReceived ?? '').obs,
        disconnectionAmtReceived = (disconnectionAmtReceived ?? '').obs,
        registrationAmtReceived = (registrationAmtReceived ?? '').obs,
        other1AmtReceived = (other1AmtReceived ?? '').obs,
        other2AmtReceived = (other2AmtReceived ?? '').obs,
        other3AmtReceived = (other3AmtReceived ?? '').obs,
        insTaxReceived = (insTaxReceived ?? '').obs,
        depTaxReceived = (depTaxReceived ?? '').obs,
        connectionTaxReceived = (connectionTaxReceived ?? '').obs,
        maintenanceTaxReceived = (maintenanceTaxReceived ?? '').obs,
        disconnectionTaxReceived = (disconnectionTaxReceived ?? '').obs,
        registrationTaxReceived = (registrationTaxReceived ?? '').obs,
        other1TaxReceived = (other1TaxReceived ?? '').obs,
        other2TaxReceived = (other2TaxReceived ?? '').obs,
        other3TaxReceived = (other3TaxReceived ?? '').obs,
        descp = (descp ?? '').obs;

  factory ContractReceiptModel.fromJson(Map<String, dynamic> json) => ContractReceiptModel(
        contractNo: json["CONTRACT_NO"],
        doctype: json["DOCTYPE"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        buildingCode: json["BUILDING_CODE"],
        buildingDescp: json["BUILDING_DESCP"],
        apartmentCode: json["APARTMENT_CODE"],
        connectionDate: json["CONNECTION_DATE"],
        insAmt: json["INS_AMT"],
        depAmt: json["DEP_AMT"],
        connectionAmt: json["CONNECTION_AMT"],
        maintenanceAmt: json["MAINTENANCE_AMT"],
        disconnectionAmt: json["DISCONNECTION_AMT"],
        registrationAmt: json["REGISTRATION_AMT"],
        other1Amt: json["OTHER1_AMT"],
        other2Amt: json["OTHER2_AMT"],
        other3Amt: json["OTHER3_AMT"],
        insuranceVatperc: json["INSURANCE_VATPERC"],
        depositVatperc: json["DEPOSIT_VATPERC"],
        connectionVatperc: json["CONNECTION_VATPERC"],
        maintenanceVatperc: json["MAINTENANCE_VATPERC"],
        disconnectionVatperc: json["DISCONNECTION_VATPERC"],
        registrationVatperc: json["REGISTRATION_VATPERC"],
        otheramtVatperc: json["OTHERAMT_VATPERC"],
        otheramt2Vatperc: json["OTHERAMT2_VATPERC"],
        otheramt3Vatperc: json["OTHERAMT3_VATPERC"],
        insAmtReceived: json["INS_AMT_RECEIVED"],
        depAmtReceived: json["DEP_AMT_RECEIVED"],
        connectionAmtReceived: json["CONNECTION_AMT_RECEIVED"],
        maintenanceAmtReceived: json["MAINTENANCE_AMT_RECEIVED"],
        disconnectionAmtReceived: json["DISCONNECTION_AMT_RECEIVED"],
        registrationAmtReceived: json["REGISTRATION_AMT_RECEIVED"],
        other1AmtReceived: json["OTHER1_AMT_RECEIVED"],
        other2AmtReceived: json["OTHER2_AMT_RECEIVED"],
        other3AmtReceived: json["OTHER3_AMT_RECEIVED"],
        insTaxReceived: json["INS_TAX_RECEIVED"],
        depTaxReceived: json["DEP_TAX_RECEIVED"],
        connectionTaxReceived: json["CONNECTION_TAX_RECEIVED"],
        maintenanceTaxReceived: json["MAINTENANCE_TAX_RECEIVED"],
        disconnectionTaxReceived: json["DISCONNECTION_TAX_RECEIVED"],
        registrationTaxReceived: json["REGISTRATION_TAX_RECEIVED"],
        other1TaxReceived: json["OTHER1_TAX_RECEIVED"],
        other2TaxReceived: json["OTHER2_TAX_RECEIVED"],
        other3TaxReceived: json["OTHER3_TAX_RECEIVED"],
        descp: json["DESCP"],
      );
}
