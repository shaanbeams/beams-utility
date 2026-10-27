import 'package:gas_utility_app/api/api_service.dart';
import 'package:gas_utility_app/support/helper.dart';

class LookUpRepository {
  Future<dynamic> getLookListData({
    required String token,
    required String tableName,
    required String searchColumn,
    required List filter,
  }) async {
    String message = '';
    final Map<String, dynamic> payLoad = {
      // "lstrTable": "SELECT G.* FROM GGASCONTRACT G LEFT JOIN gpay P ON G.CONTRACT_NO = P.CONTRACT_NO WHERE (G.status = 'V' OR G.status = 'C') AND P.CONTRACT_NO IS NULL",
      "lstrTable": tableName,
      "lstrSearchColumn": searchColumn,
      "lstrPage": "0",
      "lstrLimit": "100",
      "lstrFilter": filter
      // [
      ///Example for filter list item
      //   // {'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}
      // ]
    };

    final response = await ApiService()
        .post(url: "/api/lookupSearch", payloadObj: payLoad, token: token)
        .catchError((error) {
      print(error);
    });

    if (response != null) {
      // logger.f(response)
      return response;
      // final data = response[0]["Table1"] as List<dynamic>;
      // return List<AssignUserModel>.from(
      //   data.map((item) => AssignUserModel.fromJson(item as Map<String, dynamic>)), // Cast item to Map<String, dynamic>
      // );
    } else {
      return null;
    }
  }
}
