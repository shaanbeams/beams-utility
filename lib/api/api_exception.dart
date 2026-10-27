import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExceptionHandlers {
  getExceptionString(error) {
    // Constant.errorLogData.add("ExceptionHandlers $error");
    if (error is SocketException) {
      // Get.to(() => const NoInternetScreen())?.then(
      //   (value) {},
      // );

      return error.message;
    } else if (error is HttpException) {
      return 'HTTP error occurred';
    } else if (error is FormatException) {
      Get.snackbar(
        'Invalid Format', // Title of the Snackbar
        'Please retry again', // Message of the Snackbar
        snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
        backgroundColor: Colors.black, // Background color of the Snackbar
        colorText: Colors.white, // Text color of the Snackbar
        borderRadius: 10, // Border radius of the Snackbar
        margin: const EdgeInsets.all(10), // Margin around the Snackbar
        duration: const Duration(seconds: 3), // Duration the Snackbar will be displayed
        icon: const Icon(Icons.info, color: Colors.white), // Icon in the Snackbar
        shouldIconPulse: true, // Should the icon pulse
        snackStyle: SnackStyle.FLOATING, // Style of the Snackbar
      );
      return 'Invalid data format';
    } else if (error is TimeoutException) {
      Get.snackbar(
        'Request Time out', // Title of the Snackbar
        'Please retry again', // Message of the Snackbar
        snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
        backgroundColor: Colors.black, // Background color of the Snackbar
        colorText: Colors.white, // Text color of the Snackbar
        borderRadius: 10, // Border radius of the Snackbar
        margin: const EdgeInsets.all(10), // Margin around the Snackbar
        duration: const Duration(seconds: 3), // Duration the Snackbar will be displayed
        icon: const Icon(Icons.info, color: Colors.white), // Icon in the Snackbar
        shouldIconPulse: true, // Should the icon pulse
        snackStyle: SnackStyle.FLOATING, // Style of the Snackbar
      );
      return ' Request timeout';
    } else if (error is BadRequestException) {
      return error.message.toString();
    } else if (error is UnAuthorizedException) {
      return error.message.toString();
    } else if (error is NotFoundException) {
      return error.message.toString();
    } else if (error is FetchDataException) {
      return error.message.toString();
    } else {
      return 'UnKnown error occurred';
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url]) : super(message, 'Bad request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url]) : super(message, 'Unable to process the request', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url]) : super(message, 'Api not responding', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url]) : super(message, 'Unauthorized request', url);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url]) : super(message, 'Page not found', url);
}
