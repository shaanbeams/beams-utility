

import 'dart:convert';

AssignUserModel AssignUserModelFromJson(String str) => AssignUserModel.fromJson(json.decode(str));

String AssignUserModelToJson(AssignUserModel data) => json.encode(data.toJson());

class AssignUserModel {
    final String? company;
    final String? partycode;
    final String? buildingCode;
    final String? apartmentCode;
    final String? partyname;
    final String? contractNo;
    final String? doctype;
    final String? yearcode;

    AssignUserModel({
         this.company,
         this.partycode,
         this.buildingCode,
         this.apartmentCode,
         this.partyname,
         this.contractNo,
         this.doctype,
         this.yearcode,
    });

    factory AssignUserModel.fromJson(Map<String, dynamic> json) => AssignUserModel(
        company: json["COMPANY"],
        partycode: json["PARTYCODE"],
        buildingCode: json["BUILDING_CODE"],
        apartmentCode: json["APARTMENT_CODE"],
        partyname: json["PARTYNAME"],
        contractNo: json["CONTRACT_NO"],
        doctype: json["DOCTYPE"],
        yearcode: json["YEARCODE"],
    );

    Map<String, dynamic> toJson() => {
        "COMPANY": company,
        "PARTYCODE": partycode,
        "BUILDING_CODE": buildingCode,
        "APARTMENT_CODE": apartmentCode,
        "PARTYNAME": partyname,
        "CONTRACT_NO": contractNo,
        "DOCTYPE": doctype,
        "YEARCODE": yearcode,
    };
}
