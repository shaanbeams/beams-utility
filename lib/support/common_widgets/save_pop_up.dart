import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

successPopup() {
  Get.dialog(
    AlertDialog(
      surfaceTintColor: Colors.white,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text.rich(
            TextSpan(text: "Saved Succesfully", style: TextStyle(fontWeight: FontWeight.bold), children: [
              // TextSpan(
              //   text: " DocNo : ",
              //   style: TextStyle(fontWeight: FontWeight.w500),
              // ),
              // TextSpan(
              //   text: "$docno",
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // )
            ]),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
              height: 80,
              child: Lottie.asset(
                "assets/lotties/done.json",
                repeat: false,
              )),
        ],
      ),
    ),
  );
  Future.delayed(const Duration(seconds: 2), () {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  });
}

deletePopup() {
  Get.dialog(
    AlertDialog(
      surfaceTintColor: Colors.white,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text.rich(
            TextSpan(text: "Deleted Successfully", style: TextStyle(fontWeight: FontWeight.bold), children: [
              // TextSpan(
              //   text: " DocNo : ",
              //   style: TextStyle(fontWeight: FontWeight.w500),
              // ),
              // TextSpan(
              //   text: "$docno",
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // )
            ]),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
              height: 80,
              child: Lottie.asset(
                "assets/lotties/done.json",
                repeat: false,
              )),
        ],
      ),
    ),
  );
  Future.delayed(const Duration(seconds: 2), () {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  });
}
