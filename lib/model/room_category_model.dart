// To parse this JSON data, do
//
//     final roomCategoryModel = roomCategoryModelFromJson(jsonString);

import 'dart:convert';

RoomCategoryModel roomCategoryModelFromJson(String str) => RoomCategoryModel.fromJson(json.decode(str));

String roomCategoryModelToJson(RoomCategoryModel data) => json.encode(data.toJson());

class RoomCategoryModel {
    RoomCategoryModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    List<Datum>? data;

    factory RoomCategoryModel.fromJson(Map<String, dynamic> json) => RoomCategoryModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.v,
    });

    String? id;
    String? name;
    int? v;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "__v": v == null ? null : v,
    };
}
