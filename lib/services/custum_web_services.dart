import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghumo_24/model/login_request_model.dart';
import 'package:ghumo_24/model/login_response_model.dart';
import 'package:ghumo_24/model/otp_model.dart';
import 'package:ghumo_24/services/shared_services.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../../config.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(String phone, context) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
      Config.apiURL + Config.loginAPI + "?phone=${phone.toString()}",
    );

    print("======url=====$url============response====================");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"roles": "vendor"}),
    );

    print(
        "======url=====$url========${response.statusCode}====response========$response============");

    if (response.statusCode == 200) {
      print("  response.body,${response.body}");

      var data = jsonDecode(response.body);
      if (data['sucess'] == true) {
        await SharedService.setLoginDetails(
          otpResponseModelFromJson(
            response.body,
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data['message']}')));
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> signup(String phone, context) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
      Config.apiURL + Config.registerAPI + "?phone=${phone.toString()}",
    );

    print("======url=====$url============response====================");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"roles": "vendor"}),
    );

    print(
        "======url=====$url========${response.statusCode}====response========$response============");

    if (response.statusCode == 200) {
      print("  response.body,${response.body}");

      var data = jsonDecode(response.body);
      if (data['sucess'] == true) {
        await SharedService.setLoginDetails(
          otpResponseModelFromJson(
            response.body,
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data['message']}')));
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> otpverification(
    String otp,
  ) async {
    print(
        "=============otp=========otpverification==============$otp============");
    Map<String, String> requestHeaders = {
      // 'Content-Type': 'application/json',
    };
    var box = GetStorage();

    print(
        "===========loginDetails=======${box.read("user_id")}====================");

    var url = Uri.parse(
      Config.apiURL + Config.otpAPI + "${box.read("user_id")}",
    );

    print("======url=====$url======otp=$otp=====response====================");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: {"otp": otp},
    );

    print(
        "======url=====$url========${response.statusCode}====response========$response============");

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        otpResponseModelFromJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  static Future<OtpResponseModel> register(
    OtpResponseModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return otpResponseModelFromJson(
      response.body,
    );
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${loginDetails!.token}'
    };

    var url = Uri.http(Config.apiURL, Config.otpAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
