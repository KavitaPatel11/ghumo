// To parse this JSON data, do
//
//     final otpResponseModel = otpResponseModelFromJson(jsonString);

import 'dart:convert';

OtpResponseModel otpResponseModelFromJson(String str) => OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) => json.encode(data.toJson());

class OtpResponseModel {
    OtpResponseModel({
        this.success,
        this.message,
        this.token,
        this.user,
    });

    bool? success;
    String? message;
    String? token;
    User? user;

    factory OtpResponseModel.fromJson(Map<String, dynamic> json) => OtpResponseModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "token": token == null ? null : token,
        "user": user == null ? null : user!.toJson(),
    };
}

class User {
    User({
        this.id,
        this.phoneNumber,
        this.profilePic,
        this.disabled,
        this.otp,
        this.roles,
       
    });

    String? id;
    int? phoneNumber;
    String? profilePic;
    bool? disabled;
    int? otp;
    List<String>? roles;
   

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        profilePic: json["profilePic"] == null ? null : json["profilePic"],
        disabled: json["disabled"] == null ? null : json["disabled"],
        otp: json["otp"] == null ? null : json["otp"],
        roles: json["roles"] == null ? null : List<String>.from(json["roles"].map((x) => x)),
        
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "profilePic": profilePic == null ? null : profilePic,
        "disabled": disabled == null ? null : disabled,
        "otp": otp == null ? null : otp,
        "roles": roles == null ? null : List<dynamic>.from(roles!.map((x) => x)),
       
    };
}
