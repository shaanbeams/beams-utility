import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/contractDisconnection/model/disconnection_view_model.dart';
import 'package:gas_utility_app/modules/finalSettlement/model/final_settlement_view_model.dart';
import 'package:gas_utility_app/modules/finalSettlement/model/settlement_validation_model.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';

class FinalSettlementrepository {


  

  Future<SettlementValidationModel?> validateFinalSettlement({
    required String token,
    required String contractNo,
  }) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "CONTRACT_NO": contractNo,
      "DOCNO": "",
      "DOCTYPE": "",
      "YEARCODE": ""
    };
    {}
    logger.f(payLoad);
    showLoadingDialog();

    final response = await ApiService()
        .post(
      url: "/api/ContractSettlement_ValidateContract",
      payloadObj: payLoad,
      token: token,
    )
        .catchError((error) {
      print(error);
    });

    logger.t(response);
    if (response == null) {
      return null;
    } else {
      if (response[0] != null) {
        return SettlementValidationModel.fromJson(response[0]);
      } else {
        return SettlementValidationModel();
      }
    }
  }

  fnSaveFinalSettlement(
      {required String token, required Map<String, dynamic> payLoad}) async {
    logger.d(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/SaveContractSettlement",
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


    Future<FinalSettlementViewModel?> fnGetLastFinalSettlement({
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
    final response = await ApiService().post(url: "/api/ViewContractSettlement", payloadObj: payLoad, token: token).catchError((error) {});

    logger.d(response);

    if (response != null) {
      final data = response[0]["Table1"];
      if (data!= null && data.isNotEmpty) {
        return FinalSettlementViewModel.fromJson(data[0]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

 
}