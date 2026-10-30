import 'package:gas_utility_app/modules/home/view/home_page.dart';
import 'package:gas_utility_app/modules/login/controller/login_controller.dart';
import 'package:gas_utility_app/modules/login/repository/login_repository.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';

import '../../home/view/home_page_exe.dart';

class LoginFunctions {
  static final LoginRepository loginRepo = LoginRepository();
  static final LogInController logInController = Get.find();

  /// Function to handle login
  /// Takes [username] and [password] as required parameters
  /// Checks if both fields are non-empty, then calls the login function from the repository
  ///  If the login is successful, it navigates to the home page

  // static fnLogin({required String username, required String password}) async {
  //   if (username.isNotEmpty && password.isNotEmpty) {
  //     loginRepo.loginUser(userName: username, password: password).then((response) {
  //       if (response != null) {
  //         Global.userCD = response.userCd;
  //         Global.userName = response.userName;

  //         Global.loginUserName = username;
  //         Global.loginPassword = password;

  //         ///todo
  //         fnLoginSuccess();
  //       }
  //     }).catchError((error) {
  //       logInController.loginErrorText.value = "Login failed: $error";
  //     });
  //   } else {
  //     logInController.loginErrorText.value = "Please enter both username and password";
  //   }
  // }
  static Future<void> fnLogin({required String username, required String password}) async {
  if (username.isEmpty || password.isEmpty) {
    logInController.loginErrorText.value = "Please enter both username and password";
    return; // Exit early
  }

  try {
    // 1. Await the repository call so execution pauses here until the server responds
    final response = await loginRepo.loginUser(userName: username, password: password);

    if (response != null) {
      Global.userCD = response.userCd;
      Global.userName = response.userName;

      Global.loginUserName = username;
      Global.loginPassword = password;

      ///todo
      fnLoginSuccess();
    } else {
      logInController.loginErrorText.value = "Login failed: Invalid response";
    }
  } catch (error) {
    // 2. Catch any network or server errors
    logInController.loginErrorText.value = "Login failed: $error";
    rethrow; // Pass the error up so the button's try/catch knows it failed
  }
}

  /// Function to navigate to HomePage after successful login
  static void fnLoginSuccess() {
    if (Global.isWindows) {
      Get.to(() => HomePageExe(), transition: Transition.fadeIn);
    } else {
      Get.off(() => HomePage());
    }
  }
}
