import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/assignUserList/controller/assign_user_controller.dart';
import 'package:gas_utility_app/modules/assignUserList/model/assign_user_model.dart';
import 'package:gas_utility_app/modules/contract/models/contract_model.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

class ContractRepository {
  // Get.put(AssignUserController());

  Future<ContractModel?> getContractDetails({
    required String token,
  }) async {
    final AssignUserController assignUserController = Get.find();
    AssignUserModel? selectedAssignedUser = assignUserController.selectedAssignedUser;

    final Map<String, String> payLoad = {
      "COMPANY": selectedAssignedUser?.company ?? "",
      "DOCTYPE": selectedAssignedUser?.doctype ?? "",
      "DOCNO": selectedAssignedUser?.contractNo ?? "",
      "YEARCODE": selectedAssignedUser?.yearcode ?? "",
      "MODE": "VIEW"
    };

    final response = await ApiService().post(url: "/api/getConnectionReq", payloadObj: payLoad, token: token).catchError((error) {
      print(error);
    });

    if (response != null) {
      final data = response[0]["Table1"];
      if (data.length != 0) {
        return ContractModel.fromJson(data[0]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<ContractModel?> getLastContractDetails({
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
    final response = await ApiService().post(url: "/api/ViewGasContract", payloadObj: payLoad, token: token).catchError((error) {});

    if (response != null) {
      final data = response[0]["Table1"];
      if (data.length != 0) {
        return ContractModel.fromJson(data[0]);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  dynamic saveContractDetails({required String token, required Map<String, dynamic> payload}) async {
    final response = await ApiService().post(url: "/api/SaveGasContract", payloadObj: payload, token: token).catchError((error) {});

    return response;
  }

  Future<dynamic> deleteContractDetails({
    required String token,
    required String docNo,
  }) async {
    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "DOCTYPE": Global.selectedDocType,
      "DOCNO": docNo,
      "YEARCODE": Global.selectedCompanyYear,
      "CREATE_USER": Global.userCD,
      "CREATE_MACHINE": Global.wstrDeviceId
    };

    final response = await ApiService().post(url: "/api/DeleteGasContract", payloadObj: payLoad, token: token).catchError((error) {});

    return response;
  }
}
