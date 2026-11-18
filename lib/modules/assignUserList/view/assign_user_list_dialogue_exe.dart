import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/views_exe/contract_page_exe.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../controller/assign_user_controller.dart';
import '../model/assign_user_model.dart';

class AssignUserListDialogueExe extends StatefulWidget {
  AssignUserListDialogueExe({
    super.key,
  });

  @override
  State<AssignUserListDialogueExe> createState() => _AssignUserListDialogueExeState();
}

class _AssignUserListDialogueExeState extends State<AssignUserListDialogueExe> {
  AssignUserController assignUserController = Get.put(AssignUserController(), permanent: true);

  @override
  void initState() {
    assignUserController.fnGetAssignUserList(searchWord: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                gapWC(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    gapWC(50),
                    Expanded(
                        child: Divider(
                      color: ThemeColors.primaryBlueColor,
                      height: .5,
                    )),
                    gapWC(30),
                    Text(
                      "Assign User List",
                      style: GoogleFonts.poppins(
                        color: ThemeColors.primaryBlueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapWC(30),
                    Expanded(
                        child: Divider(
                      color: ThemeColors.primaryBlueColor,
                      height: .5,
                    )),
                    gapWC(30),
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
                gapHC(30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * .36,
                        child: CupertinoSearchTextField(
                          borderRadius: BorderRadius.circular(50),
                          suffixIcon: const Icon(Icons.search),
                          placeholder: "search by Request No.",
                          onChanged: (value) {
                             assignUserController.findAssigner(searchWord: value);
                          },
                          keyboardType:TextInputType.number ,

                        ),
                      ),
                      Spacer(),
                      Bounce(
                          onPressed: () {
                            assignUserController.fnGetAssignUserList(searchWord: "");
                          },
                          duration: Duration(milliseconds: 100),
                          child: Icon(Icons.refresh)),
                    ],
                  ),
                ),
                gapHC(20),
                Container(
                  height: Get.height * .04,
                  decoration: BoxDecoration(
                    color: ThemeColors.primaryBlueColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      gapWC(40),
                      Expanded(
                        flex: 1,
                        child: AutoSizeText(
                          textAlign: TextAlign.start,
                          "Request No",
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            color: ThemeColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      gapWC(10),
                      Expanded(
                        flex: 1,
                        child: AutoSizeText(
                          textAlign: TextAlign.center,
                          "Building No",
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            color: ThemeColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      gapWC(10),
                      Expanded(
                        flex: 1,
                        child: AutoSizeText(
                          textAlign: TextAlign.center,
                          "Apartment No",
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            color: ThemeColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      gapWC(10),
                      Expanded(
                        flex: 3,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Party Name",
                        ),
                      ),
                    ],
                  ),
                ),
                gapHC(10),
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
                              itemCount: assignUserController.filteredAssignersList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var userList = assignUserController.filteredAssignersList[index] as AssignUserModel;
                                return Bounce(
                                  onPressed: () {
                                    assignUserController.selectedAssignedUser = userList;
                                    Get.off(() => ContractPageExe(
                                          isFromAssignPage: true,
                                        ));
                                  },
                                  duration: const Duration(milliseconds: 100),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0 ? ThemeColors.white : ThemeColors.primaryGrayColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        gapWC(40),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            textAlign: TextAlign.start,
                                            userList.contractNo ?? "",
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.primaryBlueColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        gapWC(10),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            userList.apartmentCode ?? "",
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.primaryBlueColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        gapWC(10),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            userList.buildingCode ?? "",
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.primaryBlueColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        gapWC(10),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            userList.partyname ?? "",
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.primaryBlueColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/folder.png",
                                    height: 200,
                                    color: ThemeColors.grey.withOpacity(0.5),
                                  ),
                                  Text("Nothing to show",
                                      style: GoogleFonts.poppins(
                                        color: ThemeColors.primaryBlueColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ],
                              ),
                            ),
                ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
