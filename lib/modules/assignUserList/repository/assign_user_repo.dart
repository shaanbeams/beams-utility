import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/modules/assignUserList/model/assign_user_model.dart';
import 'package:gas_utility_app/support/global.dart';

class AssignUserRepository {
  // final LogInController logInController = Get.put(LogInController());

  Future<List<AssignUserModel>?> getAssignUserList({
    required String token,required String searchWord,
  }) async {
    String message = '';

    final Map<String, String> payLoad = {
      "COMPANY": Global.selectedCompanyCode,
      "DOCTYPE": "GCR",
      "BUILDING_CODE": searchWord,
      "CONTRACT_NO": searchWord,
      "APARTMENT_CODE":searchWord,
      "PAGE_NO": "1",
      "PAGE_SIZE": "50",
    };

    final response = await ApiService().post(url: "/api/getPendingConnectionReq", payloadObj: payLoad, token: token).catchError((error) {
      print(error);
    });

    if (response != null) {
      final data = response[0]["Table1"] as List<dynamic>;
      return List<AssignUserModel>.from(
        data.map((item) => AssignUserModel.fromJson(item as Map<String, dynamic>)), // Cast item to Map<String, dynamic>
      );
    } else {
      return null;
    }
  }
}
