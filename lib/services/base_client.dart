import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ghumo_24/services/error_model.dart';

import 'package:http/http.dart' as http;

import 'app_exceptions.dart';

var box2 = GetStorage();

class BaseClient {
  static var box = GetStorage();
  static const int timeOutDuration = 20;
  Future<dynamic> get(bool isSecure, String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = isSecure
          ? await http.get(
              uri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${box2.read("logintoken")}'
              },
            ).timeout(const Duration(seconds: timeOutDuration))
          : await http.get(
              uri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ).timeout(const Duration(seconds: timeOutDuration));

      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(
      bool isSecure, String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload =json.encode(payloadObj);

    print("=====payload===============$payload==============");
    

     print(baseUrl);
    try {
      final response = isSecure
          ? await http
              .post(uri,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization': 'Bearer ${box2.read("logintoken")}'
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration))
          : await http
              .post(uri,
                  headers: <String, String>{
                    // 'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration));
      print(response.body);
      print("==========response.statusCode=====post method===========${response.statusCode}=======================");
      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> put(
      bool isSecure, String baseUrl, String api, dynamic payloadObj) async {
    print("===================put rerqest=====================");

    print(
        "====uri=======$baseUrl=$api====isSecure==$isSecure=put rerqest=========payload========$payloadObj====");
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      print(
          "====uri=======$uri=====isSecure==$isSecure=put rerqest=========payload========$payload====");
      final response = isSecure
          ? await http
              .put(uri,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization': 'Bearer ${box2.read("logintoken")}'
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration))
          : await http
              .put(uri,
                  headers: <String, String>{
                    // 'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration));
      print(response.body);
      print(response.statusCode);
      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;

      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;

      case 400:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 401:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 403:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 422:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 500:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
    }
  }
}
