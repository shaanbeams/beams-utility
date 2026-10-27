 

import 'dart:convert';

List<ContractDisViewModel>
    contratDisconnectionValidationModelFromJson(String str) =>
        List<ContractDisViewModel>.from(json
            .decode(str)
            .map((x) => ContractDisViewModel.fromJson(x)));

class ContractDisViewModel {
  final List<Map<String, String>>? headerTable;
  final List<ChargesTable>? chargesTable;

  ContractDisViewModel({
    this.headerTable,
    this.chargesTable,
  });

  factory ContractDisViewModel.fromJson(
          Map<String, dynamic> json) =>
      ContractDisViewModel(
        headerTable: json["Table1"] == null
            ? []
            : List<Map<String, String>>.from(json["Table1"]!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
        chargesTable: json["Table2"] == null
            ? []
            : List<ChargesTable>.from(
                json["Table2"]!.map((x) => ChargesTable.fromJson(x))),
      );
}

class ChargesTable {
  final String? company;
  final String? yearcode;
  final String? docno;
  final String? doctype;
  final String? srno;
  final String? docdate;
  final String? partycode;
  final String? partyname;
  final String? buildingCode;
  final String? contractNo;
  final String? apartmentCode;
  final String? chargeType;
  final String? chargeTypeDescp;
  final String? deductionAmt;
  final String? totalDeductionAmt;
  final String? remarks;
  final String? brncode;
  final String? divcode;
  final String? cccode;
  final String? vatPerc;
  final String? vatAmt;
  final String? cashflowCat;

  ChargesTable({
    this.company,
    this.yearcode,
    this.docno,
    this.doctype,
    this.srno,
    this.docdate,
    this.partycode,
    this.partyname,
    this.buildingCode,
    this.contractNo,
    this.apartmentCode,
    this.chargeType,
    this.chargeTypeDescp,
    this.deductionAmt,
    this.totalDeductionAmt,
    this.remarks,
    this.brncode,
    this.divcode,
    this.cccode,
    this.vatPerc,
    this.vatAmt,
    this.cashflowCat,
  });

  factory ChargesTable.fromJson(Map<String, dynamic> json) => ChargesTable(
        company: json["COMPANY"],
        yearcode: json["YEARCODE"],
        docno: json["DOCNO"],
        doctype: json["DOCTYPE"],
        srno: json["SRNO"],
        docdate: json["DOCDATE"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        buildingCode: json["BUILDING_CODE"],
        contractNo: json["CONTRACT_NO"],
        apartmentCode: json["APARTMENT_CODE"],
        chargeType: json["CHARGE_TYPE"],
        chargeTypeDescp: json["CHARGE_TYPE_DESCP"],
        deductionAmt: json["DEDUCTION_AMT"],
        totalDeductionAmt: json["TOTAL_DEDUCTION_AMT"],
        remarks: json["REMARKS"],
        brncode: json["BRNCODE"],
        divcode: json["DIVCODE"],
        cccode: json["CCCODE"],
        vatPerc: json["VAT_PERC"],
        vatAmt: json["VAT_AMT"],
        cashflowCat: json["CASHFLOW_CAT"],
      );
}

