import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/contractDisconnection/model/contract_deduction_validation_model.dart';
import 'package:gas_utility_app/modules/contractDisconnection/model/deduction_model.dart';
import 'package:gas_utility_app/modules/contractDisconnection/model/disconnection_view_model.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';

class ContractDisconnectionRepository {
  Future<List<DeductionChargeModel>?> getDeductionCharges({
    required String token,
  }) async {
    final Map<String, String> payLoad = {
      "COMPANY": "01",
    };
    final response = await ApiService()
        .post(
            url: "/api/ContractRefund_GetDisconnCharges",
            payloadObj: payLoad,
            token: token)
        .catchError((error) {
      print(error);
    });

    if (response != null) {
      final data = response[0]["Table1"];
      logger.i(data);
      if (data.length != 0) {
        return data.map<DeductionChargeModel>((item) {
          return DeductionChargeModel.fromJson(item);
        }).toList();
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ContratDisconnectionValidationModel?> validateContractDisconnection({
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

    logger.e(DateTime.now());
    logger.f(payLoad);
    showLoadingDialog();

    final response = await ApiService()
        .post(
      url: "/api/ContractRefund_ValidateContract",
      payloadObj: payLoad,
      token: token,
    )
        .catchError((error) {
      print(error);
    });
    logger.e(DateTime.now());

    logger.t(response);
    if (response == null) {
      return null;
    } else {
      if (response[0] != null) {
        return ContratDisconnectionValidationModel.fromJson(response[0]);
      } else {
        return ContratDisconnectionValidationModel();
      }
    }
  }

  fnSaveContractDisconnection(
      {required String token, required Map<String, dynamic> payLoad}) async {
    logger.d(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/SaveContractRefund",
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

  Future<ContractDisViewModel?> fnGetLastContractDisconnection({
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
    final response = await ApiService()
        .post(url: "/api/ViewContractRefund", payloadObj: payLoad, token: token)
        .catchError((error) {});

    logger.d(response);

    if (response != null) {
      final data = response;
      if (data != null) {
        return ContractDisViewModel.fromJson(data[0]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
