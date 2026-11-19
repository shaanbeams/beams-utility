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


  // Future<TempDisconnectionViewModel?> fnGetLastTempContractDisconnection({
  //   required String token,
  //   required String mode,
  //   required String docno,
  // }) async {
  //   final Map<String, String> payLoad = {
  //     "COMPANY": Global.selectedCompanyCode,
  //     "DOCTYPE": Global.selectedDocType,
  //     "DOCNO": docno,
  //     "YEARCODE": Global.selectedCompanyYear,
  //     "MODE": mode,
  //     "CREATE_USER": Global.userCD

  //   };
  //   final response = await ApiService()
  //       .post(url: "/api/ViewTemporaryDisconnection", payloadObj: payLoad, token: token)
  //       .catchError((error) {});

  //   logger.d(response);

  //   if (response != null) {
  //     final data = response;
  //     if (data != null) {
  //       return TempDisconnectionViewModel.fromJson(data[0]["Table1"][0]);
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }


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
    "CREATE_USER": Global.userCD,
  };

  try {
    final response = await ApiService().post(
      url: "/api/ViewTemporaryDisconnection",
      payloadObj: payLoad,
      token: token,
    );

    logger.d(response);

    if (response is List && response.isNotEmpty) {
      final firstItem = response[0];
      if (firstItem is Map && firstItem["Table1"] is List) {
        final List table1 = firstItem["Table1"];
        if (table1.isNotEmpty && table1[0] is Map<String, dynamic>) {
          return TempDisconnectionViewModel.fromJson(table1[0]);
        }
      }
    }

    return null;
  } catch (error, stackTrace) {
    logger.e("fnGetLastTempContractDisconnection error: $error", stackTrace: stackTrace);
    return null;
  }
}
}
