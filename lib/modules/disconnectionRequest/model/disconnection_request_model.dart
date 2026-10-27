// To parse this JSON data, do
//
//     final diconnectionRequestModel = diconnectionRequestModelFromJson(jsonString);

import 'dart:convert';

DiconnectionRequestModel diconnectionRequestModelFromJson(String str) => DiconnectionRequestModel.fromJson(json.decode(str));

String diconnectionRequestModelToJson(DiconnectionRequestModel data) => json.encode(data.toJson());

class DiconnectionRequestModel {
    final String? company;
    final String? docno;
    final String? doctype;
    final String? yearcode;
    final String? docdate;
    final String? contractNo;
    final String? buildingCode;
    final String? apartmentCode;
    final String? partycode;
    final String? partyname;
    final String? expDisconnectionDate;
    final String? ibanNo;
    final String? bankAcno;

    DiconnectionRequestModel({
        this.company,
        this.docno,
        this.doctype,
        this.yearcode,
        this.docdate,
        this.contractNo,
        this.buildingCode,
        this.apartmentCode,
        this.partycode,
        this.partyname,
        this.expDisconnectionDate,
        this.ibanNo,
        this.bankAcno,
    });

    factory DiconnectionRequestModel.fromJson(Map<String, dynamic> json) => DiconnectionRequestModel(
        company: json["COMPANY"],
        docno: json["DOCNO"],
        doctype: json["DOCTYPE"],
        yearcode: json["YEARCODE"],
        docdate: json["DOCDATE"],
        contractNo: json["CONTRACT_NO"],
        buildingCode: json["BUILDING_CODE"],
        apartmentCode: json["APARTMENT_CODE"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        expDisconnectionDate: json["EXP_DISCONNECTION_DATE"],
        ibanNo: json["IBAN_NO"],
        bankAcno: json["BANK_ACNO"],
    );

    Map<String, dynamic> toJson() => {
        "COMPANY": company,
        "DOCNO": docno,
        "DOCTYPE": doctype,
        "YEARCODE": yearcode,
        "DOCDATE": docdate,
        "CONTRACT_NO": contractNo,
        "BUILDING_CODE": buildingCode,
        "APARTMENT_CODE": apartmentCode,
        "PARTYCODE": partycode,
        "PARTYNAME": partyname,
        "EXP_DISCONNECTION_DATE": expDisconnectionDate,
        "IBAN_NO": ibanNo,
        "BANK_ACNO": bankAcno,
    };
}
