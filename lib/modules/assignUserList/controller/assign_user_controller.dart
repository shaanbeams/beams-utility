import 'package:gas_utility_app/modules/assignUserList/model/assign_user_model.dart';
import 'package:get/get.dart';

import '../../../support/helper.dart';
import '../repository/assign_user_repo.dart';

class AssignUserController extends GetxController {
  RxList<AssignUserModel> assignUserList = <AssignUserModel>[].obs;

  // RxList<AssignUserModel>? filteredAssignersList;
  RxList<AssignUserModel> filteredAssignersList = RxList<AssignUserModel>();

  int get assignUserListLength => assignUserList.length;
  Rx<bool> isInProgress = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   filteredAssignersList.value = List<AssignUserModel>.from(assignUserList);
  //   // fnGetMonthlyFeeVariable();
  // }

  AssignUserModel? selectedAssignedUser;

  static AssignUserRepository assignUserRepository = AssignUserRepository();

  fnGetAssignUserList({required String searchWord}) {
    isInProgress.value = true;
    Helper.fngetTocken().then((token) {
      if (token != null) {
        assignUserRepository.getAssignUserList(token: token,searchWord: searchWord).then((list) {
          isInProgress.value = false;
          _fnGetAssignUserListSuccess(assignUsersList: list ?? []);
        });
      }
    });
  }

  _fnGetAssignUserListSuccess(
      {required List<AssignUserModel> assignUsersList}) {
    assignUserList.assignAll(assignUsersList);
     filteredAssignersList.value = List<AssignUserModel>.from(assignUserList);

  }

  // void findAssigner({required String searchWord}) {
  //   print(assignUserList);
  //   print(searchWord);
  //   if (searchWord.isEmpty) {
  //     filteredAssignersList?.value = assignUserList as List<AssignUserModel>;
  //   } else {
  //     print(assignUserList.first.partyname);
  //     filteredAssignersList?.value = assignUserList.where((assigner) {
  //       print(assigner.partyname);
  //       return assigner.partyname!
  //           .toLowerCase()
  //           .contains(searchWord.toLowerCase());
  //     }).toList();
  //   }

  //   logger.i(filteredAssignersList);
  // }
  void findAssigner({required String searchWord}) {
 

  
  if (searchWord.isEmpty) {
    filteredAssignersList.value = List<AssignUserModel>.from(assignUserList);
  } else {
   
    filteredAssignersList.value = assignUserList.where((assigner) {
      final requestNo = assigner.contractNo;
      return requestNo != null && requestNo.contains(searchWord);
    }).toList();
  }


  logger.i("Filtered Assigners List: $filteredAssignersList");
}

}
