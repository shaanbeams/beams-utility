import 'package:gas_utility_app/modules/gasMeterReading/model/validate_apartment_model.dart';
import 'package:gas_utility_app/support/common_widgets/commonDialog.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';

import '../../../api/api_service.dart';
import '../models/reading_correction_model.dart';

class ReadingCorrectionRepository {
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

  Future<ValidateApartmentModel?> validateApartment({required String token, required String buildingCode, required String apartmentCode}) async {
    bool status = false;
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "BUILDING_CODE": buildingCode,
      "APARTMENT_CODE": apartmentCode,
      "DOCNO": "",
      "DOCTYPE": Global.selectedDocType,
      "YEARCODE": Global.selectedCompanyYear
    };

    final response = await ApiService().post(url: "/api/ReadingEntry_ValidateApt", payloadObj: payLoad, token: token).catchError((error) {
      print(error);
    });

    print(response);
    if (response != null) {
      status = response[0]["Table1"][0]["STATUS"] == "1";
      if (status == false) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        errorMsg(msg: response[0]["Table1"][0]["MSG"]);
      } else {
        return ValidateApartmentModel.fromJson(response[0]);
      }
    }
  }

  saveReadingCorrection({required String token, required Map<String, dynamic> payLoad}) async {
    logger.d(payLoad);

    final response = await ApiService()
        .post(
      url: "/api/SaveReadingCorrectionEntry",
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

  Future<dynamic> deleteReadingCorrectionDetails({
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

    final response = await ApiService().post(url: "/api/DeleteReadingEntry", payloadObj: payLoad, token: token).catchError((error) {});

    return response;
  }

  Future<ReadingCorrectionModel?> getLastReadingCorrectionDetails({required String token, required String mode, required String docno, String? docType}) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "DOCTYPE": docType ?? Global.selectedDocType,
      "DOCNO": docno,
      "YEARCODE": Global.selectedCompanyYear,
      "MODE": mode,
      "CREATE_USER": ""
    };
    final response = await ApiService().post(url: "/api/ViewReadingCorrectionEntry", payloadObj: payLoad, token: token).catchError((error) {});

    if (response != null) {
      final data = response[0];
      if (data.length != 0) {
        return ReadingCorrectionModel.fromJson(data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
