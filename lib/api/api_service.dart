import 'dart:convert';

import 'package:gas_utility_app/api/api_exception.dart';
import 'package:gas_utility_app/support/global.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const int timeOutDuration = 60;
  Global g = Global();

  Future<dynamic> post({required String url, dynamic payloadObj, bool? headerRequired = true, String? token}) async {
    var uri = Uri.parse("${g.baseUrl}$url");

    var payload = json.encode(payloadObj);

    final Map<String, String> headers = headerRequired == false
        ? {
            'Content-Type': 'application/json',
          }
        : {
            'Content-Type': 'application/json',
            'MAIN_COMPANYCODE': Global.mainCompany,
            'COMPANY': Global.selectedCompanyCode,
            'YEARCODE': Global.selectedCompanyYear,
          };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }


    try {
      // var response = await http.post(uri, body: payload, headers: headers).timeout(const Duration(seconds: timeOutDuration)).catchError((e) => throw ExceptionHandlers().getExceptionString(e));
      var response = await http.post(uri, body: payload, headers: headers).catchError((e) => throw ExceptionHandlers().getExceptionString(e));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        // return _processResponse(response.body);
      } else {
        if (Get.isDialogOpen == true) {
          Get.back();

        }
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  Future<dynamic> fnGetToken() async {
    Map<String, dynamic> body = {
      'UserName': Global.loginUserName,
      'Password': Global.loginPassword,
      'Client_id': '${Global.mainCompany},${Global.selectedCompanyCode},${Global.selectedCompanyYear}',
      'grant_type': 'password'
    };
    var uri = Uri.parse('${g.baseUrl}/token');
    try {
      var response = await http.post(uri,
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": 'true',
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          },
          body: body,
          encoding: Encoding.getByName("utf-8"));
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  ///----------------------ERROR STATUS CODES----------------------//
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 400: //Bad Request
        throw BadRequestException(jsonDecode(response.body)['Message']);
      case 401: //Unauthorized
        throw UnAuthorizedException(jsonDecode(response.body)['Message']);
      case 403: //Forbidden
        throw UnAuthorizedException(jsonDecode(response.body)['Message']);
      case 404: //Resource Not Found
        throw NotFoundException(jsonDecode(response.body)['Message']);
      case 500: //Internal Server Error
      default:
        throw FetchDataException('Something went wrong! ${response.statusCode}');
    }
  }
}
