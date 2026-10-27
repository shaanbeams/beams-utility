import 'package:gas_utility_app/modules/lookup/repository/look_up_repo.dart';
import 'package:get/get.dart';

import '../../../support/helper.dart';

class LookUpController extends GetxController {
  RxList lookupData = [].obs;
  final LookUpRepository _lookUpRepository = LookUpRepository();
   Rx<bool> isInProgress = false.obs;

  fnlookup({required filter, required searchColumn, required tableName}) {
    String searchColumnString = searchColumn.map((item) => item['columnName']).join('|') + '|';
    Helper.fngetTocken().then((token) {
      if (token != null) {
        _lookUpRepository.getLookListData(token: token, filter: filter, searchColumn: searchColumnString, tableName: tableName).then((list) {
          isInProgress.value= false;
          lookupData.assignAll(list);
        });
      }
    });
  }
}
