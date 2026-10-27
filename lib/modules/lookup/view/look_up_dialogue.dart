import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/lookup/controller/look_up_controller.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../support/helper.dart';

class lookUpDialogue extends StatefulWidget {
  const lookUpDialogue({
    super.key,
    required this.searchColumn,
    required this.tableName,
    required this.filter,
    required this.callBackFn,
  });
  final List searchColumn;
  final String tableName;
  final List filter;
  final Function(dynamic) callBackFn;

  @override
  State<lookUpDialogue> createState() => _lookUpDialogueState();
}

class _lookUpDialogueState extends State<lookUpDialogue> {
  LookUpController _lookUpController = Get.put(LookUpController());
  List mainFilter = [];

  @override
  void initState() {
    _lookUpController.isInProgress.value= true;
    _lookUpController.fnlookup(
        filter: widget.filter,
        searchColumn: widget.searchColumn,
        tableName: widget.tableName);

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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search",
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: CupertinoSearchTextField(
                  borderRadius: BorderRadius.circular(50),
                  suffixIcon: const Icon(Icons.search),
                  onChanged: (value) {
                    _lookUpController.fnlookup(
                        filter: generateSearchList(
                            value, widget.searchColumn, widget.filter),
                        searchColumn: widget.searchColumn,
                        tableName: widget.tableName);
                  },
                ),
              ),
              Expanded(
                  child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:_lookUpController.isInProgress.value==true?
                 SizedBox(
                              height: 500,
                              child: Center(
                                child: Lottie.asset(
                                  "assets/lotties/loader.json",
                                  height: 100,
                                ),
                              ),
                            )
                  : _lookUpController.lookupData.isNotEmpty
                      ? ListView.builder(
                          itemCount: _lookUpController.lookupData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Bounce(
                              onPressed: () {
                                widget.callBackFn(
                                    _lookUpController.lookupData[index]);
                              },
                              duration: const Duration(milliseconds: 100),
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                    color: ThemeColors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child:  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: widget.searchColumn.length,
                                    itemBuilder: (context, indexx) {
                                      if (widget.searchColumn[indexx]
                                              ["showItem"] !=
                                          false) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                // AutoSizeText(
                                                //   textAlign: TextAlign.start,
                                                //   widget.searchColumn[indexx]
                                                //       ["showName"],
                                                //   style: GoogleFonts.poppins(
                                                //     color: ThemeColors
                                                //         .primaryBlueColor,
                                                //     fontSize: 12,
                                                //   ),
                                                // ),

                                                SizedBox(
                                                  width: Get.width / 4,
                                                  child: Text(widget
                                                          .searchColumn[indexx]
                                                      ["showName"]),
                                                ),
                                                gapWC(5),
                                                Text(" : "),
                                                Expanded(
                                                  child: Text(
                                                    textAlign: TextAlign.start,
                                                    "${_lookUpController.lookupData[index][widget.searchColumn[indexx]["columnName"]]}",
                                                    style: GoogleFonts.poppins(
                                                      color: ThemeColors
                                                          .primaryBlueColor,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }  else{
                                        return Container();
                                      }
                                    },
                                  ),),
                            );
                          },
                        )
                        :Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:  CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/folder.png",
                                        height: 100,
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
                              )
                      // : Center(
                      //     child: Lottie.asset(
                      //       "assets/lotties/loader.json",
                      //       height: 100,
                      //     ),
                      //   ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
