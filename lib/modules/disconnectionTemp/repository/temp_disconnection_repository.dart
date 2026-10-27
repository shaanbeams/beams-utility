import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/model/temp_disconnection_view_model.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';

class TempContractDisconnectionRepository {

  fnSaveTempContractDisconnection(
      {required String token, required Map<String, dynamic> payLoad}) async {
    logger.d(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/SaveTemporaryDisconnection",
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


  Future<TempDisconnectionViewModel?> fnGetLastTempContractDisconnection({
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
        .post(url: "/api/ViewTemporaryDisconnection", payloadObj: payLoad, token: token)
        .catchError((error) {});

    logger.d(response);

    if (response != null) {
      final data = response;
      if (data != null) {
        return TempDisconnectionViewModel.fromJson(data[0]["Table1"][0]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
