// To parse this JSON data, do
//
//     final readingInvoiceValidateModel = readingInvoiceValidateModelFromJson(jsonString);

import 'dart:convert';

ReadingInvoiceValidateModel readingInvoiceValidateModelFromJson(String str) => ReadingInvoiceValidateModel.fromJson(json.decode(str));


class ReadingInvoiceValidateModel {
    final String? buildingCode;
    final String? descp;
    final String? apartmentCode;
    final String? lastReading;
    final String? lastReadingDate;
    final String? currReading;
    final String? currReadingDate;
    final String? totalUnit;
    final String? unitPrice;
    final String? otherAmt;
    final String? maintenanceAmt;
    final String? totalReadcharge;
    final String? monthlyFee;
    final String? billMeterReadingAmt;
    final String? administrationAmt;
    final String? facilityManageAmt;
    final String? boilerGasConsumptionAmt;
    final String? delayPaymentAmt;
    final String? securityDepReturnAmt;
    final String? fuelSurchargeAmt;
    final String? billMeterReadingTaxPerc;
    final String? administrationTaxPerc;
    final String? facilityManageTaxPerc;
    final String? boilerGasConsumptionTaxPerc;
    final String? delayPaymentTaxPerc;
    final String? securityDepReturnTaxPerc;
    final String? prvBalance;
    final String? totalAmt;
    final String? lastInvdocno;
    final String? lastInvdoctype;
    final String? lastYearcode;
    final String? lastInvdate;
    final String? partycode;
    final String? partyname;
    final String? srno;
    final String? gasMeterNo;
    final String? readingVat;
    final String? otheramtVat;
    final String? monthlyVat;
    final String? maintenanceVat;
    final String? depositVat;
    final String? fuelSurchargeVat;
    final String? lastRecDocno;
    final String? lastRecDoctype;
    final String? lastRecDate;
    final String? lastRecYearcode;
    final String? lastRecAmt;
    final String? final_reading_yn; 

    ReadingInvoiceValidateModel({
        this.buildingCode,
        this.descp,
        this.apartmentCode,
        this.lastReading,
        this.lastReadingDate,
        this.currReading,
        this.currReadingDate,
        this.totalUnit,
        this.unitPrice,
        this.otherAmt,
        this.maintenanceAmt,
        this.totalReadcharge,
        this.monthlyFee,
        this.billMeterReadingAmt,
        this.administrationAmt,
        this.facilityManageAmt,
        this.boilerGasConsumptionAmt,
        this.delayPaymentAmt,
        this.securityDepReturnAmt,
        this.fuelSurchargeAmt,
        this.billMeterReadingTaxPerc,
        this.administrationTaxPerc,
        this.facilityManageTaxPerc,
        this.boilerGasConsumptionTaxPerc,
        this.delayPaymentTaxPerc,
        this.securityDepReturnTaxPerc,
        this.prvBalance,
        this.totalAmt,
        this.lastInvdocno,
        this.lastInvdoctype,
        this.lastYearcode,
        this.lastInvdate,
        this.partycode,
        this.partyname,
        this.srno,
        this.gasMeterNo,
        this.readingVat,
        this.otheramtVat,
        this.monthlyVat,
        this.maintenanceVat,
        this.depositVat,
        this.fuelSurchargeVat,
        this.lastRecDocno,
        this.lastRecDoctype,
        this.lastRecDate,
        this.lastRecYearcode,
        this.lastRecAmt,
        this.final_reading_yn
    });

    factory ReadingInvoiceValidateModel.fromJson(Map<String, dynamic> json) => ReadingInvoiceValidateModel(
        buildingCode: json["BUILDING_CODE"],
        descp: json["DESCP"],
        apartmentCode: json["APARTMENT_CODE"],
        lastReading: json["LAST_READING"],
        lastReadingDate: json["LAST_READING_DATE"],
        currReading: json["CURR_READING"],
        currReadingDate: json["CURR_READING_DATE"],
        totalUnit: json["TOTAL_UNIT"],
        unitPrice: json["UNIT_PRICE"],
        otherAmt: json["OTHER_AMT"],
        maintenanceAmt: json["MAINTENANCE_AMT"],
        totalReadcharge: json["TOTAL_READCHARGE"],
        monthlyFee: json["MONTHLY_FEE"],
        billMeterReadingAmt: json["BILL_METER_READING_AMT"],
        administrationAmt: json["ADMINISTRATION_AMT"],
        facilityManageAmt: json["FACILITY_MANAGE_AMT"],
        boilerGasConsumptionAmt: json["BOILER_GAS_CONSUMPTION_AMT"],
        delayPaymentAmt: json["DELAY_PAYMENT_AMT"],
        securityDepReturnAmt: json["SECURITY_DEP_RETURN_AMT"],
        fuelSurchargeAmt: json["FUEL_SURCHARGE_AMT"],
        billMeterReadingTaxPerc: json["BILL_METER_READING_TAX_PERC"],
        administrationTaxPerc: json["ADMINISTRATION_TAX_PERC"],
        facilityManageTaxPerc: json["FACILITY_MANAGE_TAX_PERC"],
        boilerGasConsumptionTaxPerc: json["BOILER_GAS_CONSUMPTION_TAX_PERC"],
        delayPaymentTaxPerc: json["DELAY_PAYMENT_TAX_PERC"],
        securityDepReturnTaxPerc: json["SECURITY_DEP_RETURN_TAX_PERC"],
        prvBalance: json["PRV_BALANCE"],
        totalAmt: json["TOTAL_AMT"],
        lastInvdocno: json["LAST_INVDOCNO"],
        lastInvdoctype: json["LAST_INVDOCTYPE"],
        lastYearcode: json["LAST_YEARCODE"],
        lastInvdate: json["LAST_INVDATE"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        srno: json["SRNO"],
        gasMeterNo: json["GAS_METER_NO"],
        readingVat: json["READING_VAT"],
        otheramtVat: json["OTHERAMT_VAT"],
        monthlyVat: json["MONTHLY_VAT"],
        maintenanceVat: json["MAINTENANCE_VAT"],
        depositVat: json["DEPOSIT_VAT"],
        fuelSurchargeVat: json["FUEL_SURCHARGE_VAT"],
        lastRecDocno: json["LAST_REC_DOCNO"],
        lastRecDoctype: json["LAST_REC_DOCTYPE"],
        lastRecDate: json["LAST_REC_DATE"],
        lastRecYearcode: json["LAST_REC_YEARCODE"],
        lastRecAmt: json["LAST_REC_AMT"],
        final_reading_yn: json["FINAL_READING_YN"],
    );

    
}
