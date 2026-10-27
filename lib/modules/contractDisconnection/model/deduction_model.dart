import 'dart:convert';

DeductionChargeModel deductionChargeModelFromJson(String str) =>
    DeductionChargeModel.fromJson(json.decode(str));

class DeductionChargeModel {
  final String? company;
  final String? code;
  final String? descp;
  final String? amt;
  final String? vat;

  DeductionChargeModel({
    this.company,
    this.code,
    this.descp,
    this.amt,
    this.vat,
  });

  factory DeductionChargeModel.fromJson(Map<String, dynamic> json) =>
      DeductionChargeModel(
        company: json["COMPANY"],
        code: json["CODE"],
        descp: json["DESCP"],
        amt: json["AMT"],
        vat: json["VAT"],
      );
}
