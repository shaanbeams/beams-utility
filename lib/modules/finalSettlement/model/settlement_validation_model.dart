 

import 'dart:convert';

List<SettlementValidationModel> settlementValidationModelFromJson(String str) =>
    List<SettlementValidationModel>.from(
        json.decode(str).map((x) => SettlementValidationModel.fromJson(x)));

class SettlementValidationModel {
  final List<SettleHeader>? headerTable;
  final List<SettleValidationDetail>? settleValidationDetail;

  SettlementValidationModel({
    this.headerTable,
    this.settleValidationDetail,
  });

  factory SettlementValidationModel.fromJson(Map<String, dynamic> json) =>
      SettlementValidationModel(
        headerTable: json["Table1"] == null
            ? []
            : List<SettleHeader>.from(
                json["Table1"]!.map((x) => SettleHeader.fromJson(x))),
        settleValidationDetail: json["Table2"] == null
            ? []
            : List<SettleValidationDetail>.from(
                json["Table2"]!.map((x) => SettleValidationDetail.fromJson(x))),
      );
}

class SettleHeader {
  final String? status;
  final String? msg;

  SettleHeader({
    this.status,
    this.msg,
  });

  factory SettleHeader.fromJson(Map<String, dynamic> json) => SettleHeader(
        status: json["STATUS"],
        msg: json["MSG"],
      );
}

class SettleValidationDetail {
  final String? company;
  final String? partycode;
  final String? partyname;
  final String? contractNo;
  final String? buildingCode;
  final String? buildingDescp;
  final String? apartmentCode;
  final String? insuranceAmtReceived;
  final String? depositAmtReceived;
  final String? invoiceAmt;
  final String? invoiceAmtTax;
  final String? receivedAmt;
  final String? maintenanceAmt;
  final String? maintenanceAmtTax;
  final String? totalDeductionTaxamt;
  final String? deductionAmt;
  final String? securityDepReturnAmt;
  final String? securityDepReturnTaxAmt;
  final String? refundTxnClearanceAmt;
  final String? refundTxnClearanceTaxAmt;
  final String? refundTxnDisconnectionAmt;
  final String? refundTxnDisconnectionTaxAmt;
  final String? amtPaid;
  final String? netReceivable;
  final String? netPayable;
  final String? deduction;
  final String? netBalance;

  SettleValidationDetail({
    this.company,
    this.partycode,
    this.partyname,
    this.contractNo,
    this.buildingCode,
    this.buildingDescp,
    this.apartmentCode,
    this.insuranceAmtReceived,
    this.depositAmtReceived,
    this.invoiceAmt,
    this.invoiceAmtTax,
    this.receivedAmt,
    this.maintenanceAmt,
    this.maintenanceAmtTax,
    this.totalDeductionTaxamt,
    this.deductionAmt,
    this.securityDepReturnAmt,
    this.securityDepReturnTaxAmt,
    this.refundTxnClearanceAmt,
    this.refundTxnClearanceTaxAmt,
    this.refundTxnDisconnectionAmt,
    this.refundTxnDisconnectionTaxAmt,
    this.amtPaid,
    this.netReceivable,
    this.netPayable,
    this.deduction,
    this.netBalance,
  });

  factory SettleValidationDetail.fromJson(Map<String, dynamic> json) =>
      SettleValidationDetail(
        company: json["COMPANY"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        contractNo: json["CONTRACT_NO"],
        buildingCode: json["BUILDING_CODE"],
        buildingDescp: json["BUILDING_DESCP"],
        apartmentCode: json["APARTMENT_CODE"],
        insuranceAmtReceived: json["INSURANCE_AMT_RECEIVED"],
        depositAmtReceived: json["DEPOSIT_AMT_RECEIVED"],
        invoiceAmt: json["INVOICE_AMT"],
        invoiceAmtTax: json["INVOICE_AMT_TAX"],
        receivedAmt: json["RECEIVED_AMT"],
        maintenanceAmt: json["MAINTENANCE_AMT"],
        maintenanceAmtTax: json["MAINTENANCE_AMT_TAX"],
        totalDeductionTaxamt: json["TOTAL_DEDUCTION_TAXAMT"],
        deductionAmt: json["DEDUCTION_AMT"],
        securityDepReturnAmt: json["SECURITY_DEP_RETURN_AMT"],
        securityDepReturnTaxAmt: json["SECURITY_DEP_RETURN_TAX_AMT"],
        refundTxnClearanceAmt: json["REFUND_TXN_CLEARANCE_AMT"],
        refundTxnClearanceTaxAmt: json["REFUND_TXN_CLEARANCE_TAX_AMT"],
        refundTxnDisconnectionAmt: json["REFUND_TXN_DISCONNECTION_AMT"],
        refundTxnDisconnectionTaxAmt: json["REFUND_TXN_DISCONNECTION_TAX_AMT"],
        amtPaid: json["AMT_PAID"],
        netReceivable: json["NET_RECEIVABLE"],
        netPayable: json["NET_PAYABLE"],
        deduction: json["DEDUCTION"],
        netBalance: json["NET_BALANCE"],
      );
}
