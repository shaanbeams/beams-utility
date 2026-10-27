// To parse this JSON data, do
//
//     final TempReconnectionViewModel = TempReconnectionViewModelFromJson(jsonString);

import 'dart:convert';

TempReconnectionViewModel TempReconnectionViewModelFromJson(String str) => TempReconnectionViewModel.fromJson(json.decode(str));

 

class TempReconnectionViewModel {
    final String? company;
    final String? yearcode;
    final String? docno;
    final String? doctype;
    final String? docdate;
    final String? accode;
    final String? slcode;
    final String? acdescp;
    final String? sldescp;
    final String? partycode;
    final String? partyname;
    final String? buildingCode;
    final String? descp;
    final String? contractNo;
    final String? apartmentCode;
    final String? sman;
    final String? curr;
    final String? currate;
    final String? remarks;
    final String? ref1;
    final String? ref2;
    final String? ref3;
    final String? ref4;
    final String? ref5;
    final String? ref6;
    final String? createUser;
    final String? createDate;
    final String? editUser;
    final String? editDate;
    final String? brncode;
    final String? divcode;
    final String? cccode;
    final String? taxReturnSubmittedYn;
    final String? taxretDocno;
    final String? taxretDoctype;
    final String? taxretYearcode;
    final String? taxretSrno;
    final String? deliveryEmirate;
    final String? onlineSynchStatus;
    final String? connectionDate;
    final String? disconnectionDate;
    final String? trnDatetime;
    final String? contractNoBase64;
    final String? lastReadingDate;
    final String? temporaryDisconnectDate;

    TempReconnectionViewModel({
        this.company,
        this.yearcode,
        this.docno,
        this.doctype,
        this.docdate,
        this.accode,
        this.slcode,
        this.acdescp,
        this.sldescp,
        this.partycode,
        this.partyname,
        this.buildingCode,
        this.descp,
        this.contractNo,
        this.apartmentCode,
        this.sman,
        this.curr,
        this.currate,
        this.remarks,
        this.ref1,
        this.ref2,
        this.ref3,
        this.ref4,
        this.ref5,
        this.ref6,
        this.createUser,
        this.createDate,
        this.editUser,
        this.editDate,
        this.brncode,
        this.divcode,
        this.cccode,
        this.taxReturnSubmittedYn,
        this.taxretDocno,
        this.taxretDoctype,
        this.taxretYearcode,
        this.taxretSrno,
        this.deliveryEmirate,
        this.onlineSynchStatus,
        this.connectionDate,
        this.disconnectionDate,
        this.trnDatetime,
        this.contractNoBase64,
        this.lastReadingDate,
        this.temporaryDisconnectDate,
    });

    factory TempReconnectionViewModel.fromJson(Map<String, dynamic> json) => TempReconnectionViewModel(
        company: json["COMPANY"],
        yearcode: json["YEARCODE"],
        docno: json["DOCNO"],
        doctype: json["DOCTYPE"],
        docdate: json["DOCDATE"],
        accode: json["ACCODE"],
        slcode: json["SLCODE"],
        acdescp: json["ACDESCP"],
        sldescp: json["SLDESCP"],
        partycode: json["PARTYCODE"],
        partyname: json["PARTYNAME"],
        buildingCode: json["BUILDING_CODE"],
        descp: json["DESCP"],
        contractNo: json["CONTRACT_NO"],
        apartmentCode: json["APARTMENT_CODE"],
        sman: json["SMAN"],
        curr: json["CURR"],
        currate: json["CURRATE"],
        remarks: json["REMARKS"],
        ref1: json["REF1"],
        ref2: json["REF2"],
        ref3: json["REF3"],
        ref4: json["REF4"],
        ref5: json["REF5"],
        ref6: json["REF6"],
        createUser: json["CREATE_USER"],
        createDate: json["CREATE_DATE"],
        editUser: json["EDIT_USER"],
        editDate: json["EDIT_DATE"],
        brncode: json["BRNCODE"],
        divcode: json["DIVCODE"],
        cccode: json["CCCODE"],
        taxReturnSubmittedYn: json["TAX_RETURN_SUBMITTED_YN"],
        taxretDocno: json["TAXRET_DOCNO"],
        taxretDoctype: json["TAXRET_DOCTYPE"],
        taxretYearcode: json["TAXRET_YEARCODE"],
        taxretSrno: json["TAXRET_SRNO"],
        deliveryEmirate: json["DELIVERY_EMIRATE"],
        onlineSynchStatus: json["ONLINE_SYNCH_STATUS"],
        connectionDate: json["CONNECTION_DATE"],
        disconnectionDate: json["DISCONNECTION_DATE"],
        trnDatetime: json["TRN_DATETIME"],
        contractNoBase64: json["CONTRACT_NO_BASE64"],
        lastReadingDate: json["LAST_READING_DATE"],
        temporaryDisconnectDate: json["TEMPORARY_DISCONNECT_DATE"],
    );

    
}
