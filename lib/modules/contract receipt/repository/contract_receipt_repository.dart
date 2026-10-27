import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/contract%20receipt/model/contract_receipt_model.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';

import '../model/contract_receipt_view_model.dart';

class ContractReceiptRepository {
  getContractReceiptDetails({required String token, required String contractNo, String? docNo}) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "CONTRACT_NO": contractNo,
      "DOCTYPE": Global.selectedDocType,
      "DOCNO": docNo ?? "",
      "YEARCODE": Global.selectedCompanyYear,
    };

    final response = await ApiService().post(url: "/api/getContractDet_Rec", payloadObj: payLoad, token: token).catchError((error) {
      print(error);
    });

    if (response != null) {
      final data = response[0]["Table1"];
      if (data.length != 0) {
        return ContractReceiptModel.fromJson(data[0]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> deleteContractReceiptDetails({
    required String token,
    required String docNo,
  }) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "DOCTYPE": Global.selectedDocType,
      "DOCNO": docNo,
      "YEARCODE": Global.selectedCompanyYear,
      "CREATE_USER": Global.userCD,
      "CREATE_MACHINE": Global.wstrDeviceId,
    };

    final response = await ApiService().post(url: "/api/DeleteGasContractRec", payloadObj: payLoad, token: token).catchError((error) {});

    return response;
  }

  saveContractReceipt({
    required String token,
    required selectedContractReceipt,
    required chargeRows,
    required totalCurrAmount,
    required selectedPaymentMode,
    required  txtCreditCard
  }) async {
    List<Map<String, dynamic>> tblGGasContractRec = [
      {
        "COMPANY": Global.selectedCompanyCode,
        "YEARCODE": Global.selectedCompanyYear,
        "DOCNO": "",
        "DOCTYPE": Global.selectedDocType,
        "DOCDATE": Helper.convertDateTime(dateTime: DateTime.now().toString()),
        "ACCODE": "1010201",
        "SLCODE": "",
        "ACDESCP": "CASH COLLECTION - PICKUP 1",
        "SLDESCP": "",
        "PARTYCODE": selectedContractReceipt?.partycode?.value ?? "",
        "PARTYNAME": selectedContractReceipt?.partyname?.value ?? "",
        "BUILDING_CODE": selectedContractReceipt?.buildingCode?.value ?? "",
        "DESCP": selectedContractReceipt?.buildingDescp?.value ?? "",
        "CONTRACT_NO": selectedContractReceipt?.contractNo?.value ?? "",
        "APARTMENT_CODE": selectedContractReceipt?.apartmentCode?.value ?? "",
        "INSAMT_RECV": Helper.mfnDbl(chargeRows[0].txtCurrentAmt.text),
        "DEPAMT_RECV": Helper.mfnDbl(chargeRows[1].txtCurrentAmt.text),
        "CONNECTION_AMT_RECV": Helper.mfnDbl(chargeRows[2].txtCurrentAmt.text),
        "MAINTENANCE_AMT_RECV": Helper.mfnDbl(chargeRows[3].txtCurrentAmt.text),
        "MONTHLY_AMT_RECV": "0",
        "SMAN": "",
        "CURR": "AED",
        "CURRATE": "1.000",
        "CHQBANK": "",
        "CHQBANKDESCP": "",
        "DEPBANK": "",
        "CHQBANK_BRANCH": "",
        "PAYMODE":selectedPaymentMode,
        "REMITTO": "",
        "CHQNO": "",
        "CHQDATE": "",
        "AMT_RECV": totalCurrAmount.value.toString(),
        "AMTFC": totalCurrAmount.value.toString(),
        "PDC_YN": "N",
        "REMARKS": "",
        "REF1": "",
        "REF2": "",
        "REF3": "",
        "REF4": "",
        "REF5": "",
        "REF6": "",
        "ACTIVITY1": "",
        "ACTIVITY2": "",
        "ACTIVITY3": "",
        "CREATE_USER": Global.userCD,
        "CREATE_DATE": Helper.convertDateTime(dateTime: DateTime.now().toString()),
        "EDIT_USER": Global.userCD,
        "EDIT_DATE": Helper.convertDateTime(dateTime: DateTime.now().toString()),
        "CREDITCARD":txtCreditCard,
        "BRNCODE": "",
        "DIVCODE": "",
        "CCCODE": "",
        "DISCONNECTION_AMT_RECV": Helper.mfnDbl(chargeRows[4].txtCurrentAmt.text).toString(),
        "REGISTRATION_AMT_RECV": Helper.mfnDbl(chargeRows[5].txtCurrentAmt.text).toString(),
        "OTHER1_AMT_RECV": Helper.mfnDbl(chargeRows[6].txtCurrentAmt.text).toString(),
        "OTHER2_AMT_RECV": Helper.mfnDbl(chargeRows[7].txtCurrentAmt.text.toString()),
        "OTHER3_AMT_RECV": Helper.mfnDbl(chargeRows[8].txtCurrentAmt.text).toString(),
        "PAY_GEN_YN": "N",
        "INSTAX_PERC": selectedContractReceipt?.insuranceVatperc?.value ?? "0",
        "INSTAX_RECV": chargeRows[0].currTaxAmount.value.toString(),
        "INS_TOTAL_RECV": chargeRows[0].total.value.toString(),
        "INSTAX_ACCODE": "",
        "DEPTAX_PERC": selectedContractReceipt?.depositVatperc?.value ?? "0",
        "DEPTAX_RECV": chargeRows[1].currTaxAmount.value.toString(),
        "DEP_TOTAL_RECV": chargeRows[1].total.value.toString(),
        "DEPTAX_ACCODE": "",
        "CONNECTION_TAX_PERC": selectedContractReceipt?.connectionVatperc?.value ?? "0",
        "CONNECTION_TAX_RECV": chargeRows[2].currTaxAmount.value.toString(),
        "CONNECTION_TOTAL_RECV": chargeRows[2].total.value.toString(),
        "CONNECTIONTAX_ACCODE": "",
        "MAINTENANCE_TAX_PERC": selectedContractReceipt?.maintenanceVatperc?.value ?? "0",
        "MAINTENANCE_TAX_RECV": chargeRows[3].currTaxAmount.value.toString(),
        "MAINTENANCE_TOTAL_RECV": chargeRows[3].total.value.toString(),
        "MAINTENANCETAX_ACCODE": "",
        "DISCONNECTION_TAX_PERC": selectedContractReceipt?.disconnectionVatperc?.value ?? "0",
        "DISCONNECTION_TAX_RECV": chargeRows[4].currTaxAmount.value.toString(),
        "DISCONNECTION_TOTAL_RECV": chargeRows[4].total.value.toString(),
        "DISCONNECTIONTAX_ACCODE": "",
        "REGISTRATION_TAX_PERC": selectedContractReceipt?.registrationVatperc?.value ?? "0",
        "REGISTRATION_TAX_RECV": chargeRows[5].currTaxAmount.value.toString(),
        "REGISTRATION_TOTAL_RECV": chargeRows[5].total.value.toString(),
        "REGISTRATIONTAX_ACCODE": "",
        "OTHER1_TAX_PERC": selectedContractReceipt?.otheramtVatperc?.value ?? "0",
        "OTHER1_TAX_RECV": chargeRows[6].currTaxAmount.value.toString(),
        "OTHER1_TOTAL_RECV": chargeRows[6].total.value.toString(),
        "OTHER1TAX_ACCODE": "",
        "OTHER2_TAX_PERC": selectedContractReceipt?.otheramt2Vatperc?.value ?? "0",
        "OTHER2_TAX_RECV": chargeRows[7].currTaxAmount.value.toString(),
        "OTHER2_TOTAL_RECV": chargeRows[7].total.value.toString(),
        "OTHER2TAX_ACCODE": "",
        "OTHER3_TAX_PERC": selectedContractReceipt?.otheramt3Vatperc?.value ?? "0",
        "OTHER3_TAX_RECV": chargeRows[8].currTaxAmount.value.toString(),
        "OTHER3_TOTAL_RECV": chargeRows[8].total.value.toString(),
        "OTHER3TAX_ACCODE": "",
        "TAX_RETURN_SUBMITTED_YN": "N",
        "TAXRET_DOCNO": "",
        "TAXRET_DOCTYPE": "",
        "TAXRET_YEARCODE": "",
        "TAXRET_SRNO": "0",
        "POST_YN": "N",
        "UNPOST_YN": "",
        "UPLOAD_YN": "",
        "UPLOAD_FILENAME": "",
        "UPLOAD_SHEET": "",
        "UPLOAD_DATE": "",
        "UPLOAD_TIME": "",
        "UPLOAD_FILEPATH": "",
        "CREATE_MACHINE": Global.wstrDeviceId,
        "EDIT_MACHINE": Global.wstrDeviceId
      }
    ];
    final Map<String, dynamic> payLoad = {"TBL_GGASCONTRACTREC": tblGGasContractRec, "MODE": "ADD"};
    logger.d(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/SaveGasContractRec",
      payloadObj: payLoad,
      token: token,
    )
        .catchError((error) {
      print(error);
    });

    logger.f(response);

    if (response != null) {
      final data = response[0];
      return data;
    } else {
      return null;
    }
  }

  Future<ContractReceiptFill?> getLastContractReceiptDetails({
    required String token,
    required String mode,
    required String docno,
  }) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "DOCTYPE": Global.selectedDocType,
      "DOCNO": docno,
      "YEARCODE": Global.selectedCompanyYear,
      "MODE": mode,
      "CREATE_USER": Global.userCD
    };
    final response = await ApiService().post(url: "/api/ViewGasContractRec", payloadObj: payLoad, token: token).catchError((error) {});

    logger.d(response);

    if (response != null) {
      final data = response[0]["Table1"];
      if (data.length != 0) {
        return ContractReceiptFill.fromJson(data[0]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
