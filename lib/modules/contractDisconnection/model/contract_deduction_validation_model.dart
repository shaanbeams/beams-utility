// To parse this JSON data, do
//
//     final contratDisconnectionValidationModel = contratDisconnectionValidationModelFromJson(jsonString);

import 'dart:convert';

List<ContratDisconnectionValidationModel> contratDisconnectionValidationModelFromJson(String str) => List<ContratDisconnectionValidationModel>.from(json.decode(str).map((x) => ContratDisconnectionValidationModel.fromJson(x)));


class ContratDisconnectionValidationModel {
    final List<ContratDisTable1>? table1;
    final List<ContratDisTable2>? table2;

    ContratDisconnectionValidationModel({
        this.table1,
        this.table2,
    });

    factory ContratDisconnectionValidationModel.fromJson(Map<String, dynamic> json) => ContratDisconnectionValidationModel(
        table1: json["Table1"] == null ? [] : List<ContratDisTable1>.from(json["Table1"]!.map((x) => ContratDisTable1.fromJson(x))),
        table2: json["Table2"] == null ? [] : List<ContratDisTable2>.from(json["Table2"]!.map((x) => ContratDisTable2.fromJson(x))),
    );

  
}

class ContratDisTable1 {
    final String? status;
    final String? msg;

    ContratDisTable1({
        this.status,
        this.msg,
    });

    factory ContratDisTable1.fromJson(Map<String, dynamic> json) => ContratDisTable1(
        status: json["STATUS"],
        msg: json["MSG"],
    );

   
}

class ContratDisTable2 {
    final String? company;
    final String? contractNo;
    final String? partycode;
    final String? partyname;
    final String? buildingCode;
    final String? buildingDescp;
    final String? apartmentCode;
    final String? connectionDate;
    final String? lastReadingDate;
    final String? clearanceAmt;
    final String? insuranceVatperc;
    final String? clearanceVatperc;
    final String? securityDepReturnAmt;
    final String? securityDepReturnTaxPerc;
    final String? disconnectionVatperc;
    final String? disconnectionAmt;
    final String? consumptionAmt;
    final String? insAmtReceived;
    final String? depAmtReceived;
    final String? disconnectionAmtReceived;
    final String? balanceDisconnectionAmt;

    ContratDisTable2({
        this.company,
        this.contractNo,
        this.partycode,
        this.partyname,
        this.buildingCode,
        this.buildingDescp,
        this.apartmentCode,
        this.connectionDate,
        this.lastReadingDate,
        this.clearanceAmt,
        this.insuranceVatperc,
        this.clearanceVatperc,
        this.securityDepReturnAmt,
        this.securityDepReturnTaxPerc,
        this.disconnectionVatperc,
        this.disconnectionAmt,
        this.consumptionAmt,
        this.insAmtReceived,
        this.depAmtReceived,
        this.disconnectionAmtReceived,
        this.balanceDisconnectionAmt,
    });

    factory ContratDisTable2.fromJson(Map<String, dynamic> json) => ContratDisTable2(
        company: json["COMPANY"],
        contractNo: json["CONTRACT_NO"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        buildingCode: json["BUILDING_CODE"],
        buildingDescp: json["BUILDING_DESCP"],
        apartmentCode: json["APARTMENT_CODE"],
        connectionDate: json["CONNECTION_DATE"],
        lastReadingDate: json["LAST_READING_DATE"],
        clearanceAmt: json["CLEARANCE_AMT"],
        insuranceVatperc: json["INSURANCE_VATPERC"],
        clearanceVatperc: json["CLEARANCE_VATPERC"],
        securityDepReturnAmt: json["SECURITY_DEP_RETURN_AMT"],
        securityDepReturnTaxPerc: json["SECURITY_DEP_RETURN_TAX_PERC"],
        disconnectionVatperc: json["DISCONNECTION_VATPERC"],
        disconnectionAmt: json["DISCONNECTION_AMT"],
        consumptionAmt: json["CONSUMPTION_AMT"],
        insAmtReceived: json["INS_AMT_RECEIVED"],
        depAmtReceived: json["DEP_AMT_RECEIVED"],
        disconnectionAmtReceived: json["DISCONNECTION_AMT_RECEIVED"],
        balanceDisconnectionAmt: json["BALANCE_DISCONNECTION_AMT"],
    );

    
}
