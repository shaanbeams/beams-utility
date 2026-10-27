// class AssignUserListFunctions {
//   static AssignUserController assignUserController = Get.put(AssignUserController());
//
//   static AssignUserRepository assignUserRepository = AssignUserRepository();
//   static fnGetAssignUserList() {
//     Helper.fngetTocken().then((token) {
//       if (token != null) {
//         assignUserRepository.getAssignUserList(token: token).then((list) {
//           _fnGetAssignUserListSuccess(assignUsersList: list ?? []);
//         });
//       }
//     });
//   }
//
//   static _fnGetAssignUserListSuccess({required List<AssignUserModel> assignUsersList}) {
//     logger.f(assignUsersList.length);
//     assignUserController.assignUserList.assignAll(assignUsersList);
//   }
// }
