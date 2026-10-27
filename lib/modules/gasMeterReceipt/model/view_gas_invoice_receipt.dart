class ViewGasInvoiceReceiptModel {
  final List<Table1>? table1;
  final List<Table2>? table2;

  ViewGasInvoiceReceiptModel({this.table1, this.table2});

  factory ViewGasInvoiceReceiptModel.fromJson(Map<String?, dynamic> json) {
    return ViewGasInvoiceReceiptModel(
      table1: List<Table1>.from(json['Table1'].map((x) => Table1.fromJson(x))),
      table2: List<Table2>.from(json['Table2'].map((x) => Table2.fromJson(x))),
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      'Table1': table1!.map((x) => x.toJson()).toList(),
      'Table2': table2!.map((x) => x.toJson()).toList(),
    };
  }
}

class Table1 {
  final String? company;
  final String? docno;
  final String? doctype;
  final String? yearcode;
  final String? docdate;
  final String? sman;
  final String? billCollector;
  final String? buildingCodeFrom;
  final String? buildingCodeTo;
  final String? accode;
  final String? slcode;
  final String? acdesc;
  final String? sldesc;
  final String? curr;
  final String? currate;
  final String? chqBank;
  final String? chqBankDesc;
  final String? depBank;
  final String? chqBankBranch;
  final String? payMode;
  final String? remitTo;
  final String? chqNo;
  final String? chqDate;
  final String? pdcYn;
  final String? remarks;
  final String? ref1;
  final String? ref2;
  final String? ref3;
  final String? ref4;
  final String? ref5;
  final String? ref6;
  final String? activity1;
  final String? activity2;
  final String? activity3;
  final String? contractNoFrom;
  final String? contractNoTo;
  final String? invnoFrom;
  final String? invnoTo;
  final String? createUser;
  final String? createDate;
  final String? editUser;
  final String? editDate;
  final String? creditcard;
  final String? updatedOnlineYn;
  final String? pdaYn;
  final String? receiptTime;
  final String? editReceiptTime;
  final String? pdaMachineId;
  final String? pdaDocno;
  final String? brnCode;
  final String? divCode;
  final String? ccCode;
  final String? onlineSynchStatus;
  final String? uploadYn;
  final String? uploadFilename;
  final String? uploadSheet;
  final String? uploadDate;
  final String? uploadTime;
  final String? uploadFilePath;
  final String? trnAddDate;
  final String? postYn;
  final String? unpostYn;
  final String? orderId;
  final String? accessToken;
  final String? createMachine;
  final String? editMachine;

  Table1({
    this.company,
    this.docno,
    this.doctype,
    this.yearcode,
    this.docdate,
    this.sman,
    this.billCollector,
    this.buildingCodeFrom,
    this.buildingCodeTo,
    this.accode,
    this.slcode,
    this.acdesc,
    this.sldesc,
    this.curr,
    this.currate,
    this.chqBank,
    this.chqBankDesc,
    this.depBank,
    this.chqBankBranch,
    this.payMode,
    this.remitTo,
    this.chqNo,
    this.chqDate,
    this.pdcYn,
    this.remarks,
    this.ref1,
    this.ref2,
    this.ref3,
    this.ref4,
    this.ref5,
    this.ref6,
    this.activity1,
    this.activity2,
    this.activity3,
    this.contractNoFrom,
    this.contractNoTo,
    this.invnoFrom,
    this.invnoTo,
    this.createUser,
    this.createDate,
    this.editUser,
    this.editDate,
    this.creditcard,
    this.updatedOnlineYn,
    this.pdaYn,
    this.receiptTime,
    this.editReceiptTime,
    this.pdaMachineId,
    this.pdaDocno,
    this.brnCode,
    this.divCode,
    this.ccCode,
    this.onlineSynchStatus,
    this.uploadYn,
    this.uploadFilename,
    this.uploadSheet,
    this.uploadDate,
    this.uploadTime,
    this.uploadFilePath,
    this.trnAddDate,
    this.postYn,
    this.unpostYn,
    this.orderId,
    this.accessToken,
    this.createMachine,
    this.editMachine,
  });

  factory Table1.fromJson(Map<String?, dynamic> json) {
    return Table1(
      company: json['COMPANY'] ?? '',
      docno: json['DOCNO'] ?? '',
      doctype: json['DOCTYPE'] ?? '',
      yearcode: json['YEARCODE'] ?? '',
      docdate: json['DOCDATE'] ?? '',
      sman: json['SMAN'] ?? '',
      billCollector: json['BILLCOLLECTOR'] ?? '',
      buildingCodeFrom: json['BUILDING_CODE_FROM'] ?? '',
      buildingCodeTo: json['BUILDING_CODE_TO'] ?? '',
      accode: json['ACCODE'] ?? '',
      slcode: json['SLCODE'] ?? '',
      acdesc: json['ACDESCP'] ?? '',
      sldesc: json['SLDESCP'] ?? '',
      curr: json['CURR'] ?? '',
      currate: json['CURRATE'] ?? '',
      chqBank: json['CHQBANK'] ?? '',
      chqBankDesc: json['CHQBANKDESCP'] ?? '',
      depBank: json['DEPBANK'] ?? '',
      chqBankBranch: json['CHQBANK_BRANCH'] ?? '',
      payMode: json['PAYMODE'] ?? '',
      remitTo: json['REMITTO'] ?? '',
      chqNo: json['CHQNO'] ?? '',
      chqDate: json['CHQDATE'] ?? '',
      pdcYn: json['PDC_YN'] ?? '',
      remarks: json['REMARKS'] ?? '',
      ref1: json['REF1'] ?? '',
      ref2: json['REF2'] ?? '',
      ref3: json['REF3'] ?? '',
      ref4: json['REF4'] ?? '',
      ref5: json['REF5'] ?? '',
      ref6: json['REF6'] ?? '',
      activity1: json['ACTIVITY1'] ?? '',
      activity2: json['ACTIVITY2'] ?? '',
      activity3: json['ACTIVITY3'] ?? '',
      contractNoFrom: json['CONTRACT_NO_FROM'] ?? '',
      contractNoTo: json['CONTRACT_NO_TO'] ?? '',
      invnoFrom: json['INVNO_FROM'] ?? '',
      invnoTo: json['INVNO_TO'] ?? '',
      createUser: json['CREATE_USER'] ?? '',
      createDate: json['CREATE_DATE'] ?? '',
      editUser: json['EDIT_USER'] ?? '',
      editDate: json['EDIT_DATE'] ?? '',
      creditcard: json['CREDITCARD'] ?? '',
      updatedOnlineYn: json['UPDATED_ONLINE_YN'] ?? '',
      pdaYn: json['PDA_YN'] ?? '',
      receiptTime: json['RECEIPT_TIME'] ?? '',
      editReceiptTime: json['EDIT_RECEIPT_TIME'] ?? '',
      pdaMachineId: json['PDA_MACHINE_ID'] ?? '',
      pdaDocno: json['PDA_DOCNO'] ?? '',
      brnCode: json['BRNCODE'] ?? '',
      divCode: json['DIVCODE'] ?? '',
      ccCode: json['CCCODE'] ?? '',
      onlineSynchStatus: json['ONLINE_SYNCH_STATUS'] ?? '',
      uploadYn: json['UPLOAD_YN'] ?? '',
      uploadFilename: json['UPLOAD_FILENAME'] ?? '',
      uploadSheet: json['UPLOAD_SHEET'] ?? '',
      uploadDate: json['UPLOAD_DATE'] ?? '',
      uploadTime: json['UPLOAD_TIME'] ?? '',
      uploadFilePath: json['UPLOAD_FILEPATH'] ?? '',
      trnAddDate: json['TRN_ADD_DATE'] ?? '',
      postYn: json['POST_YN'] ?? '',
      unpostYn: json['UNPOST_YN'] ?? '',
      orderId: json['OrderId'] ?? '',
      accessToken: json['Access_Token'] ?? '',
      createMachine: json['CREATE_MACHINE'] ?? '',
      editMachine: json['EDIT_MACHINE'] ?? '',
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      'COMPANY': company,
      'DOCNO': docno,
      'DOCTYPE': doctype,
      'YEARCODE': yearcode,
      'DOCDATE': docdate,
      'SMAN': sman,
      'BILLCOLLECTOR': billCollector,
      'BUILDING_CODE_FROM': buildingCodeFrom,
      'BUILDING_CODE_TO': buildingCodeTo,
      'ACCODE': accode,
      'SLCODE': slcode,
      'ACDESCP': acdesc,
      'SLDESCP': sldesc,
      'CURR': curr,
      'CURRATE': currate,
      'CHQBANK': chqBank,
      'CHQBANKDESCP': chqBankDesc,
      'DEPBANK': depBank,
      'CHQBANK_BRANCH': chqBankBranch,
      'PAYMODE': payMode,
      'REMITTO': remitTo,
      'CHQNO': chqNo,
      'CHQDATE': chqDate,
      'PDC_YN': pdcYn,
      'REMARKS': remarks,
      'REF1': ref1,
      'REF2': ref2,
      'REF3': ref3,
      'REF4': ref4,
      'REF5': ref5,
      'REF6': ref6,
      'ACTIVITY1': activity1,
      'ACTIVITY2': activity2,
      'ACTIVITY3': activity3,
      'CONTRACT_NO_FROM': contractNoFrom,
      'CONTRACT_NO_TO': contractNoTo,
      'INVNO_FROM': invnoFrom,
      'INVNO_TO': invnoTo,
      'CREATE_USER': createUser,
      'CREATE_DATE': createDate,
      'EDIT_USER': editUser,
      'EDIT_DATE': editDate,
      'CREDITCARD': creditcard,
      'UPDATED_ONLINE_YN': updatedOnlineYn,
      'PDA_YN': pdaYn,
      'RECEIPT_TIME': receiptTime,
      'EDIT_RECEIPT_TIME': editReceiptTime,
      'PDA_MACHINE_ID': pdaMachineId,
      'PDA_DOCNO': pdaDocno,
      'BRNCODE': brnCode,
      'DIVCODE': divCode,
      'CCCODE': ccCode,
      'ONLINE_SYNCH_STATUS': onlineSynchStatus,
      'UPLOAD_YN': uploadYn,
      'UPLOAD_FILENAME': uploadFilename,
      'UPLOAD_SHEET': uploadSheet,
      'UPLOAD_DATE': uploadDate,
      'UPLOAD_TIME': uploadTime,
      'UPLOAD_FILEPATH': uploadFilePath,
      'TRN_ADD_DATE': trnAddDate,
      'POST_YN': postYn,
      'UNPOST_YN': unpostYn,
      'OrderId': orderId,
      'Access_Token': accessToken,
      'CREATE_MACHINE': createMachine,
      'EDIT_MACHINE': editMachine,
    };
  }
}

class Table2 {
  final String? company;
  final String? docno;
  final String? doctype;
  final String? yearcode;
  final String? srno;
  final String? docdate;
  final String? invno;
  final String? invdate;
  final String? buildingCode;
  final String? buildingName;
  final String? apartmentCode;
  final String? partyCode;
  final String? partyName;
  final String? invAmt;
  final String? recAmt;
  final String? contractNo;
  final String? invDoctype;
  final String? invYearcode;
  final String? invSrno;
  final String? readingDocno;
  final String? ref1;
  final String? ref2;
  final String? ref3;
  final String? creditCard;
  final String? payMode;
  final String? discAmt;
  final String? prvDiscAmt;
  final String? onlineFee;
  final String? pdaYn;
  final String? latePayFee;
  final String? smsSendYn;
  final String? lastSmsSendDate;
  final String? pdaMachineId;
  final String? pdaDocno;
  final String? brnCode;
  final String? divCode;
  final String? ccCode;
  final String? payGenYn;
  final String? appSynchStatus;
  final String? ccType;
  final String? cardNo;
  final String? swipingChargePercent;
  final String? swipingGlCode;
  final String? swipingChargeAmt;
  final String? swipingVatPercent;
  final String? swipingVatAccode;
  final String? swipingVatAmt;
  final String? invoiceDeposit;
  final String? prvDepositReceived;
  final String? receivedDeposit;
  final String? onlineSynchStatus;
  final String? docCreateDate;
  final String? rowCreateDate;
  final String? lastRecDocno;
  final String? lastRecDoctype;
  final String? lastRecYearcode;
  final String? lastRecSrno;
  final String? lastRecDate;
  final String? paidAmt;
  final String? onlinePaymentRef;

  Table2({
    this.company,
    this.docno,
    this.doctype,
    this.yearcode,
    this.srno,
    this.docdate,
    this.invno,
    this.invdate,
    this.buildingCode,
    this.buildingName,
    this.apartmentCode,
    this.partyCode,
    this.partyName,
    this.invAmt,
    this.recAmt,
    this.contractNo,
    this.invDoctype,
    this.invYearcode,
    this.invSrno,
    this.readingDocno,
    this.ref1,
    this.ref2,
    this.ref3,
    this.creditCard,
    this.payMode,
    this.discAmt,
    this.prvDiscAmt,
    this.onlineFee,
    this.pdaYn,
    this.latePayFee,
    this.smsSendYn,
    this.lastSmsSendDate,
    this.pdaMachineId,
    this.pdaDocno,
    this.brnCode,
    this.divCode,
    this.ccCode,
    this.payGenYn,
    this.appSynchStatus,
    this.ccType,
    this.cardNo,
    this.swipingChargePercent,
    this.swipingGlCode,
    this.swipingChargeAmt,
    this.swipingVatPercent,
    this.swipingVatAccode,
    this.swipingVatAmt,
    this.invoiceDeposit,
    this.prvDepositReceived,
    this.receivedDeposit,
    this.onlineSynchStatus,
    this.docCreateDate,
    this.rowCreateDate,
    this.lastRecDocno,
    this.lastRecDoctype,
    this.lastRecYearcode,
    this.lastRecSrno,
    this.lastRecDate,
    this.paidAmt,
    this.onlinePaymentRef,
  });

  factory Table2.fromJson(Map<String?, dynamic> json) {
    return Table2(
      company: json['COMPANY'] ?? '',
      docno: json['DOCNO'] ?? '',
      doctype: json['DOCTYPE'] ?? '',
      yearcode: json['YEARCODE'] ?? '',
      srno: json['SRNO'] ?? '',
      docdate: json['DOCDATE'] ?? '',
      invno: json['INVNO'] ?? '',
      invdate: json['INVDATE'] ?? '',
      buildingCode: json['BUILDING_CODE'] ?? '',
      buildingName: json['BUILDING_NAME'] ?? '',
      apartmentCode: json['APARTMENT_CODE'] ?? '',
      partyCode: json['PARTYCODE'] ?? '',
      partyName: json['PARTYNAME'] ?? '',
      invAmt: json['INVAMT'] ?? '',
      recAmt: json['RECAMT'] ?? '',
      contractNo: json['CONTRACT_NO'] ?? '',
      invDoctype: json['INVDOCTYPE'] ?? '',
      invYearcode: json['INVYEARCODE'] ?? '',
      invSrno: json['INVSRNO'] ?? '',
      readingDocno: json['READING_DOCNO'] ?? '',
      ref1: json['REF1'] ?? '',
      ref2: json['REF2'] ?? '',
      ref3: json['REF3'] ?? '',
      creditCard: json['CREDITCARD'] ?? '',
      payMode: json['PAYMODE'] ?? '',
      discAmt: json['DISC_AMT'] ?? '',
      prvDiscAmt: json['PRV_DISC_AMT'] ?? '',
      onlineFee: json['ONLINE_FEE'] ?? '',
      pdaYn: json['PDA_YN'] ?? '',
      latePayFee: json['LATE_PAY_FEE'] ?? '',
      smsSendYn: json['SMS_SEND_YN'] ?? '',
      lastSmsSendDate: json['LAST_SMS_SEND_DATE'] ?? '',
      pdaMachineId: json['PDA_MACHINE_ID'] ?? '',
      pdaDocno: json['PDA_DOCNO'] ?? '',
      brnCode: json['BRNCODE'] ?? '',
      divCode: json['DIVCODE'] ?? '',
      ccCode: json['CCCODE'] ?? '',
      payGenYn: json['PAY_GEN_YN'] ?? '',
      appSynchStatus: json['APP_SYNCH_STATUS'] ?? '',
      ccType: json['CC_TYPE'] ?? '',
      cardNo: json['CARD_NO'] ?? '',
      swipingChargePercent: json['SWIPING_CHARGE_PERCENT'] ?? '',
      swipingGlCode: json['SWIPING_GLCODE'] ?? '',
      swipingChargeAmt: json['SWIPING_CHARGE_AMT'] ?? '',
      swipingVatPercent: json['SWIPING_VAT_PERCENT'] ?? '',
      swipingVatAccode: json['SWIPING_VAT_ACCODE'] ?? '',
      swipingVatAmt: json['SWIPING_VAT_AMT'] ?? '',
      invoiceDeposit: json['INVOICE_DEPOSIT'] ?? '',
      prvDepositReceived: json['PRV_DEPOSIT_RECEIVED'] ?? '',
      receivedDeposit: json['RECEIVED_DEPOSIT'] ?? '',
      onlineSynchStatus: json['ONLINE_SYNCH_STATUS'] ?? '',
      docCreateDate: json['DOC_CREATE_DATE'] ?? '',
      rowCreateDate: json['ROW_CREATEDATE'] ?? '',
      lastRecDocno: json['LAST_REC_DOCNO'] ?? '',
      lastRecDoctype: json['LAST_REC_DOCTYPE'] ?? '',
      lastRecYearcode: json['LAST_REC_YEARCODE'] ?? '',
      lastRecSrno: json['LAST_REC_SRNO'] ?? '',
      lastRecDate: json['LAST_REC_DATE'] ?? '',
      paidAmt: json['PAIDAMT'] ?? '',
      onlinePaymentRef: json['ONLINE_PAYMENT_REF'] ?? '',
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      'COMPANY': company,
      'DOCNO': docno,
      'DOCTYPE': doctype,
      'YEARCODE': yearcode,
      'SRNO': srno,
      'DOCDATE': docdate,
      'INVNO': invno,
      'INVDATE': invdate,
      'BUILDING_CODE': buildingCode,
      'BUILDING_NAME': buildingName,
      'APARTMENT_CODE': apartmentCode,
      'PARTYCODE': partyCode,
      'PARTYNAME': partyName,
      'INVAMT': invAmt,
      'RECAMT': recAmt,
      'CONTRACT_NO': contractNo,
      'INVDOCTYPE': invDoctype,
      'INVYEARCODE': invYearcode,
      'INVSRNO': invSrno,
      'READING_DOCNO': readingDocno,
      'REF1': ref1,
      'REF2': ref2,
      'REF3': ref3,
      'CREDITCARD': creditCard,
      'PAYMODE': payMode,
      'DISC_AMT': discAmt,
      'PRV_DISC_AMT': prvDiscAmt,
      'ONLINE_FEE': onlineFee,
      'PDA_YN': pdaYn,
      'LATE_PAY_FEE': latePayFee,
      'SMS_SEND_YN': smsSendYn,
      'LAST_SMS_SEND_DATE': lastSmsSendDate,
      'PDA_MACHINE_ID': pdaMachineId,
      'PDA_DOCNO': pdaDocno,
      'BRNCODE': brnCode,
      'DIVCODE': divCode,
      'CCCODE': ccCode,
      'PAY_GEN_YN': payGenYn,
      'APP_SYNCH_STATUS': appSynchStatus,
      'CC_TYPE': ccType,
      'CARD_NO': cardNo,
      'SWIPING_CHARGE_PERCENT': swipingChargePercent,
      'SWIPING_GLCODE': swipingGlCode,
      'SWIPING_CHARGE_AMT': swipingChargeAmt,
      'SWIPING_VAT_PERCENT': swipingVatPercent,
      'SWIPING_VAT_ACCODE': swipingVatAccode,
      'SWIPING_VAT_AMT': swipingVatAmt,
      'INVOICE_DEPOSIT': invoiceDeposit,
      'PRV_DEPOSIT_RECEIVED': prvDepositReceived,
      'RECEIVED_DEPOSIT': receivedDeposit,
      'ONLINE_SYNCH_STATUS': onlineSynchStatus,
      'DOC_CREATE_DATE': docCreateDate,
      'ROW_CREATEDATE': rowCreateDate,
      'LAST_REC_DOCNO': lastRecDocno,
      'LAST_REC_DOCTYPE': lastRecDoctype,
      'LAST_REC_YEARCODE': lastRecYearcode,
      'LAST_REC_SRNO': lastRecSrno,
      'LAST_REC_DATE': lastRecDate,
      'PAIDAMT': paidAmt,
      'ONLINE_PAYMENT_REF': onlinePaymentRef,
    };
  }
}
