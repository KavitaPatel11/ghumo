// To parse this JSON data, do
//
//     final pinCodeModel = pinCodeModelFromJson(jsonString);

import 'dart:convert';

PinCodeModel pinCodeModelFromJson(String str) => PinCodeModel.fromJson(json.decode(str));

String pinCodeModelToJson(PinCodeModel data) => json.encode(data.toJson());

class PinCodeModel {
    PinCodeModel({
        this.success,
        this.msg,
        this.data,
    });

    bool? success;
    String? msg;
    Data? data;

    factory PinCodeModel.fromJson(Map<String, dynamic> json) => PinCodeModel(
        success: json["success"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
    };
}

class Data {
    Data({
        this.pincode,
        this.city,
        this.state,
        this.country,
    });

    String? pincode;
    String? city;
    String? state;
    String? country;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        pincode: json["pincode"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "pincode": pincode,
        "city": city,
        "state": state,
        "country": country,
    };
}
