import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/contract/widgets/custom_bottom_nav_bar.dart';
import 'package:gas_utility_app/modules/disconnectionTemp/controller/temp_disconnection_controller.dart';
import 'package:gas_utility_app/modules/gasMeterInvoice/controller/gas_meter_invoice_controller.dart';
import 'package:gas_utility_app/modules/lookup/view/look_up_dialogue.dart';
import 'package:gas_utility_app/support/common_widgets/common_funtions.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/common_widgets/lookup_search_field.dart';
import 'package:gas_utility_app/support/common_widgets/primary_text_field.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:gas_utility_app/support/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DisconnectionTemporaryPage extends StatefulWidget {
  DisconnectionTemporaryPage({
    super.key,
  });

  @override
  State<DisconnectionTemporaryPage> createState() => _DisconnectionTemporaryPageState();
}

class _DisconnectionTemporaryPageState extends State<DisconnectionTemporaryPage> {
  TempDisconnectionController tempDisconnectionController = Get.put(TempDisconnectionController());

  String? selectedOption;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog();
    });
    tempDisconnectionController.fnGetLastTempContractDisconnection(docNo: "", mode: "LAST");
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  @override
  void dispose() {
    tempDisconnectionController.isEditModeEnabled.value = false;
    Get.delete<GasMeterReadingInvoiceController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: Obx(() => CustomBottomNavBar(
              fnonFirstButtonPressed: () {
                tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "FIRST", docNo: "");
              },
              fnonPreviousButtonPressed: () {
                tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "PREVIOUS", docNo: tempDisconnectionController.txtDocNumController.text);
              },
              fnonLastButtonPressed: () {
                tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "LAST", docNo: "");
              },
              fnonNextButtonPressed: () {
                tempDisconnectionController.fnGetLastTempContractDisconnection(mode: "NEXT", docNo: tempDisconnectionController.txtDocNumController.text);
              },
              fnonSaveButtonPressed: () {
                tempDisconnectionController.fnSaveTemporaryDisconnection();
              },
              fnonCancelPressed: () {
                tempDisconnectionController.isEditModeEnabled.value = false;
                tempDisconnectionController.fnClear();
                tempDisconnectionController.fnGetLastTempContractDisconnection(docNo: "", mode: "LAST");
              },
              fnonAddButtonPressed: () {
                tempDisconnectionController.fnClear();
                tempDisconnectionController.isEditModeEnabled.value = !tempDisconnectionController.isEditModeEnabled.value;
                fnGetGasDocMaster(docType: Global.selectedDocType).then(
                  (value) {
                    tempDisconnectionController.txtCostCenter.text = value[0]["CCCODE"];
                    tempDisconnectionController.txtDivision.text = value[0]["DIVCODE"];
                    tempDisconnectionController.txtBranch.text = value[0]["BRNCODE"];
                  },
                );
              },
              isEditIconEnabled: tempDisconnectionController.isEditModeEnabled.value,
              isAddButtonRequired: true,
            )),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: Get.size.height / 3.5,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  gradient: ThemeGradient.gradient,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 10),
                    child: Row(
                      children: [
                        Bounce(
                          onPressed: () {
                            Get.back();
                          },
                          duration: const Duration(milliseconds: 100),
                          child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: ThemeColors.white,
                              )),
                        ),
                        Image.asset(
                          "assets/icons/disconnected.png",
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Temporary \n Disconnection",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(color: ThemeColors.white, fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: 

                          CustomSearchField(
                            
                            labelColor: Colors.white,
                            label: "Request Doc No",
                            labelYn: true,
                            hintLabel: "Request Doc No",
                            controller: tempDisconnectionController.txtDocNumController,
                            onSearchTap: () {
                              List searchColumn = [
                                {
                                  "showItem": true,
                                  "columnName": "DOCNO",
                                  "showName": "Document No"
                                },
                                {
                                  "showItem": true,
                                  "columnName": "DOCTYPE",
                                  "showName": "DocType"
                                },
                                 
                              ];
                              Get.dialog(lookUpDialogue(
                                callBackFn: (value) {
                                  tempDisconnectionController.txtDocNumController
                                      .text = value["DOCNO"];
                                  tempDisconnectionController
                                      .fnGetLastTempContractDisconnection(
                                          mode: "VIEW", docNo: value["DOCNO"]);
                                  Get.back();
                                },
                                tableName: "GGASTEMPORARY_DISCONNECTION",
                                filter: const [],
                                searchColumn: searchColumn,
                              ));
                            },
                          )
                          
                          
                          
                        ),
                        gapWC(10),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              _tHead(
                                title: "Date : ",
                              ),
                              _tValue(value: Helper.convertDateFormat2(dateTime: DateTime.now().toString())),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "Tenant Details ",
                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.info_outline),
                          ],
                        ),
                      ),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests: tempDisconnectionController.isEditModeEnabled.value,
                        labelYn: true,
                        label: "Contract No",
                        hintLabel: "Contract No",
                      
                        hintSize: 11,
                        onSearchTap: () {
                          if (tempDisconnectionController.isEditModeEnabled.value) {
                            List searchColumn = [
                              {"showItem": true, "columnName": "CONTRACT_NO", "showName": "Contract No"},
                              {"showItem": true, "columnName": "BUILDING_CODE", "showName": "Buildng code"},
                              {"showItem": true, "columnName": "APARTMENT_CODE", "showName": "Appartment code"},
                              {"showItem": true, "columnName": "PARTYNAME", "showName": "Party Name"},
                              {"showItem": false, "columnName": "LAST_READING_DATE", "showName": "Last Reading Date"},
                              {"showItem": false, "columnName": "CONNECTION_DATE", "showName": "Connection Date"},
                            ];
                            Get.dialog(
                              barrierDismissible: false,
                              lookUpDialogue(
                                tableName: "GGASCONTRACT",
                                callBackFn: (value) {
                                  // Get.back();

                                  getBuildingName(buildingCode: value["BUILDING_CODE"]).then((value) {
                                    tempDisconnectionController.txtBuildingNameController.text = value[0]["DESCP"];
                                  });
                                  tempDisconnectionController.txtContractNoController.text = value["CONTRACT_NO"];
                                  tempDisconnectionController.txtBuildingCodeController.text = value["BUILDING_CODE"];
                                  tempDisconnectionController.txtApartmentCodeController.text = value["APARTMENT_CODE"];
                                  tempDisconnectionController.txtTenantNameController.text = value["PARTYNAME"];
                                  tempDisconnectionController.lastReadingDate.value = value["LAST_READING_DATE"];
                                  tempDisconnectionController.connectionDate = value["CONNECTION_DATE"];

                                  // tempDisconnectionController
                                  //     .fnValidateContractDisconnection(
                                  //         contractNo: value["CONTRACT_NO"]);
                                  Get.back();
                                },
                                filter: [
                                  {'Column': "STATUS", 'Operator': '=', 'Value': 'A', 'JoinType': 'AND'},
                                  {'Column': "TEMPORARY_DISCONNECT_YN", 'Operator': '!=', 'Value': 'Y', 'JoinType': 'AND'},
                                ],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                        controller: tempDisconnectionController.txtContractNoController,
                      ),
                      gapHC(10),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: PrimaryInputField(
                                enablests: false,
                                labelYn: true,
                                hintText: "Building code",
                                txtController: tempDisconnectionController.txtBuildingCodeController,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: PrimaryInputField(
                                enablests: false,
                                labelYn: true,
                                hintText: "Appartment code",
                                txtController: tempDisconnectionController.txtApartmentCodeController,
                              ),
                            ),
                          )
                        ],
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,
                          labelYn: true,
                          hintText: "Building Name",
                          txtController: tempDisconnectionController.txtBuildingNameController,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: false,
                          labelYn: true,
                          hintText: "Tenant Name",
                          txtController: tempDisconnectionController.txtTenantNameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last reading date",
                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                        tempDisconnectionController.lastReadingDate.value != null && tempDisconnectionController.lastReadingDate.value!.isNotEmpty
                                            ? Helper.convertDateFormat1(dateTime: tempDisconnectionController.lastReadingDate.value!)
                                            : Helper.convertDateFormat2(dateTime: DateTime.now().toString()),
                                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold))),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 3),
                              child: Bounce(
                                onPressed: () {},
                                duration: const Duration(milliseconds: 100),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ThemeColors.grey,
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    color: ThemeColors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      gapHC(10),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests: tempDisconnectionController.isEditModeEnabled.value,
                        hintLabel: "Branch",
                        label: "Branch",
                        labelYn: true,
                      
                        hintSize: 12,
                        controller: tempDisconnectionController.txtBranch,
                        onSearchTap: () {
                          if (tempDisconnectionController.isEditModeEnabled.value) {
                            List searchColumn = [
                              {"showItem": true, "columnName": "CODE", "showName": "Code"},
                              {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                            ];
                            Get.dialog(
                              barrierDismissible: false,
                              lookUpDialogue(
                                callBackFn: (value) {
                                  tempDisconnectionController.txtBranch.text = value["CODE"].toString();
                                  Get.back();
                                },
                                tableName: "BRANCHMAST",
                                filter: [],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                      ),
                      gapHC(10),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests: tempDisconnectionController.isEditModeEnabled.value,
                        hintLabel: "Division",
                        label: "Division",
                        labelYn: true,
                       
                        hintSize: 12,
                        controller: tempDisconnectionController.txtDivision,
                        onSearchTap: () {
                          if (tempDisconnectionController.isEditModeEnabled.value) {
                            List searchColumn = [
                              {"showItem": true, "columnName": "CODE", "showName": "Code"},
                              {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                            ];
                            Get.dialog(
                              barrierDismissible: false,
                              lookUpDialogue(
                                callBackFn: (value) {
                                  tempDisconnectionController.txtDivision.text = value["CODE"].toString();
                                  Get.back();
                                },
                                tableName: "DIVISIONMASTER",
                                filter: [],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                      ),
                      gapHC(10),
                      CustomSearchField(
                         labelColor: ThemeColors.primaryBlueColor,
                    borderColor: Colors.grey.withOpacity(0.8),
                    fieldColor: ThemeColors.white,
                        enablests: tempDisconnectionController.isEditModeEnabled.value,
                        hintLabel: "Cost center",
                        label: "Cost center",
                        labelYn: true,
                        
                        hintSize: 12,
                        controller: tempDisconnectionController.txtCostCenter,
                        onSearchTap: () {
                          if (tempDisconnectionController.isEditModeEnabled.value) {
                            List searchColumn = [
                              {"showItem": true, "columnName": "CODE", "showName": "Code"},
                              {"showItem": true, "columnName": "DESCP", "showName": "Description"},
                            ];
                            Get.dialog(
                              barrierDismissible: false,
                              lookUpDialogue(
                                callBackFn: (value) {
                                  tempDisconnectionController.txtCostCenter.text = value["CODE"].toString();
                                  Get.back();
                                },
                                tableName: "CCMAST",
                                filter: [
                                  {'Column': "CCTYPE", 'Operator': '=', 'Value': "D", 'JoinType': 'AND'},
                                ],
                                searchColumn: searchColumn,
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Remarks",
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          hintText: "Remarks",
                          txtController: tempDisconnectionController.remarks,
                          isTextArea: true,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: tempDisconnectionController.isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Referece 1",
                          txtController: tempDisconnectionController.ref1,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: tempDisconnectionController.isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Referece 2",
                          txtController: tempDisconnectionController.ref2,
                        ),
                      ),
                      gapHC(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: PrimaryInputField(
                          enablests: tempDisconnectionController.isEditModeEnabled.value,
                          labelYn: true,
                          hintText: "Referece 3",
                          txtController: tempDisconnectionController.ref3,
                        ),
                      ),
                      gapHC(70)
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Text _tHead({required String title, Color? color}) {
    return Text(
      title,
      style: GoogleFonts.poppins(color: color ?? ThemeColors.white, fontSize: 13, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Text _tValue({required String value, Color? color}) {
    return Text(
      value,
      style: GoogleFonts.poppins(
        color: color ?? ThemeColors.white,
        fontSize: 13,
      ),
      textAlign: TextAlign.center,
    );
  }
}
