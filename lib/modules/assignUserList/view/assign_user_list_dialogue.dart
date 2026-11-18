import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/assignUserList/controller/assign_user_controller.dart';
import 'package:gas_utility_app/modules/assignUserList/model/assign_user_model.dart';
import 'package:gas_utility_app/modules/assignUserList/widgets/assign_user_list_tile_item.dart';
import 'package:gas_utility_app/modules/contract/controller/contract_controller.dart';
import 'package:gas_utility_app/modules/contract/views/contract_page.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AssignUserListDialogue extends StatefulWidget {
  AssignUserListDialogue({
    super.key,
  });

  @override
  State<AssignUserListDialogue> createState() => _AssignUserListDialogueState();
}

class _AssignUserListDialogueState extends State<AssignUserListDialogue> {
  AssignUserController assignUserController = Get.put(AssignUserController(),permanent: true);

  ContractController contractController = Get.put(ContractController(),permanent: true);
  @override
  void initState() {
    assignUserController.fnGetAssignUserList(searchWord: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height / 1.2,
        ),
        child: Container(
          width: Get.width - 40,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assign User List",
                    style: GoogleFonts.poppins(
                      color: ThemeColors.primaryBlueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Bounce(
                    onPressed: () {
                      Get.back();
                    },
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: CupertinoSearchTextField(
                  placeholder: "search by Request No.",
                  placeholderStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: ThemeColors.grey
                  ),
                  borderRadius: BorderRadius.circular(50),
                  onChanged: (value) {
                     assignUserController.fnGetAssignUserList(searchWord: value);
                    // assignUserController.findAssigner(searchWord: value);
                  },
                  keyboardType: TextInputType.text,
                  
                ),
              ),
              Expanded(
                child: Obx(
                  () => assignUserController.isInProgress.value == true
                      ? Center(
                          child: Lottie.asset(
                            "assets/lotties/loader.json",
                            height: 100,
                          ),
                        )
                      : assignUserController.filteredAssignersList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  assignUserController.filteredAssignersList.length,
                              itemBuilder: (context, index) {
                                var userList = assignUserController
                                    .filteredAssignersList[index] as AssignUserModel;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: AssignUserListTile(
                                    reqNo: userList.contractNo ?? "",
                                    apartmentNo: userList.apartmentCode ?? "",
                                    bildingNo: userList.buildingCode ?? "",
                                    partyName: userList.partyname ?? "",
                                    onPressed: () {
                                      assignUserController
                                          .selectedAssignedUser = userList;
                                      contractController
                                          .isEditModeEnabled.value = true;

                                      Get.off(() => ContractPage(
                                            isFromAssignPage: true,
                                          ))?.then((_) {
                                        contractController.fnclear();
                                      });
                                      // Get.off(() => ContractPage(isFromAssignPage: true,));
                                    },
                                  ),
                                );
                              },
                            )
                          : Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                            
                              children: [
                                Image.asset("assets/icons/folder.png",height: 100,color: ThemeColors.grey.withOpacity(0.5),),
                                Text("Nothing to show",
                                    style: GoogleFonts.poppins(
                                      color: ThemeColors.primaryBlueColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ],
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
