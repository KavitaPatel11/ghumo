// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponseModel({
        this.sucess,
        this.message,
        this.user,
    });

    bool? sucess;
    String? message;
    User? user;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        sucess: json["sucess"] == null ? null : json["sucess"],
        message: json["message"] == null ? null : json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "sucess": sucess == null ? null : sucess,
        "message": message == null ? null : message,
        "user": user == null ? null : user!.toJson(),
    };
}

class User {
    User({
        this.id,
        this.phoneNumber,
       
    });

    String? id;
    int? phoneNumber;
   
    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
       
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
       
    };
}
