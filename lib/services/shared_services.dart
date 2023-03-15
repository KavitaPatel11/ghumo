import 'dart:convert';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:ghumo_24/model/login_response_model.dart';
import 'package:ghumo_24/model/otp_model.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:get_storage/get_storage.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    return isCacheKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isCacheKeyExist =
        await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return loginResponseModelFromJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(
    OtpResponseModel loginResponse,
  ) async {
    final box = GetStorage();

    print(
        "==========APICacheDBModel============$APICacheDBModel===$loginResponse=============");
    box.write("user_id", loginResponse.user!.id);
    box.write("phone", loginResponse.user!.phoneNumber);
    box.write("image", loginResponse.user!.profilePic);
    box.write("logintoken", loginResponse.token);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}
