class Table1 {
  final String? company;
  final String? docNo;
  final String? docType;
  final String? yearCode;
  final String? docDate;
  final String? billCollector;
  final String? buildingCodeFrom;
  final String? buildingCodeTo;
  final String? sman;
  final String? finalInvoiceYn;
  final String? contractNoFrom;
  final String? contractNoTo;
  final String? readingDocNoFrom;
  final String? readingDocNoTo;
  final String? billingCustomer;
  final String? createUser;
  final String? createDate;
  final String? editUser;
  final String? editDate;
  final String? crDays;
  final String? dueDate;
  final String? remarks;
  final String? updatedOnlineYn;
  final String? brnCode;
  final String? divCode;
  final String? ccCode;
  final String? gpCustomerRoundYn;
  final double? readingChargeTaxTotal;
  final double? otherAmtTaxTotal;
  final double? monthlyFeeTaxTotal;
  final double? maintenanceAmtTaxTotal;
  final double? taxAmountTotal;
  final double? netAmount;
  final int? onlineSynchStatus;
  final String? signature;
  final String? createMachine;
  final String? editMachine;

  Table1({
    this.company,
    this.docNo,
    this.docType,
    this.yearCode,
    this.docDate,
    this.billCollector,
    this.buildingCodeFrom,
    this.buildingCodeTo,
    this.sman,
    this.finalInvoiceYn,
    this.contractNoFrom,
    this.contractNoTo,
    this.readingDocNoFrom,
    this.readingDocNoTo,
    this.billingCustomer,
    this.createUser,
    this.createDate,
    this.editUser,
    this.editDate,
    this.crDays,
    this.dueDate,
    this.remarks,
    this.updatedOnlineYn,
    this.brnCode,
    this.divCode,
    this.ccCode,
    this.gpCustomerRoundYn,
    this.readingChargeTaxTotal,
    this.otherAmtTaxTotal,
    this.monthlyFeeTaxTotal,
    this.maintenanceAmtTaxTotal,
    this.taxAmountTotal,
    this.netAmount,
    this.onlineSynchStatus,
    this.signature,
    this.createMachine,
    this.editMachine,
  });

  factory Table1.fromJson(Map<String, dynamic> json) {
    return Table1(
      company: json['COMPANY'],
      docNo: json['DOCNO'],
      docType: json['DOCTYPE'],
      yearCode: json['YEARCODE'],
      docDate: json['DOCDATE'],
      billCollector: json['BILLCOLLECTOR'],
      buildingCodeFrom: json['BUILDING_CODE_FROM'],
      buildingCodeTo: json['BUILDING_CODE_TO'],
      sman: json['SMAN'],
      finalInvoiceYn: json['FINAL_INVOICE_YN'],
      contractNoFrom: json['CONTRACT_NO_FROM'],
      contractNoTo: json['CONTRACT_NO_TO'],
      readingDocNoFrom: json['READING_DOCNO_FROM'],
      readingDocNoTo: json['READING_DOCNO_TO'],
      billingCustomer: json['BILLING_CUSTOMER'],
      createUser: json['CREATE_USER'],
      createDate: json['CREATE_DATE'],
      editUser: json['EDIT_USER'],
      editDate: json['EDIT_DATE'],
      crDays: json['CRDAYS'],
      dueDate: json['DUEDATE'],
      remarks: json['REMARKS'],
      updatedOnlineYn: json['UPDATED_ONLINE_YN'],
      brnCode: json['BRNCODE'],
      divCode: json['DIVCODE'],
      ccCode: json['CCCODE'],
      gpCustomerRoundYn: json['GPCustomer_Round_YN'],
      readingChargeTaxTotal: double.tryParse(json['READING_CHARGE_TAX_TOTAL'] ?? '0'),
      otherAmtTaxTotal: double.tryParse(json['OTHER_AMT_TAX_TOTAL'] ?? '0'),
      monthlyFeeTaxTotal: double.tryParse(json['MONTHLY_FEE_TAX_TOTAL'] ?? '0'),
      maintenanceAmtTaxTotal: double.tryParse(json['MAINTENANCE_AMT_TAX_TOTAL'] ?? '0'),
      taxAmountTotal: double.tryParse(json['TAX_AMOUNT_TOTAL'] ?? '0'),
      netAmount: double.tryParse(json['NET_AMOUNT'] ?? '0'),
      onlineSynchStatus: int.tryParse(json['ONLINE_SYNCH_STATUS'] ?? '0'),
      signature: json['SIGNATURE'],
      createMachine: json['CREATE_MACHINE'],
      editMachine: json['EDIT_MACHINE'],
    );
  }
}

class Table2 {
  final String? company;
  final String? docno;
  final String? doctype;
  final String? yearcode;
  final String? srno;
  final String? buildingCode;
  final String? buildingName;
  final String? apartmentCode;
  final String? lastReading;
  final String? lastReadingDate;
  final String? currReading;
  final String? currReadingDate;
  final String? totalUnit;
  final String? unitPrice;
  final String? amt;
  final String? totalamt;
  final String? monthlyFee;
  final String? otherAmt;
  final String? readingDocno;
  final String? readingDoctype;
  final String? readingYearcode;
  final String? contractNo;
  final String? lastInvdocno;
  final String? lastInvdoctype;
  final String? lastYearcode;
  final String? lastInvdate;
  final String? partycode;
  final String? partyname;
  final String? prevBalance;
  final String? dbreadingamtAccode;
  final String? dbmaintenanceAccode;
  final String? dbmonthlyAccode;
  final String? dbconnectionAccode;
  final String? dbotheramtAccode;
  final String? dbinsuranceamtAccode;
  final String? dbdepositamtAccode;
  final String? readingSrno;
  final String? finalInvoiceYn;
  final String? lastRecDocno;
  final String? lastRecDoctype;
  final String? lastRecDocdate;
  final String? lastRecYearcode;
  final String? lastRecAmt;
  final String? gasMeterNo;
  final String? discAmt;
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
  final String? taxAmountTotal;
  final String? netAmount;
  final String? appSynchStatus;
  final String? depositTaxperc;
  final String? depositTaxamt;
  final String? deposittaxAccode;
  final String? depositAmt;
  final String? onlineSynchStatus;
  final String? administrationAmt;
  final String? billMeterReadingAmt;
  final String? billMeterReadingTaxPerc;
  final String? billMeterReadingTaxAmt;
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
  final String? billMeterReadingVataccode;
  final String? administrationVataccode;
  final String? facilityManageVataccode;
  final String? boilerGasConsumptionVataccode;
  final String? delayPaymentVataccode;
  final String? securityDepReturnVataccode;
  final String? billMeterReadingAccode;
  final String? administrationAccode;
  final String? facilityManageAccode;
  final String? boilerGasConsumptionAccode;
  final String? delayPaymentAccode;
  final String? securityDepReturnAccode;
  final String? webonlineSynchStatus;
  final String? duedate;
  final String? contractNoBase64;
  final String? fuelSurchargeAmt;
  final String? fuelSurchargeTaxPerc;
  final String? fuelSurchargeTaxAmt;
  final String? fuelSurchargeAccode;
  final String? fuelSurchargeVataccode;
  final String? systemCheckupCharge;
  final String? systemCheckupTaxPerc;
  final String? systemCheckupTaxAmt;
  final String? systemCheckupChargeAccode;
  final String? systemCheckupChargeVataccode;
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
    this.buildingName,
    this.apartmentCode,
    this.lastReading,
    this.lastReadingDate,
    this.currReading,
    this.currReadingDate,
    this.totalUnit,
    this.unitPrice,
    this.amt,
    this.totalamt,
    this.monthlyFee,
    this.otherAmt,
    this.readingDocno,
    this.readingDoctype,
    this.readingYearcode,
    this.contractNo,
    this.lastInvdocno,
    this.lastInvdoctype,
    this.lastYearcode,
    this.lastInvdate,
    this.partycode,
    this.partyname,
    this.prevBalance,
    this.dbreadingamtAccode,
    this.dbmaintenanceAccode,
    this.dbmonthlyAccode,
    this.dbconnectionAccode,
    this.dbotheramtAccode,
    this.dbinsuranceamtAccode,
    this.dbdepositamtAccode,
    this.readingSrno,
    this.finalInvoiceYn,
    this.lastRecDocno,
    this.lastRecDoctype,
    this.lastRecDocdate,
    this.lastRecYearcode,
    this.lastRecAmt,
    this.gasMeterNo,
    this.discAmt,
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
    this.taxAmountTotal,
    this.netAmount,
    this.appSynchStatus,
    this.depositTaxperc,
    this.depositTaxamt,
    this.deposittaxAccode,
    this.depositAmt,
    this.onlineSynchStatus,
    this.administrationAmt,
    this.billMeterReadingAmt,
    this.billMeterReadingTaxPerc,
    this.billMeterReadingTaxAmt,
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
    this.billMeterReadingVataccode,
    this.administrationVataccode,
    this.facilityManageVataccode,
    this.boilerGasConsumptionVataccode,
    this.delayPaymentVataccode,
    this.securityDepReturnVataccode,
    this.billMeterReadingAccode,
    this.administrationAccode,
    this.facilityManageAccode,
    this.boilerGasConsumptionAccode,
    this.delayPaymentAccode,
    this.securityDepReturnAccode,
    this.webonlineSynchStatus,
    this.duedate,
    this.contractNoBase64,
    this.fuelSurchargeAmt,
    this.fuelSurchargeTaxPerc,
    this.fuelSurchargeTaxAmt,
    this.fuelSurchargeAccode,
    this.fuelSurchargeVataccode,
    this.systemCheckupCharge,
    this.systemCheckupTaxPerc,
    this.systemCheckupTaxAmt,
    this.systemCheckupChargeAccode,
    this.systemCheckupChargeVataccode,
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
        buildingName: json["BUILDING_NAME"],
        apartmentCode: json["APARTMENT_CODE"],
        lastReading: json["LAST_READING"],
        lastReadingDate: json["LAST_READING_DATE"],
        currReading: json["CURR_READING"],
        currReadingDate: json["CURR_READING_DATE"],
        totalUnit: json["TOTAL_UNIT"],
        unitPrice: json["UNIT_PRICE"],
        amt: json["AMT"],
        totalamt: json["TOTALAMT"],
        monthlyFee: json["MONTHLY_FEE"],
        otherAmt: json["OTHER_AMT"],
        readingDocno: json["READING_DOCNO"],
        readingDoctype: json["READING_DOCTYPE"],
        readingYearcode: json["READING_YEARCODE"],
        contractNo: json["CONTRACT_NO"],
        lastInvdocno: json["LAST_INVDOCNO"],
        lastInvdoctype: json["LAST_INVDOCTYPE"],
        lastYearcode: json["LAST_YEARCODE"],
        lastInvdate: json["LAST_INVDATE"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        prevBalance: json["PREV_BALANCE"],
        dbreadingamtAccode: json["DBREADINGAMT_ACCODE"],
        dbmaintenanceAccode: json["DBMAINTENANCE_ACCODE"],
        dbmonthlyAccode: json["DBMONTHLY_ACCODE"],
        dbconnectionAccode: json["DBCONNECTION_ACCODE"],
        dbotheramtAccode: json["DBOTHERAMT_ACCODE"],
        dbinsuranceamtAccode: json["DBINSURANCEAMT_ACCODE"],
        dbdepositamtAccode: json["DBDEPOSITAMT_ACCODE"],
        readingSrno: json["READING_SRNO"],
        finalInvoiceYn: json["FINAL_INVOICE_YN"],
        lastRecDocno: json["LAST_REC_DOCNO"],
        lastRecDoctype: json["LAST_REC_DOCTYPE"],
        lastRecDocdate: json["LAST_REC_DOCDATE"],
        lastRecYearcode: json["LAST_REC_YEARCODE"],
        lastRecAmt: json["LAST_REC_AMT"],
        gasMeterNo: json["GAS_METER_NO"],
        discAmt: json["DISC_AMT"],
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
        taxAmountTotal: json["TAX_AMOUNT_TOTAL"],
        netAmount: json["NET_AMOUNT"],
        appSynchStatus: json["APP_SYNCH_STATUS"],
        depositTaxperc: json["DEPOSIT_TAXPERC"],
        depositTaxamt: json["DEPOSIT_TAXAMT"],
        deposittaxAccode: json["DEPOSITTAX_ACCODE"],
        depositAmt: json["DEPOSIT_AMT"],
        onlineSynchStatus: json["ONLINE_SYNCH_STATUS"],
        administrationAmt: json["ADMINISTRATION_AMT"],
        billMeterReadingAmt: json["BILL_METER_READING_AMT"],
        billMeterReadingTaxPerc: json["BILL_METER_READING_TAX_PERC"],
        billMeterReadingTaxAmt: json["BILL_METER_READING_TAX_AMT"],
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
        billMeterReadingVataccode: json["BILL_METER_READING_VATACCODE"],
        administrationVataccode: json["ADMINISTRATION_VATACCODE"],
        facilityManageVataccode: json["FACILITY_MANAGE_VATACCODE"],
        boilerGasConsumptionVataccode: json["BOILER_GAS_CONSUMPTION_VATACCODE"],
        delayPaymentVataccode: json["DELAY_PAYMENT_VATACCODE"],
        securityDepReturnVataccode: json["SECURITY_DEP_RETURN_VATACCODE"],
        billMeterReadingAccode: json["BILL_METER_READING_ACCODE"],
        administrationAccode: json["ADMINISTRATION_ACCODE"],
        facilityManageAccode: json["FACILITY_MANAGE_ACCODE"],
        boilerGasConsumptionAccode: json["BOILER_GAS_CONSUMPTION_ACCODE"],
        delayPaymentAccode: json["DELAY_PAYMENT_ACCODE"],
        securityDepReturnAccode: json["SECURITY_DEP_RETURN_ACCODE"],
        webonlineSynchStatus: json["WEBONLINE_SYNCH_STATUS"],
        duedate: json["DUEDATE"],
        contractNoBase64: json["CONTRACT_NO_BASE64"],
        fuelSurchargeAmt: json["FUEL_SURCHARGE_AMT"],
        fuelSurchargeTaxPerc: json["FUEL_SURCHARGE_TAX_PERC"],
        fuelSurchargeTaxAmt: json["FUEL_SURCHARGE_TAX_AMT"],
        fuelSurchargeAccode: json["FUEL_SURCHARGE_ACCODE"],
        fuelSurchargeVataccode: json["FUEL_SURCHARGE_VATACCODE"],
        systemCheckupCharge: json["SYSTEM_CHECKUP_CHARGE"],
        systemCheckupTaxPerc: json["SYSTEM_CHECKUP_TAX_PERC"],
        systemCheckupTaxAmt: json["SYSTEM_CHECKUP_TAX_AMT"],
        systemCheckupChargeAccode: json["SYSTEM_CHECKUP_CHARGE_ACCODE"],
        systemCheckupChargeVataccode: json["SYSTEM_CHECKUP_CHARGE_VATACCODE"],
        name: json["name"],
        founded: json["founded"],
        members: json["members"] == null ? [] : List<String>.from(json["members"]!.map((x) => x)),
      );
}

class ViewGasInvoiceModel {
  final List<Table1?>? table1;
  final List<Table2?>? table2;

  ViewGasInvoiceModel({
    this.table1,
    this.table2,
  });

  factory ViewGasInvoiceModel.fromJson(Map<String, dynamic> json) {
    return ViewGasInvoiceModel(
      table1: (json['Table1'] as List?)?.map((item) => item == null ? null : Table1.fromJson(item)).toList(),
      table2: (json['Table2'] as List?)?.map((item) => item == null ? null : Table2.fromJson(item)).toList(),
    );
  }
}
