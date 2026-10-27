class ReadingCorrectionModel {
  List<Table1>? table1;
  List<Table2>? table2;

  ReadingCorrectionModel({
    this.table1,
    this.table2,
  });

  factory ReadingCorrectionModel.fromJson(Map<String, dynamic> json) {
    return ReadingCorrectionModel(
      table1: (json['Table1'] as List<dynamic>?)?.map((e) => Table1.fromJson(e as Map<String, dynamic>)).toList(),
      table2: (json['Table2'] as List<dynamic>?)?.map((e) => Table2.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Table1': table1?.map((e) => e.toJson()).toList(),
      'Table2': table2?.map((e) => e.toJson()).toList(),
    };
  }
}

class Table1 {
  String? company;
  String? docNo;
  String? docType;
  String? yearCode;
  String? docDate;
  String? readingDate;
  String? readingBy;
  String? remarks;
  String? readingTotal;
  String? unitTotal;
  String? readingAmountTotal;
  String? otherAmtTotal;
  String? monthlyFeeTotal;
  String? readingChargeTotal;
  String? finalReadingYn;
  String? maintenanceAmtTotal;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? brnCode;
  String? divCode;
  String? ccCode;
  String? readingChargeTaxTotal;
  String? otherAmtTaxTotal;
  String? monthlyFeeTaxTotal;
  String? maintenanceAmtTaxTotal;
  String? taxAmountTotal;
  String? netAmount;
  String? onlineSynchStatus;
  String? createMachine;
  String? editMachine;
  String? imgEidFront;
  String? imgEidBack;
  String? imgMeter;
  String? signature;

  Table1({
    this.company,
    this.docNo,
    this.docType,
    this.yearCode,
    this.docDate,
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
    this.brnCode,
    this.divCode,
    this.ccCode,
    this.readingChargeTaxTotal,
    this.otherAmtTaxTotal,
    this.monthlyFeeTaxTotal,
    this.maintenanceAmtTaxTotal,
    this.taxAmountTotal,
    this.netAmount,
    this.onlineSynchStatus,
    this.createMachine,
    this.editMachine,
    this.imgEidFront,
    this.imgEidBack,
    this.imgMeter,
    this.signature,
  });

  factory Table1.fromJson(Map<String, dynamic> json) {
    return Table1(
      company: json['COMPANY'] as String?,
      docNo: json['DOCNO'] as String?,
      docType: json['DOCTYPE'] as String?,
      yearCode: json['YEARCODE'] as String?,
      docDate: json['DOCDATE'] as String?,
      readingDate: json['READING_DATE'] as String?,
      readingBy: json['READING_BY'] as String?,
      remarks: json['REMARKS'] as String?,
      readingTotal: json['READING_TOTAL'] as String?,
      unitTotal: json['UNIT_TOTAL'] as String?,
      readingAmountTotal: json['READING_AMOUNT_TOTAL'] as String?,
      otherAmtTotal: json['OTHER_AMT_TOTAL'] as String?,
      monthlyFeeTotal: json['MONTHLY_FEE_TOTAL'] as String?,
      readingChargeTotal: json['READING_CHARGE_TOTAL'] as String?,
      finalReadingYn: json['FINAL_READING_YN'] as String?,
      maintenanceAmtTotal: json['MAINTENANCE_AMT_TOTAL'] as String?,
      createUser: json['CREATE_USER'] as String?,
      createDate: json['CREATE_DATE'] as String?,
      editUser: json['EDIT_USER'] as String?,
      editDate: json['EDIT_DATE'] as String?,
      brnCode: json['BRNCODE'] as String?,
      divCode: json['DIVCODE'] as String?,
      ccCode: json['CCCODE'] as String?,
      readingChargeTaxTotal: json['READING_CHARGE_TAX_TOTAL'] as String?,
      otherAmtTaxTotal: json['OTHER_AMT_TAX_TOTAL'] as String?,
      monthlyFeeTaxTotal: json['MONTHLY_FEE_TAX_TOTAL'] as String?,
      maintenanceAmtTaxTotal: json['MAINTENANCE_AMT_TAX_TOTAL'] as String?,
      taxAmountTotal: json['TAX_AMOUNT_TOTAL'] as String?,
      netAmount: json['NET_AMOUNT'] as String?,
      onlineSynchStatus: json['ONLINE_SYNCH_STATUS'] as String?,
      createMachine: json['CREATE_MACHINE'] as String?,
      editMachine: json['EDIT_MACHINE'] as String?,
      imgEidFront: json['IMG_EID_FRONT'] as String?,
      imgEidBack: json['IMG_EID_BACK'] as String?,
      imgMeter: json['IMG_METER'] as String?,
      signature: json['SIGNATURE'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'COMPANY': company,
      'DOCNO': docNo,
      'DOCTYPE': docType,
      'YEARCODE': yearCode,
      'DOCDATE': docDate,
      'READING_DATE': readingDate,
      'READING_BY': readingBy,
      'REMARKS': remarks,
      'READING_TOTAL': readingTotal,
      'UNIT_TOTAL': unitTotal,
      'READING_AMOUNT_TOTAL': readingAmountTotal,
      'OTHER_AMT_TOTAL': otherAmtTotal,
      'MONTHLY_FEE_TOTAL': monthlyFeeTotal,
      'READING_CHARGE_TOTAL': readingChargeTotal,
      'FINAL_READING_YN': finalReadingYn,
      'MAINTENANCE_AMT_TOTAL': maintenanceAmtTotal,
      'CREATE_USER': createUser,
      'CREATE_DATE': createDate,
      'EDIT_USER': editUser,
      'EDIT_DATE': editDate,
      'BRNCODE': brnCode,
      'DIVCODE': divCode,
      'CCCODE': ccCode,
      'READING_CHARGE_TAX_TOTAL': readingChargeTaxTotal,
      'OTHER_AMT_TAX_TOTAL': otherAmtTaxTotal,
      'MONTHLY_FEE_TAX_TOTAL': monthlyFeeTaxTotal,
      'MAINTENANCE_AMT_TAX_TOTAL': maintenanceAmtTaxTotal,
      'TAX_AMOUNT_TOTAL': taxAmountTotal,
      'NET_AMOUNT': netAmount,
      'ONLINE_SYNCH_STATUS': onlineSynchStatus,
      'CREATE_MACHINE': createMachine,
      'EDIT_MACHINE': editMachine,
      'IMG_EID_FRONT': imgEidFront,
      'IMG_EID_BACK': imgEidBack,
      'IMG_METER': imgMeter,
      'SIGNATURE': signature,
    };
  }
}

// Similarly, update Table2 based on your JSON structure.
class Table2 {
  String? company;
  String? docNo;
  String? docType;
  String? yearCode;
  String? srNo;
  String? buildingCode;
  String? descp;
  String? apartmentCode;
  String? lastReading;
  String? lastReadingDate;
  String? currReading;
  String? currReadingDate;
  String? estimateYn;
  String? totalUnit;
  String? unitPrice;
  String? amount;
  String? otherAmt;
  String? monthlyFee;
  String? totalReadCharge;
  String? contractNo;
  String? partyCode;
  String? partyName;
  String? gasMeterNo;
  String? readingConversion;
  String? maintenanceAmt;
  String? brnCode;
  String? divCode;
  String? ccCode;
  String? taxPercReadCharge;
  String? taxAmtReadCharge;
  String? readingTaxAcCode;
  String? taxPercOtherAmt;
  String? taxAmtOtherAmt;
  String? otherTaxAcCode;
  String? taxPercMonthlyFee;
  String? taxAmtMonthlyFee;
  String? monthlyTaxAcCode;
  String? taxPercMaintenanceAmt;
  String? taxAmtMaintenanceAmt;
  String? maintenanceTaxAcCode;
  String? taxAmount;
  String? netAmount;
  String? currReadingTime;
  String? appSynchStatus;
  String? onlineSynchStatus;
  String? billMeterReadingAmt;
  String? billMeterReadingTaxPerc;
  String? billMeterReadingTaxAmt;
  String? administrationAmt;
  String? administrationTaxPerc;
  String? administrationTaxAmt;
  String? facilityManageAmt;
  String? facilityManageTaxPerc;
  String? facilityManageTaxAmt;
  String? boilerGasConsumptionAmt;
  String? boilerGasConsumptionTaxPerc;
  String? boilerGasConsumptionTaxAmt;
  String? delayPaymentAmt;
  String? delayPaymentTaxPerc;
  String? delayPaymentTaxAmt;
  String? securityDepReturnAmt;
  String? securityDepReturnTaxPerc;
  String? securityDepReturnTaxAmt;
  String? meterPressure;
  String? fuelSurcharge;
  String? fuelSurchargeAmt;
  String? fuelSurchargeTaxPerc;
  String? fuelSurchargeTaxAmt;

  Table2({
    this.company,
    this.docNo,
    this.docType,
    this.yearCode,
    this.srNo,
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
    this.totalReadCharge,
    this.contractNo,
    this.partyCode,
    this.partyName,
    this.gasMeterNo,
    this.readingConversion,
    this.maintenanceAmt,
    this.brnCode,
    this.divCode,
    this.ccCode,
    this.taxPercReadCharge,
    this.taxAmtReadCharge,
    this.readingTaxAcCode,
    this.taxPercOtherAmt,
    this.taxAmtOtherAmt,
    this.otherTaxAcCode,
    this.taxPercMonthlyFee,
    this.taxAmtMonthlyFee,
    this.monthlyTaxAcCode,
    this.taxPercMaintenanceAmt,
    this.taxAmtMaintenanceAmt,
    this.maintenanceTaxAcCode,
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
  });

  factory Table2.fromJson(Map<String, dynamic> json) {
    return Table2(
      company: json['COMPANY'] as String?,
      docNo: json['DOCNO'] as String?,
      docType: json['DOCTYPE'] as String?,
      yearCode: json['YEARCODE'] as String?,
      srNo: json['SRNO'] as String?,
      buildingCode: json['BUILDING_CODE'] as String?,
      descp: json['DESCP'] as String?,
      apartmentCode: json['APARTMENT_CODE'] as String?,
      lastReading: json['LAST_READING'] as String?,
      lastReadingDate: json['LAST_READING_DATE'] as String?,
      currReading: json['CURR_READING'] as String?,
      currReadingDate: json['CURR_READING_DATE'] as String?,
      estimateYn: json['ESTIMATE_YN'] as String?,
      totalUnit: json['TOTAL_UNIT'] as String?,
      unitPrice: json['UNIT_PRICE'] as String?,
      amount: json['AMOUNT'] as String?,
      otherAmt: json['OTHER_AMT'] as String?,
      monthlyFee: json['MONTHLY_FEE'] as String?,
      totalReadCharge: json['TOTAL_READCHARGE'] as String?,
      contractNo: json['CONTRACT_NO'] as String?,
      partyCode: json['PARTYCODE'] as String?,
      partyName: json['PARTYNAME'] as String?,
      gasMeterNo: json['GAS_METER_NO'] as String?,
      readingConversion: json['READING_CONVERSION'] as String?,
      maintenanceAmt: json['MAINTENANCE_AMT'] as String?,
      brnCode: json['BRNCODE'] as String?,
      divCode: json['DIVCODE'] as String?,
      ccCode: json['CCCODE'] as String?,
      taxPercReadCharge: json['TAXPERC_READCHARGE'] as String?,
      taxAmtReadCharge: json['TAXAMT_READCHARGE'] as String?,
      readingTaxAcCode: json['READINGTAX_ACCODE'] as String?,
      taxPercOtherAmt: json['TAXPERC_OTHER_AMT'] as String?,
      taxAmtOtherAmt: json['TAXAMT_OTHER_AMT'] as String?,
      otherTaxAcCode: json['OTHERTAX_ACCODE'] as String?,
      taxPercMonthlyFee: json['TAXPERC_MONTHLY_FEE'] as String?,
      taxAmtMonthlyFee: json['TAXAMT_MONTHLY_FEE'] as String?,
      monthlyTaxAcCode: json['MONTHLYTAX_ACCODE'] as String?,
      taxPercMaintenanceAmt: json['TAXPERC_MAINTENANCE_AMT'] as String?,
      taxAmtMaintenanceAmt: json['TAXAMT_MAINTENANCE_AMT'] as String?,
      maintenanceTaxAcCode: json['MAINTENANCETAX_ACCODE'] as String?,
      taxAmount: json['TAX_AMOUNT'] as String?,
      netAmount: json['NET_AMOUNT'] as String?,
      currReadingTime: json['CURR_READING_TIME'] as String?,
      appSynchStatus: json['APP_SYNCH_STATUS'] as String?,
      onlineSynchStatus: json['ONLINE_SYNCH_STATUS'] as String?,
      billMeterReadingAmt: json['BILL_METER_READING_AMT'] as String?,
      billMeterReadingTaxPerc: json['BILL_METER_READING_TAX_PERC'] as String?,
      billMeterReadingTaxAmt: json['BILL_METER_READING_TAX_AMT'] as String?,
      administrationAmt: json['ADMINISTRATION_AMT'] as String?,
      administrationTaxPerc: json['ADMINISTRATION_TAX_PERC'] as String?,
      administrationTaxAmt: json['ADMINISTRATION_TAX_AMT'] as String?,
      facilityManageAmt: json['FACILITY_MANAGE_AMT'] as String?,
      facilityManageTaxPerc: json['FACILITY_MANAGE_TAX_PERC'] as String?,
      facilityManageTaxAmt: json['FACILITY_MANAGE_TAX_AMT'] as String?,
      boilerGasConsumptionAmt: json['BOILER_GAS_CONSUMPTION_AMT'] as String?,
      boilerGasConsumptionTaxPerc: json['BOILER_GAS_CONSUMPTION_TAX_PERC'] as String?,
      boilerGasConsumptionTaxAmt: json['BOILER_GAS_CONSUMPTION_TAX_AMT'] as String?,
      delayPaymentAmt: json['DELAY_PAYMENT_AMT'] as String?,
      delayPaymentTaxPerc: json['DELAY_PAYMENT_TAX_PERC'] as String?,
      delayPaymentTaxAmt: json['DELAY_PAYMENT_TAX_AMT'] as String?,
      securityDepReturnAmt: json['SECURITY_DEP_RETURN_AMT'] as String?,
      securityDepReturnTaxPerc: json['SECURITY_DEP_RETURN_TAX_PERC'] as String?,
      securityDepReturnTaxAmt: json['SECURITY_DEP_RETURN_TAX_AMT'] as String?,
      meterPressure: json['METER_PRESSURE'] as String?,
      fuelSurcharge: json['FUEL_SURCHARGE'] as String?,
      fuelSurchargeAmt: json['FUEL_SURCHARGE_AMT'] as String?,
      fuelSurchargeTaxPerc: json['FUEL_SURCHARGE_TAX_PERC'] as String?,
      fuelSurchargeTaxAmt: json['FUEL_SURCHARGE_TAX_AMT'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'COMPANY': company,
      'DOCNO': docNo,
      'DOCTYPE': docType,
      'YEARCODE': yearCode,
      'SRNO': srNo,
      'BUILDING_CODE': buildingCode,
      'DESCP': descp,
      'APARTMENT_CODE': apartmentCode,
      'LAST_READING': lastReading,
      'LAST_READING_DATE': lastReadingDate,
      'CURR_READING': currReading,
      'CURR_READING_DATE': currReadingDate,
      'ESTIMATE_YN': estimateYn,
      'TOTAL_UNIT': totalUnit,
      'UNIT_PRICE': unitPrice,
      'AMOUNT': amount,
      'OTHER_AMT': otherAmt,
      'MONTHLY_FEE': monthlyFee,
      'TOTAL_READCHARGE': totalReadCharge,
      'CONTRACT_NO': contractNo,
      'PARTYCODE': partyCode,
      'PARTYNAME': partyName,
      'GAS_METER_NO': gasMeterNo,
      'READING_CONVERSION': readingConversion,
      'MAINTENANCE_AMT': maintenanceAmt,
      'BRNCODE': brnCode,
      'DIVCODE': divCode,
      'CCCODE': ccCode,
      'TAXPERC_READCHARGE': taxPercReadCharge,
      'TAXAMT_READCHARGE': taxAmtReadCharge,
      'READINGTAX_ACCODE': readingTaxAcCode,
      'TAXPERC_OTHER_AMT': taxPercOtherAmt,
      'TAXAMT_OTHER_AMT': taxAmtOtherAmt,
      'OTHERTAX_ACCODE': otherTaxAcCode,
      'TAXPERC_MONTHLY_FEE': taxPercMonthlyFee,
      'TAXAMT_MONTHLY_FEE': taxAmtMonthlyFee,
      'MONTHLYTAX_ACCODE': monthlyTaxAcCode,
      'TAXPERC_MAINTENANCE_AMT': taxPercMaintenanceAmt,
      'TAXAMT_MAINTENANCE_AMT': taxAmtMaintenanceAmt,
      'MAINTENANCETAX_ACCODE': maintenanceTaxAcCode,
      'TAX_AMOUNT': taxAmount,
      'NET_AMOUNT': netAmount,
      'CURR_READING_TIME': currReadingTime,
      'APP_SYNCH_STATUS': appSynchStatus,
      'ONLINE_SYNCH_STATUS': onlineSynchStatus,
      'BILL_METER_READING_AMT': billMeterReadingAmt,
      'BILL_METER_READING_TAX_PERC': billMeterReadingTaxPerc,
      'BILL_METER_READING_TAX_AMT': billMeterReadingTaxAmt,
      'ADMINISTRATION_AMT': administrationAmt,
      'ADMINISTRATION_TAX_PERC': administrationTaxPerc,
      'ADMINISTRATION_TAX_AMT': administrationTaxAmt,
      'FACILITY_MANAGE_AMT': facilityManageAmt,
      'FACILITY_MANAGE_TAX_PERC': facilityManageTaxPerc,
      'FACILITY_MANAGE_TAX_AMT': facilityManageTaxAmt,
      'BOILER_GAS_CONSUMPTION_AMT': boilerGasConsumptionAmt,
      'BOILER_GAS_CONSUMPTION_TAX_PERC': boilerGasConsumptionTaxPerc,
      'BOILER_GAS_CONSUMPTION_TAX_AMT': boilerGasConsumptionTaxAmt,
      'DELAY_PAYMENT_AMT': delayPaymentAmt,
      'DELAY_PAYMENT_TAX_PERC': delayPaymentTaxPerc,
      'DELAY_PAYMENT_TAX_AMT': delayPaymentTaxAmt,
      'SECURITY_DEP_RETURN_AMT': securityDepReturnAmt,
      'SECURITY_DEP_RETURN_TAX_PERC': securityDepReturnTaxPerc,
      'SECURITY_DEP_RETURN_TAX_AMT': securityDepReturnTaxAmt,
      'METER_PRESSURE': meterPressure,
      'FUEL_SURCHARGE': fuelSurcharge,
      'FUEL_SURCHARGE_AMT': fuelSurchargeAmt,
      'FUEL_SURCHARGE_TAX_PERC': fuelSurchargeTaxPerc,
      'FUEL_SURCHARGE_TAX_AMT': fuelSurchargeTaxAmt,
    };
  }
}
