class ValidateApartmentModel {
  List<Table1>? table1;
  List<Table2>? table2;
  ValidateApartmentModel({
    this.table1,
    this.table2,
  });
  factory ValidateApartmentModel.fromJson(Map<String, dynamic> json) {
    return ValidateApartmentModel(
      table1: (json['Table1'] as List<dynamic>?)
          ?.map((e) => Table1.fromJson(e as Map<String, dynamic>))
          .toList(),
      table2: (json['Table2'] as List<dynamic>?)
          ?.map((e) => Table2.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  // @override
  // String toString() =>
  //     "ValidateApartmentModel(table1: $table1,table2: $table2)";
  // @override
  // int get hashCode => Object.hash(table1, table2);
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is ValidateApartmentModel &&
  //         runtimeType == other.runtimeType &&
  //         table1 == other.table1 &&
  //         table2 == other.table2;
}

class Table1 {
  String? status;
  String? msg;
  Table1({
    this.status,
    this.msg,
  });
  factory Table1.fromJson(Map<String, dynamic> json) {
    return Table1(
      status: json['STATUS'] as String?,
      msg: json['MSG'] as String?,
    );
  }
  // @override
  // String toString() => "Table1(status: $status,msg: $msg)";
  // @override
  // int get hashCode => Object.hash(status, msg);
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Table1 &&
  //         runtimeType == other.runtimeType &&
  //         status == other.status &&
  //         msg == other.msg;
}

class Table2 {
  String? company;
  String? buildingCode;
  String? apartmentCode;
  String? lastContractNo;
  String? gasMeterNo;
  String? connectionDate;
  String? lastReading;
  String? lastReadingDate;
  String? unitPrice;
  String? monthlyFee;
  String? partycode;
  String? partyname;
  String? readingConversion;
  String? maintenanceAmt;
  String? billMeterReadingAmt;
  String? administrationAmt;
  String? facilityManageAmt;
  String? boilerGasConsumptionAmt;
  String? delayPaymentAmt;
  String? securityDepReturnAmt;
  String? fuelSurchargeAmtfc;
  String? fuelSurchargeTaxPerc;
  String? readingVat;
  String? otheramtVat;
  String? monthlyVat;
  String? maintenanceVat;
  String? billMeterReadingTaxPerc;
  String? administrationTaxPerc;
  String? facilityManageTaxPerc;
  String? boilerGasConsumptionTaxPerc;
  String? delayPaymentTaxPerc;
  String? securityDepReturnTaxPerc;
  String? fuelSurchargeVat;
  String? otherRequiredYN;
  String? otherAmtCalcAmt;
  String? otherAmtCalcType;
  String? outStandingAmount;
  String? lastPaidAmount;
  Table2(
      {this.company,
      this.buildingCode,
      this.apartmentCode,
      this.lastContractNo,
      this.gasMeterNo,
      this.connectionDate,
      this.lastReading,
      this.lastReadingDate,
      this.unitPrice,
      this.monthlyFee,
      this.partycode,
      this.partyname,
      this.readingConversion,
      this.maintenanceAmt,
      this.billMeterReadingAmt,
      this.administrationAmt,
      this.facilityManageAmt,
      this.boilerGasConsumptionAmt,
      this.delayPaymentAmt,
      this.securityDepReturnAmt,
      this.fuelSurchargeAmtfc,
      this.fuelSurchargeTaxPerc,
      this.readingVat,
      this.otheramtVat,
      this.monthlyVat,
      this.maintenanceVat,
      this.billMeterReadingTaxPerc,
      this.administrationTaxPerc,
      this.facilityManageTaxPerc,
      this.boilerGasConsumptionTaxPerc,
      this.delayPaymentTaxPerc,
      this.securityDepReturnTaxPerc,
      this.fuelSurchargeVat,
      this.otherAmtCalcType,
      this.otherAmtCalcAmt,
      this.otherRequiredYN,
      this.outStandingAmount,
      this.lastPaidAmount});
  factory Table2.fromJson(Map<String, dynamic> json) {
    return Table2(
      company: json['COMPANY'] as String?,
      buildingCode: json['BUILDING_CODE'] as String?,
      apartmentCode: json['APARTMENT_CODE'] as String?,
      lastContractNo: json['LAST_CONTRACT_NO'] as String?,
      gasMeterNo: json['GAS_METER_NO'] as String?,
      connectionDate: json['CONNECTION_DATE'] as String?,
      lastReading: json['LAST_READING'] as String?,
      lastReadingDate: json['LAST_READING_DATE'] as String?,
      unitPrice: json['UNIT_PRICE'] as String?,
      monthlyFee: json['MONTHLY_FEE'] as String?,
      partycode: json['PARTYCODE'] as String?,
      partyname: json['PARTYNAME'] as String?,
      readingConversion: json['READING_CONVERSION'] as String?,
      maintenanceAmt: json['MAINTENANCE_AMT'] as String?,
      billMeterReadingAmt: json['BILL_METER_READING_AMT'] as String?,
      administrationAmt: json['ADMINISTRATION_AMT'] as String?,
      facilityManageAmt: json['FACILITY_MANAGE_AMT'] as String?,
      boilerGasConsumptionAmt: json['BOILER_GAS_CONSUMPTION_AMT'] as String?,
      delayPaymentAmt: json['DELAY_PAYMENT_AMT'] as String?,
      securityDepReturnAmt: json['SECURITY_DEP_RETURN_AMT'] as String?,
      fuelSurchargeAmtfc: json['FUEL_SURCHARGE_AMTFC'] as String?,
      fuelSurchargeTaxPerc: json['FUEL_SURCHARGE_TAX_PERC'] as String?,
      readingVat: json['READING_VAT'] as String?,
      otheramtVat: json['OTHERAMT_VAT'] as String?,
      monthlyVat: json['MONTHLY_VAT'] as String?,
      maintenanceVat: json['MAINTENANCE_VAT'] as String?,
      billMeterReadingTaxPerc: json['BILL_METER_READING_TAX_PERC'] as String?,
      administrationTaxPerc: json['ADMINISTRATION_TAX_PERC'] as String?,
      facilityManageTaxPerc: json['FACILITY_MANAGE_TAX_PERC'] as String?,
      boilerGasConsumptionTaxPerc:
          json['BOILER_GAS_CONSUMPTION_TAX_PERC'] as String?,
      delayPaymentTaxPerc: json['DELAY_PAYMENT_TAX_PERC'] as String?,
      securityDepReturnTaxPerc: json['SECURITY_DEP_RETURN_TAX_PERC'] as String?,
      fuelSurchargeVat: json['FUEL_SURCHARGE_VAT'] as String?,
      otherAmtCalcAmt: json['OTHER_AMT_CALC_AMT'] as String?,
      otherAmtCalcType: json['OTHER_AMT_CALC_TYPE'] as String?,
      otherRequiredYN: json['OTHER_REQUIRED_YN'] as String?,
      outStandingAmount: json['OUTSTANDING_AMT'] as String?,
      lastPaidAmount: json['LAST_REC_AMT'] as String?,
     
    );
  }
  // @override
  // String toString() =>
  //     "Table2(company: $company,buildingCode: $buildingCode,apartmentCode: $apartmentCode,lastContractNo: $lastContractNo,gasMeterNo: $gasMeterNo,connectionDate: $connectionDate,lastReading: $lastReading,lastReadingDate: $lastReadingDate,unitPrice: $unitPrice,monthlyFee: $monthlyFee,partycode: $partycode,partyname: $partyname,readingConversion: $readingConversion,maintenanceAmt: $maintenanceAmt,billMeterReadingAmt: $billMeterReadingAmt,administrationAmt: $administrationAmt,facilityManageAmt: $facilityManageAmt,boilerGasConsumptionAmt: $boilerGasConsumptionAmt,delayPaymentAmt: $delayPaymentAmt,securityDepReturnAmt: $securityDepReturnAmt,fuelSurchargeAmtfc: $fuelSurchargeAmtfc,fuelSurchargeTaxPerc: $fuelSurchargeTaxPerc,readingVat: $readingVat,otheramtVat: $otheramtVat,monthlyVat: $monthlyVat,maintenanceVat: $maintenanceVat,billMeterReadingTaxPerc: $billMeterReadingTaxPerc,administrationTaxPerc: $administrationTaxPerc,facilityManageTaxPerc: $facilityManageTaxPerc,boilerGasConsumptionTaxPerc: $boilerGasConsumptionTaxPerc,delayPaymentTaxPerc: $delayPaymentTaxPerc,securityDepReturnTaxPerc: $securityDepReturnTaxPerc,fuelSurchargeVat: $fuelSurchargeVat,otherRequiredYN: $otherRequiredYN,otherAmtCalcType: $otherAmtCalcType,otherAmtCalcAmt: $otherAmtCalcAmt)";
  // @override
  // int get hashCode => Object.hash(
  //     company,
  //     buildingCode,
  //     apartmentCode,
  //     lastContractNo,
  //     gasMeterNo,
  //     connectionDate,
  //     lastReading,
  //     lastReadingDate,
  //     unitPrice,
  //     monthlyFee,
  //     partycode,
  //     partyname,
  //     readingConversion,
  //     maintenanceAmt,
  //     billMeterReadingAmt,
  //     administrationAmt,
  //     facilityManageAmt,
  //     boilerGasConsumptionAmt,
  //     delayPaymentAmt,
  //     securityDepReturnAmt,
  //     fuelSurchargeAmtfc,
  //     fuelSurchargeTaxPerc,
  //     readingVat,
  //     otheramtVat,
  //     monthlyVat,
  //     maintenanceVat,
  //     billMeterReadingTaxPerc,
  //     administrationTaxPerc,
  //     facilityManageTaxPerc,
  //     boilerGasConsumptionTaxPerc,
  //     delayPaymentTaxPerc,
  //     securityDepReturnTaxPerc,
  // //     fuelSurchargeVat);
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Table2 &&
  //         runtimeType == other.runtimeType &&
  //         company == other.company &&
  //         buildingCode == other.buildingCode &&
  //         apartmentCode == other.apartmentCode &&
  //         lastContractNo == other.lastContractNo &&
  //         gasMeterNo == other.gasMeterNo &&
  //         connectionDate == other.connectionDate &&
  //         lastReading == other.lastReading &&
  //         lastReadingDate == other.lastReadingDate &&
  //         unitPrice == other.unitPrice &&
  //         monthlyFee == other.monthlyFee &&
  //         partycode == other.partycode &&
  //         partyname == other.partyname &&
  //         readingConversion == other.readingConversion &&
  //         maintenanceAmt == other.maintenanceAmt &&
  //         billMeterReadingAmt == other.billMeterReadingAmt &&
  //         administrationAmt == other.administrationAmt &&
  //         facilityManageAmt == other.facilityManageAmt &&
  //         boilerGasConsumptionAmt == other.boilerGasConsumptionAmt &&
  //         delayPaymentAmt == other.delayPaymentAmt &&
  //         securityDepReturnAmt == other.securityDepReturnAmt &&
  //         fuelSurchargeAmtfc == other.fuelSurchargeAmtfc &&
  //         fuelSurchargeTaxPerc == other.fuelSurchargeTaxPerc &&
  //         readingVat == other.readingVat &&
  //         otheramtVat == other.otheramtVat &&
  //         monthlyVat == other.monthlyVat &&
  //         maintenanceVat == other.maintenanceVat &&
  //         billMeterReadingTaxPerc == other.billMeterReadingTaxPerc &&
  //         administrationTaxPerc == other.administrationTaxPerc &&
  //         facilityManageTaxPerc == other.facilityManageTaxPerc &&
  //         boilerGasConsumptionTaxPerc == other.boilerGasConsumptionTaxPerc &&
  //         delayPaymentTaxPerc == other.delayPaymentTaxPerc &&
  //         securityDepReturnTaxPerc == other.securityDepReturnTaxPerc &&
  //         fuelSurchargeVat == other.fuelSurchargeVat &&
  //         otherAmtCalcType == other.otherAmtCalcType &&
  //         otherRequiredYN == other.otherRequiredYN &&
  //         otherAmtCalcAmt == other.otherAmtCalcAmt;
}
