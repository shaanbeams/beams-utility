import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:gas_utility_app/modules/lookup/controller/look_up_controller.dart';
import 'package:gas_utility_app/support/common_widgets/gap.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../support/helper.dart';

class lookUpDialogueExe extends StatefulWidget {
  lookUpDialogueExe({
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
  State<lookUpDialogueExe> createState() => _lookUpDialogueExeState();
}

class _lookUpDialogueExeState extends State<lookUpDialogueExe> {
  LookUpController _lookUpController = Get.put(LookUpController());

  @override
  void initState() {
    _lookUpController.fnlookup(filter: widget.filter, searchColumn: widget.searchColumn, tableName: widget.tableName);

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
            maxHeight: Get.height * .6,
          ),
          child: Container(
            width: Get.width * .7,
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
                      "Search",
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
                          onChanged: (value) {
                            _lookUpController.fnlookup(
                                filter: generateSearchList(value, widget.searchColumn, widget.filter), searchColumn: widget.searchColumn, tableName: widget.tableName);
                          },
                        ),
                      ),
                      Spacer(),
                      // Bounce(
                      //     onPressed: () {
                      //
                      //     },
                      //     duration: Duration(milliseconds: 100),
                      //     child: Icon(Icons.refresh)),
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
                        child: Text(
                          textAlign: TextAlign.start,
                          "Look Data",
                          style: GoogleFonts.poppins(
                            color: ThemeColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                gapHC(10),
                Expanded(
                    child: Obx(
                  () => ListView.builder(
                    itemCount: _lookUpController.lookupData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Bounce(
                        onPressed: () {
                          widget.callBackFn(_lookUpController.lookupData[index]);
                        },
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(color: index % 2 == 0 ? ThemeColors.white : ThemeColors.primaryGrayColor, borderRadius: BorderRadius.circular(5), border: Border.all()),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.searchColumn.length,
                              itemBuilder: (context, indexx) {
                                if (widget.searchColumn[indexx]["showItem"] != false) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: AutoSizeText(
                                              textAlign: TextAlign.start,
                                              widget.searchColumn[indexx]["showName"],
                                              style: GoogleFonts.poppins(
                                                color: ThemeColors.primaryBlueColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          gapWC(5),
                                          Text(
                                            textAlign: TextAlign.start,
                                            ": ${_lookUpController.lookupData[index][widget.searchColumn[indexx]["columnName"]]}",
                                            style: GoogleFonts.poppins(
                                              color: ThemeColors.primaryBlueColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )),
                      );
                    },
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
