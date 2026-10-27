import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gas_utility_app/support/common_widgets/primary_button.dart';
import 'package:gas_utility_app/support/custom_theme.dart';
import 'package:get/get.dart';

import 'gap.dart';

class PageDialog {
  Future<void> showMessage(
    context,
    msg,
    type,
    mode,
    icon,
  ) async {
    return Get.dialog(PopScope(
      canPop: false,
      child: AlertDialog(
          backgroundColor: Colors.transparent,
          content: icon == ""
              ? MessageBox(msg: msg, type: type, mode: mode)
              : MessageBox(
                  msg: msg,
                  type: type,
                  mode: mode,
                  icon: icon,
                )),
    ));
  }
}

class MessageBox extends StatefulWidget {
  final String msg;
  final String type;
  final String mode;
  final IconData? icon;
  const MessageBox(
      {Key? key,
      required this.msg,
      required this.type,
      required this.mode,
      this.icon})
      : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  void initState() {
    // TODO: implement initState
    fnTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: ThemeColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            gapHC(5),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.mode == "S"
                    ? Colors.greenAccent
                    : widget.mode == "E"
                        ? ThemeColors.primaryDeleteRedColor
                        : Colors.amber,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(4, 4),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Icon(
                widget.mode == "S"
                    ? Icons.done_all_rounded
                    : widget.mode == "E"
                        ? Icons.error
                        : widget.mode == "W"
                            ? Icons.warning_amber_outlined
                            : widget.mode == "I"
                                ? Icons.info_outline
                                : widget.mode == "C"
                                    ? widget.icon
                                    : Icons.message,
                color: widget.mode == "W" ? Colors.black : Colors.white,
              ),
            ),
            gapHC(10),
            Expanded(
                child: Center(
                  child: Text(
                                textAlign: TextAlign.center,
                                widget.msg.toString(),
                                style: TextStyle(),
                              ),
                )),
            gapHC(10),
            PrimaryButton(
                buttonLabel: "Close",
                buttonColor: ThemeColors.primaryDeleteRedColor,
                buttonTextColor: ThemeColors.white,
                onPressed: () {
                  Get.back();
                })
          ],
        ));
  }

  //========================================PAGEFN
  //

  fnTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    });
    // var duration = const Duration(seconds: 2);
    // if (widget.type == "CLOSE") {
    //   return Timer(duration, route);
    // }
  }

  route() async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}

errorMsg({required String msg, FocusNode? node}) {
  PageDialog().showMessage(Get.context, msg, "CLOSE", "E", "").then(
    (value) {
      if (node != null) {
        node.previousFocus();
      }
    },
  );
}
