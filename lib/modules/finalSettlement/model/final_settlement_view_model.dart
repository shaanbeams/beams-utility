class FinalSettlementViewModel {
  String? company;
  String? docno;
  String? yearcode;
  String? doctype;
  String? docdate;
  String? contractNo;
  String? partycode;
  String? partyname;
  String? buildingCode;
  String? descp;
  String? apartmentCode;
  String? amt;
  String? accode;
  String? acdescp;
  String? slcode;
  String? sldescp;
  String? paymode;
  String? remitto;
  String? chqbank;
  String? chqbankdescp;
  String? chqno;
  String? sman;
  String? remarks;
  String? chqdate;
  String? pdcYn;
  String? createUser;
  String? createDate;
  String? creditcard;
  String? payTo;
  String? brncode;
  String? divcode;
  String? cccode;
  String? netReceivable;
  String? netPayable;
  String? cashflowCat;
  String? insAmt;
  String? netInsAmt;
  String? deposit;
  String? netDeposit;
  String? invoice;
  String? invoiceTax;
  String? invoiceReceived;
  String? netInvoice;
  String? maintenance;
  String? maintenanceTax;
  String? netMaintenance;
  String? securityDep;
  String? securityDepTax;
  String? netSecurityDep;
  String? clearance;
  String? clearanceTax;
  String? netClearance;
  String? disconnection;
  String? disconnectionTax;
  String? netDisconnection;
  String? ded;
  String? dedTax;
  String? netDed;
  String? netAmtpaid;
  String? netNetbal;

  FinalSettlementViewModel({
    this.company,
    this.docno,
    this.yearcode,
    this.doctype,
    this.docdate,
    this.contractNo,
    this.partycode,
    this.partyname,
    this.buildingCode,
    this.descp,
    this.apartmentCode,
    this.amt,
    this.accode,
    this.acdescp,
    this.slcode,
    this.sldescp,
    this.paymode,
    this.remitto,
    this.chqbank,
    this.chqbankdescp,
    this.chqno,
    this.sman,
    this.remarks,
    this.chqdate,
    this.pdcYn,
    this.createUser,
    this.createDate,
    this.creditcard,
    this.payTo,
    this.brncode,
    this.divcode,
    this.cccode,
    this.netReceivable,
    this.netPayable,
    this.cashflowCat,
    this.insAmt,
    this.netInsAmt,
    this.deposit,
    this.netDeposit,
    this.invoice,
    this.invoiceTax,
    this.invoiceReceived,
    this.netInvoice,
    this.maintenance,
    this.maintenanceTax,
    this.netMaintenance,
    this.securityDep,
    this.securityDepTax,
    this.netSecurityDep,
    this.clearance,
    this.clearanceTax,
    this.netClearance,
    this.disconnection,
    this.disconnectionTax,
    this.netDisconnection,
    this.ded,
    this.dedTax,
    this.netDed,
    this.netAmtpaid,
    this.netNetbal,
  });
 
 
  factory FinalSettlementViewModel.fromJson(Map<String, dynamic> json) {
    return FinalSettlementViewModel(
      company: json['COMPANY'] as String?,
      docno: json['DOCNO'] as String?,
      yearcode: json['YEARCODE'] as String?,
      doctype: json['DOCTYPE'] as String?,
      docdate: json['DOCDATE'] as String?,
      contractNo: json['CONTRACT_NO'] as String?,
      partycode: json['PARTYCODE'] as String?,
      partyname: json['PARTYNAME'] as String?,
      buildingCode: json['BUILDING_CODE'] as String?,
      descp: json['DESCP'] as String?,
      apartmentCode: json['APARTMENT_CODE'] as String?,
      amt: json['AMT'] as String?,
      accode: json['ACCODE'] as String?,
      acdescp: json['ACDESCP'] as String?,
      slcode: json['SLCODE'] as String?,
      sldescp: json['SLDESCP'] as String?,
      paymode: json['PAYMODE'] as String?,
      remitto: json['REMITTO'] as String?,
      chqbank: json['CHQBANK'] as String?,
      chqbankdescp: json['CHQBANKDESCP'] as String?,
      chqno: json['CHQNO'] as String?,
      sman: json['SMAN'] as String?,
      remarks: json['REMARKS'] as String?,
      chqdate: json['CHQDATE'] as String?,
      pdcYn: json['PDC_YN'] as String?,
      createUser: json['CREATE_USER'] as String?,
      createDate: json['CREATE_DATE'] as String?,
      creditcard: json['CREDITCARD'] as String?,
      payTo: json['PAY_TO'] as String?,
      brncode: json['BRNCODE'] as String?,
      divcode: json['DIVCODE'] as String?,
      cccode: json['CCCODE'] as String?,
      netReceivable: json['NET_RECEIVABLE'] as String?,
      netPayable: json['NET_PAYABLE'] as String?,
      cashflowCat: json['CASHFLOW_CAT'] as String?,
      insAmt: json['INS_AMT'] as String?,
      netInsAmt: json['NET_INS_AMT'] as String?,
      deposit: json['DEPOSIT'] as String?,
      netDeposit: json['NET_DEPOSIT'] as String?,
      invoice: json['INVOICE'] as String?,
      invoiceTax: json['INVOICE_TAX'] as String?,
      invoiceReceived: json['INVOICE_RECEIVED'] as String?,
      netInvoice: json['NET_INVOICE'] as String?,
      maintenance: json['MAINTENANCE'] as String?,
      maintenanceTax: json['MAINTENANCE_TAX'] as String?,
      netMaintenance: json['NET_MAINTENANCE'] as String?,
      securityDep: json['SECURITY_DEP'] as String?,
      securityDepTax: json['SECURITY_DEP_TAX'] as String?,
      netSecurityDep: json['NET_SECURITY_DEP'] as String?,
      clearance: json['CLEARANCE'] as String?,
      clearanceTax: json['CLEARANCE_TAX'] as String?,
      netClearance: json['NET_CLEARANCE'] as String?,
      disconnection: json['DISCONNECTION'] as String?,
      disconnectionTax: json['DISCONNECTION_TAX'] as String?,
      netDisconnection: json['NET_DISCONNECTION'] as String?,
      ded: json['DED'] as String?,
      dedTax: json['DED_TAX'] as String?,
      netDed: json['NET_DED'] as String?,
      netAmtpaid: json['NET_AMTPAID'] as String?,
      netNetbal: json['NET_NETBAL'] as String?,
    );
  }


 
}
