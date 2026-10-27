import 'dart:convert';

ReadingInvoiceReceiptValidationModel ReadingInvoiceReceiptValidationModelFromJson(String str) => ReadingInvoiceReceiptValidationModel.fromJson(json.decode(str));

class ReadingInvoiceReceiptValidationModel {
  final String? docno;
  final String? docdate;
  final String? buildingCode;
  final String? buildingName;
  final String? apartmentCode;
  final String? partycode;
  final String? partyname;
  final String? netAmount;
  final String? paidAmt;
  final String? receivedamt;
  final String? balanceamt;
  final String? readingDocno;
  final String? contractNo;
  final String? doctype;
  final String? yearcode;
  final String? srno;
  final String? discRecAmt;
  final String? invoiceDeposit;
  final String? prvRecvedDeposit;
  final String? receivedDepositamt;
  final String? billcollector;
  ReadingInvoiceReceiptValidationModel({
    this.docno,
    this.docdate,
    this.buildingCode,
    this.buildingName,
    this.apartmentCode,
    this.partycode,
    this.partyname,
    this.netAmount,
    this.paidAmt,
    this.receivedamt,
    this.balanceamt,
    this.readingDocno,
    this.contractNo,
    this.doctype,
    this.yearcode,
    this.srno,
    this.discRecAmt,
    this.invoiceDeposit,
    this.prvRecvedDeposit,
    this.receivedDepositamt,
    this.billcollector,
  });
  factory ReadingInvoiceReceiptValidationModel.fromJson(Map<String, dynamic> json) => ReadingInvoiceReceiptValidationModel(
        docno: json["DOCNO"],
        docdate: json["DOCDATE"],
        buildingCode: json["BUILDING_CODE"],
        buildingName: json["BUILDING_NAME"],
        apartmentCode: json["APARTMENT_CODE"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        netAmount: json["NET_AMOUNT"],
        paidAmt: json["PAID_AMT"],
        receivedamt: json["RECEIVEDAMT"],
        balanceamt: json["BALANCEAMT"],
        readingDocno: json["READING_DOCNO"],
        contractNo: json["CONTRACT_NO"],
        doctype: json["DOCTYPE"],
        yearcode: json["YEARCODE"],
        srno: json["SRNO"],
        discRecAmt: json["DISC_REC_AMT"],
        invoiceDeposit: json["INVOICE_DEPOSIT"],
        prvRecvedDeposit: json["PRV_RECVED_DEPOSIT"],
        receivedDepositamt: json["RECEIVED_DEPOSITAMT"],
        billcollector: json["BILLCOLLECTOR"],
      );
}
