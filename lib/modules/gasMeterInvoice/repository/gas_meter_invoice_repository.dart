import 'package:gas_utility_app/modules/gasMeterInvoice/model/reading_invoice_validate_model.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/model/view_gas_invoice_model.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';

import '../../../api/api_service.dart';

class GasReadingInvoiceRepository {
  //////////////////////////////// for reference only////////////////////
  /*
    [0] Consumption charge 
    [1] Service charge / monthly fee
    [2] Maintenance charge
    [3] Other charge   
    [4] Administration
    [5] Bill & Meter Reading 
    [6] Facility Management 
    [7] Boiler gas Consumpt
    [8] Delay payment 
    [9] Security 
  */
  //////////////////////////////////////////////////////////

  Future<ReadingInvoiceValidateModel?> validateInvoice({
    required String token,
    required String readingDocNo,
    required String readingDocType,
    required String readingYearCode,
  }) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "READING_DOCNO": readingDocNo,
      "READING_DOCTYPE": readingDocType,
      "READING_YEARCODE": readingYearCode,
      "DOCNO": "",
      "DOCTYPE": Global.selectedDocType,
      "YEARCODE": Global.selectedCompanyYear
    };
    logger.f(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/Ginvoice_ValidateReading",
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
      logger.e(response);
      if (response[0]["Table1"].length != 0) {
        return ReadingInvoiceValidateModel.fromJson(response[0]["Table1"][0]);
      } else {
        return ReadingInvoiceValidateModel();
      }
      // return ReadingInvoiceValidateModel.fromJson(response[0]["Table1"][0]);
    }
  }

  saveInvoice({required String token, required Map<String, dynamic> payLoad}) async {
    logger.d(payLoad);
    
    final response = await ApiService()
        .post(
      url: "/api/SaveGasInvoice",
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

  Future<dynamic> deleteInvoice({
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

    final response = await ApiService().post(url: "/api/DeleteGasInvoice", payloadObj: payLoad, token: token).catchError((error) {});

    return response;
  }

  Future<ViewGasInvoiceModel?> getLastInvoice({
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
      "CREATE_USER": ""
    };
    final response = await ApiService().post(url: "/api/ViewGasInvoice", payloadObj: payLoad, token: token).catchError((error) {});
    logger.d(response);

    if (response != null) {
      final data = response[0];
      if (data.length != 0) {
        return ViewGasInvoiceModel.fromJson(data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
