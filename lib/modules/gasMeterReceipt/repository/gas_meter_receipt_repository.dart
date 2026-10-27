import 'package:gas_utility_app/modules/gasMeterReceipt/model/view_gas_invoice_receipt.dart';
import 'package:gas_utility_app/support/global.dart';

import '../../../api/api_service.dart';
import '../../../support/helper.dart';
import '../model/reading_receipt_validate_model.dart';

class GasReceiptRepository {
 Future<ReadingInvoiceReceiptValidationModel?> validateInvoiceReceipt({
    required String token,
    required String invoiceDocNo,
    required String invoiceDocType,
    required String invoiceYearCode,
  }) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "INVNO": invoiceDocNo,
      "INVDOCTYPE": invoiceDocType,
      "INVYEARCODE": invoiceYearCode,
      "DOCNO": "",
      "DOCTYPE": "",
      "YEARCODE": Global.selectedCompanyYear
    };
    {}
    logger.f(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/Grec_ValidateInvoice",
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
     
      if (response[0]["Table1"].length != 0) {
        return ReadingInvoiceReceiptValidationModel.fromJson(response[0]["Table1"][0]);
      } else {
        return ReadingInvoiceReceiptValidationModel();
      }
    }
  }

  Future<ViewGasInvoiceReceiptModel?> getLastData({required String token, required String mode, required String docno, String? docType}) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "DOCTYPE": docType != "" ? docType ?? "0" : Global.selectedDocType,
      "DOCNO": docno,
      "YEARCODE": Global.selectedCompanyYear,
      "MODE": mode,
      "CREATE_USER": ""
    };
    final response = await ApiService().post(url: "/api/ViewGasInvoiceReceipt", payloadObj: payLoad, token: token).catchError((error) {});

    if (response != null) {
      final data = response[0];
      if (data.length != 0) {
        return ViewGasInvoiceReceiptModel.fromJson(data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> deleteInvoiceReceipt({
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

    final response = await ApiService().post(url: "/api/DeleteGasInvoiceReceipt", payloadObj: payLoad, token: token).catchError((error) {});

    return response;
  }

  saveGasMeterInvoiceReceipt({required String token, required Map<String, dynamic> payLoad}) async {
    logger.d(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/SaveGasInvoiceReceipt",
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
}
