// To parse this JSON data, do
//
//     final readingViewModel = readingViewModelFromJson(jsonString);

import 'dart:convert';

List<ReadingViewModel> readingViewModelFromJson(String str) => List<ReadingViewModel>.from(json.decode(str).map((x) => ReadingViewModel.fromJson(x)));

// String readingViewModelToJson(List<ReadingViewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadingViewModel {
  final List<Table1>? table1;
  final List<Table2>? table2;

  ReadingViewModel({
    this.table1,
    this.table2,
  });

  factory ReadingViewModel.fromJson(Map<String, dynamic> json) => ReadingViewModel(
        table1: json["Table1"] == null ? [] : List<Table1>.from(json["Table1"]!.map((x) => Table1.fromJson(x))),
        table2: json["Table2"] == null ? [] : List<Table2>.from(json["Table2"]!.map((x) => Table2.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "Table1": table1 == null ? [] : List<dynamic>.from(table1!.map((x) => x.toJson())),
  //       "Table2": table2 == null ? [] : List<dynamic>.from(table2!.map((x) => x.toJson())),
  //     };
}

class Table1 {
  final String? company;
  final String? docno;
  final String? doctype;
  final String? yearcode;
  final String? docdate;
  final String? readingDate;
  final String? readingBy;
  final String? remarks;
  final String? readingTotal;
  final String? unitTotal;
  final String? readingAmountTotal;
  final String? otherAmtTotal;
  final String? monthlyFeeTotal;
  final String? readingChargeTotal;
  final String? finalReadingYn;
  final String? maintenanceAmtTotal;
  final String? createUser;
  final String? createDate;
  final String? editUser;
  final String? editDate;
  final String? brncode;
  final String? divcode;
  final String? cccode;
  final String? readingChargeTaxTotal;
  final String? otherAmtTaxTotal;
  final String? monthlyFeeTaxTotal;
  final String? maintenanceAmtTaxTotal;
  final String? taxAmountTotal;
  final String? netAmount;
  final String? onlineSynchStatus;
  final String? manualMonthlyConsumptionYn;
  final String? manualMonthlyConsumption;
  final String? createMachine;
  final String? editMachine;
  final String? imgEidFront;
  final String? imgEidBack;
  final String? imgMeter;
  final String? signature;

  Table1({
    this.company,
    this.docno,
    this.doctype,
    this.yearcode,
    this.docdate,
    this.readingDate,
    this.readingBy,
    this.remarks,
    this.readingTotal,
    this.unitTotal,
    this.readingAmountTotal,
    this.otherAmtTotal,
    this.monthlyFeeTotal,
    this.readingChargeTotal,
    this.finalReadingYn,
    this.maintenanceAmtTotal,
    this.createUser,
    this.createDate,
    this.editUser,
    this.editDate,
    this.brncode,
    this.divcode,
    this.cccode,
    this.readingChargeTaxTotal,
    this.otherAmtTaxTotal,
    this.monthlyFeeTaxTotal,
    this.maintenanceAmtTaxTotal,
    this.taxAmountTotal,
    this.netAmount,
    this.onlineSynchStatus,
    this.manualMonthlyConsumptionYn,
    this.manualMonthlyConsumption,
    this.createMachine,
    this.editMachine,
    this.imgEidFront,
    this.imgEidBack,
    this.imgMeter,
    this.signature,
  });

  factory Table1.fromJson(Map<String, dynamic> json) => Table1(
        company: json["COMPANY"],
        docno: json["DOCNO"],
        doctype: json["DOCTYPE"],
        yearcode: json["YEARCODE"],
        docdate: json["DOCDATE"],
        readingDate: json["READING_DATE"],
        readingBy: json["READING_BY"],
        remarks: json["REMARKS"],
        readingTotal: json["READING_TOTAL"],
        unitTotal: json["UNIT_TOTAL"],
        readingAmountTotal: json["READING_AMOUNT_TOTAL"],
        otherAmtTotal: json["OTHER_AMT_TOTAL"],
        monthlyFeeTotal: json["MONTHLY_FEE_TOTAL"],
        readingChargeTotal: json["READING_CHARGE_TOTAL"],
        finalReadingYn: json["FINAL_READING_YN"],
        maintenanceAmtTotal: json["MAINTENANCE_AMT_TOTAL"],
        createUser: json["CREATE_USER"],
        createDate: json["CREATE_DATE"],
        editUser: json["EDIT_USER"],
        editDate: json["EDIT_DATE"],
        brncode: json["BRNCODE"],
        divcode: json["DIVCODE"],
        cccode: json["CCCODE"],
        readingChargeTaxTotal: json["READING_CHARGE_TAX_TOTAL"],
        otherAmtTaxTotal: json["OTHER_AMT_TAX_TOTAL"],
        monthlyFeeTaxTotal: json["MONTHLY_FEE_TAX_TOTAL"],
        maintenanceAmtTaxTotal: json["MAINTENANCE_AMT_TAX_TOTAL"],
        taxAmountTotal: json["TAX_AMOUNT_TOTAL"],
        netAmount: json["NET_AMOUNT"],
        onlineSynchStatus: json["ONLINE_SYNCH_STATUS"],
        manualMonthlyConsumptionYn: json["MANUAL_MONTHLY_CONSUMPTION_YN"],
        manualMonthlyConsumption: json["MANUAL_MONTHLY_CONSUMPTION"],
        createMachine: json["CREATE_MACHINE"],
        editMachine: json["EDIT_MACHINE"],
        imgEidFront: json["IMG_EID_FRONT"],
        imgEidBack: json["IMG_EID_BACK"],
        imgMeter: json["IMG_METER"],
        signature: json["SIGNATURE"],
      );

  Map<String, dynamic> toJson() => {
        "COMPANY": company,
        "DOCNO": docno,
        "DOCTYPE": doctype,
        "YEARCODE": yearcode,
        "DOCDATE": docdate,
        "READING_DATE": readingDate,
        "READING_BY": readingBy,
        "REMARKS": remarks,
        "READING_TOTAL": readingTotal,
        "UNIT_TOTAL": unitTotal,
        "READING_AMOUNT_TOTAL": readingAmountTotal,
        "OTHER_AMT_TOTAL": otherAmtTotal,
        "MONTHLY_FEE_TOTAL": monthlyFeeTotal,
        "READING_CHARGE_TOTAL": readingChargeTotal,
        "FINAL_READING_YN": finalReadingYn,
        "MAINTENANCE_AMT_TOTAL": maintenanceAmtTotal,
        "CREATE_USER": createUser,
        "CREATE_DATE": createDate,
        "EDIT_USER": editUser,
        "EDIT_DATE": editDate,
        "BRNCODE": brncode,
        "DIVCODE": divcode,
        "CCCODE": cccode,
        "READING_CHARGE_TAX_TOTAL": readingChargeTaxTotal,
        "OTHER_AMT_TAX_TOTAL": otherAmtTaxTotal,
        "MONTHLY_FEE_TAX_TOTAL": monthlyFeeTaxTotal,
        "MAINTENANCE_AMT_TAX_TOTAL": maintenanceAmtTaxTotal,
        "TAX_AMOUNT_TOTAL": taxAmountTotal,
        "NET_AMOUNT": netAmount,
        "ONLINE_SYNCH_STATUS": onlineSynchStatus,
        "MANUAL_MONTHLY_CONSUMPTION_YN": manualMonthlyConsumptionYn,
        "MANUAL_MONTHLY_CONSUMPTION": manualMonthlyConsumption,
        "CREATE_MACHINE": createMachine,
        "EDIT_MACHINE": editMachine,
        "IMG_EID_FRONT": imgEidFront,
        "IMG_EID_BACK": imgEidBack,
        "IMG_METER": imgMeter,
        "SIGNATURE": signature,
      };
}

class Table2 {
  final String? company;
  final String? docno;
  final String? doctype;
  final String? yearcode;
  final String? srno;
  final String? buildingCode;
  final String? descp;
  final String? apartmentCode;
  final String? lastReading;
  final String? lastReadingDate;
  final String? currReading;
  final String? currReadingDate;
  final String? estimateYn;
  final String? totalUnit;
  final String? unitPrice;
  final String? amount;
  final String? otherAmt;
  final String? monthlyFee;
  final String? totalReadcharge;
  final String? contractNo;
  final String? partycode;
  final String? partyname;
  final String? gasMeterNo;
  final String? readingConversion;
  final String? maintenanceAmt;
  final String? brncode;
  final String? divcode;
  final String? cccode;
  final String? taxpercReadcharge;
  final String? taxamtReadcharge;
  final String? readingtaxAccode;
  final String? taxpercOtherAmt;
  final String? taxamtOtherAmt;
  final String? othertaxAccode;
  final String? taxpercMonthlyFee;
  final String? taxamtMonthlyFee;
  final String? monthlytaxAccode;
  final String? taxpercMaintenanceAmt;
  final String? taxamtMaintenanceAmt;
  final String? maintenancetaxAccode;
  final String? taxAmount;
  final String? netAmount;
  final String? currReadingTime;
  final String? appSynchStatus;
  final String? onlineSynchStatus;
  final String? billMeterReadingAmt;
  final String? billMeterReadingTaxPerc;
  final String? billMeterReadingTaxAmt;
  final String? administrationAmt;
  final String? administrationTaxPerc;
  final String? administrationTaxAmt;
  final String? facilityManageAmt;
  final String? facilityManageTaxPerc;
  final String? facilityManageTaxAmt;
  final String? boilerGasConsumptionAmt;
  final String? boilerGasConsumptionTaxPerc;
  final String? boilerGasConsumptionTaxAmt;
  final String? delayPaymentAmt;
  final String? delayPaymentTaxPerc;
  final String? delayPaymentTaxAmt;
  final String? securityDepReturnAmt;
  final String? securityDepReturnTaxPerc;
  final String? securityDepReturnTaxAmt;
  final String? meterPressure;
  final String? fuelSurcharge;
  final String? fuelSurchargeAmt;
  final String? fuelSurchargeTaxPerc;
  final String? fuelSurchargeTaxAmt;
  final String? name;
  final int? founded;
  final List<String>? members;

  Table2({
    this.company,
    this.docno,
    this.doctype,
    this.yearcode,
    this.srno,
    this.buildingCode,
    this.descp,
    this.apartmentCode,
    this.lastReading,
    this.lastReadingDate,
    this.currReading,
    this.currReadingDate,
    this.estimateYn,
    this.totalUnit,
    this.unitPrice,
    this.amount,
    this.otherAmt,
    this.monthlyFee,
    this.totalReadcharge,
    this.contractNo,
    this.partycode,
    this.partyname,
    this.gasMeterNo,
    this.readingConversion,
    this.maintenanceAmt,
    this.brncode,
    this.divcode,
    this.cccode,
    this.taxpercReadcharge,
    this.taxamtReadcharge,
    this.readingtaxAccode,
    this.taxpercOtherAmt,
    this.taxamtOtherAmt,
    this.othertaxAccode,
    this.taxpercMonthlyFee,
    this.taxamtMonthlyFee,
    this.monthlytaxAccode,
    this.taxpercMaintenanceAmt,
    this.taxamtMaintenanceAmt,
    this.maintenancetaxAccode,
    this.taxAmount,
    this.netAmount,
    this.currReadingTime,
    this.appSynchStatus,
    this.onlineSynchStatus,
    this.billMeterReadingAmt,
    this.billMeterReadingTaxPerc,
    this.billMeterReadingTaxAmt,
    this.administrationAmt,
    this.administrationTaxPerc,
    this.administrationTaxAmt,
    this.facilityManageAmt,
    this.facilityManageTaxPerc,
    this.facilityManageTaxAmt,
    this.boilerGasConsumptionAmt,
    this.boilerGasConsumptionTaxPerc,
    this.boilerGasConsumptionTaxAmt,
    this.delayPaymentAmt,
    this.delayPaymentTaxPerc,
    this.delayPaymentTaxAmt,
    this.securityDepReturnAmt,
    this.securityDepReturnTaxPerc,
    this.securityDepReturnTaxAmt,
    this.meterPressure,
    this.fuelSurcharge,
    this.fuelSurchargeAmt,
    this.fuelSurchargeTaxPerc,
    this.fuelSurchargeTaxAmt,
    this.name,
    this.founded,
    this.members,
  });
  factory Table2.fromJson(Map<String, dynamic> json) => Table2(
        company: json["COMPANY"],
        docno: json["DOCNO"],
        doctype: json["DOCTYPE"],
        yearcode: json["YEARCODE"],
        srno: json["SRNO"],
        buildingCode: json["BUILDING_CODE"],
        descp: json["DESCP"],
        apartmentCode: json["APARTMENT_CODE"],
        lastReading: json["LAST_READING"],
        lastReadingDate: json["LAST_READING_DATE"],
        currReading: json["CURR_READING"],
        currReadingDate: json["CURR_READING_DATE"],
        estimateYn: json["ESTIMATE_YN"],
        totalUnit: json["TOTAL_UNIT"],
        unitPrice: json["UNIT_PRICE"],
        amount: json["AMOUNT"],
        otherAmt: json["OTHER_AMT"],
        monthlyFee: json["MONTHLY_FEE"],
        totalReadcharge: json["TOTAL_READCHARGE"],
        contractNo: json["CONTRACT_NO"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        gasMeterNo: json["GAS_METER_NO"],
        readingConversion: json["READING_CONVERSION"],
        maintenanceAmt: json["MAINTENANCE_AMT"],
        brncode: json["BRNCODE"],
        divcode: json["DIVCODE"],
        cccode: json["CCCODE"],
        taxpercReadcharge: json["TAXPERC_READCHARGE"],
        taxamtReadcharge: json["TAXAMT_READCHARGE"],
        readingtaxAccode: json["READINGTAX_ACCODE"],
        taxpercOtherAmt: json["TAXPERC_OTHER_AMT"],
        taxamtOtherAmt: json["TAXAMT_OTHER_AMT"],
        othertaxAccode: json["OTHERTAX_ACCODE"],
        taxpercMonthlyFee: json["TAXPERC_MONTHLY_FEE"],
        taxamtMonthlyFee: json["TAXAMT_MONTHLY_FEE"],
        monthlytaxAccode: json["MONTHLYTAX_ACCODE"],
        taxpercMaintenanceAmt: json["TAXPERC_MAINTENANCE_AMT"],
        taxamtMaintenanceAmt: json["TAXAMT_MAINTENANCE_AMT"],
        maintenancetaxAccode: json["MAINTENANCETAX_ACCODE"],
        taxAmount: json["TAX_AMOUNT"],
        netAmount: json["NET_AMOUNT"],
        currReadingTime: json["CURR_READING_TIME"],
        appSynchStatus: json["APP_SYNCH_STATUS"],
        onlineSynchStatus: json["ONLINE_SYNCH_STATUS"],
        billMeterReadingAmt: json["BILL_METER_READING_AMT"],
        billMeterReadingTaxPerc: json["BILL_METER_READING_TAX_PERC"],
        billMeterReadingTaxAmt: json["BILL_METER_READING_TAX_AMT"],
        administrationAmt: json["ADMINISTRATION_AMT"],
        administrationTaxPerc: json["ADMINISTRATION_TAX_PERC"],
        administrationTaxAmt: json["ADMINISTRATION_TAX_AMT"],
        facilityManageAmt: json["FACILITY_MANAGE_AMT"],
        facilityManageTaxPerc: json["FACILITY_MANAGE_TAX_PERC"],
        facilityManageTaxAmt: json["FACILITY_MANAGE_TAX_AMT"],
        boilerGasConsumptionAmt: json["BOILER_GAS_CONSUMPTION_AMT"],
        boilerGasConsumptionTaxPerc: json["BOILER_GAS_CONSUMPTION_TAX_PERC"],
        boilerGasConsumptionTaxAmt: json["BOILER_GAS_CONSUMPTION_TAX_AMT"],
        delayPaymentAmt: json["DELAY_PAYMENT_AMT"],
        delayPaymentTaxPerc: json["DELAY_PAYMENT_TAX_PERC"],
        delayPaymentTaxAmt: json["DELAY_PAYMENT_TAX_AMT"],
        securityDepReturnAmt: json["SECURITY_DEP_RETURN_AMT"],
        securityDepReturnTaxPerc: json["SECURITY_DEP_RETURN_TAX_PERC"],
        securityDepReturnTaxAmt: json["SECURITY_DEP_RETURN_TAX_AMT"],
        meterPressure: json["METER_PRESSURE"],
        fuelSurcharge: json["FUEL_SURCHARGE"],
        fuelSurchargeAmt: json["FUEL_SURCHARGE_AMT"],
        fuelSurchargeTaxPerc: json["FUEL_SURCHARGE_TAX_PERC"],
        fuelSurchargeTaxAmt: json["FUEL_SURCHARGE_TAX_AMT"],
        name: json["NAME"],
        founded: json["FOUNDED"],
        members: json["MEMBERS"] != null ? List<String>.from(json["MEMBERS"]) : null,
      );
}
