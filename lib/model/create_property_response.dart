// To parse this JSON data, do
//
//     final createPropertyModel = createPropertyModelFromJson(jsonString);

import 'dart:convert';

CreatePropertyModel createPropertyModelFromJson(String str) => CreatePropertyModel.fromJson(json.decode(str));

String createPropertyModelToJson(CreatePropertyModel data) => json.encode(data.toJson());

class CreatePropertyModel {
    CreatePropertyModel({
        this.success,
        this.message,
        this.property,
    });

    bool? success;
    String? message;
    Property? property;

    factory CreatePropertyModel.fromJson(Map<String, dynamic> json) => CreatePropertyModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        property: json["property"] == null ? null : Property.fromJson(json["property"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "property": property == null ? null : property!.toJson(),
    };
}

class Property {
    Property({
        this.amientities,
        this.photos,
        this.customerStar,
        this.hotelType,
        this.reviewCount,
        this.active,
        this.user,
        this.id,
       
    });

    List<dynamic>? amientities;
    List<dynamic>? photos;
    Map<String, int>? customerStar;
    String? hotelType;
    int? reviewCount;
    bool? active;
    String? user;
    String? id;
   

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        amientities: json["amientities"] == null ? null : List<dynamic>.from(json["amientities"].map((x) => x)),
        photos: json["photos"] == null ? null : List<dynamic>.from(json["photos"].map((x) => x)),
        customerStar: json["customerStar"] == null ? null : Map.from(json["customerStar"]).map((k, v) => MapEntry<String, int>(k, v)),
        hotelType: json["hotelType"] == null ? null : json["hotelType"],
        reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
        active: json["Active"] == null ? null : json["Active"],
        user: json["User"] == null ? null : json["User"],
        id: json["_id"] == null ? null : json["_id"],
       
    );

    Map<String, dynamic> toJson() => {
        "amientities": amientities == null ? null : List<dynamic>.from(amientities!.map((x) => x)),
        "photos": photos == null ? null : List<dynamic>.from(photos!.map((x) => x)),
        "customerStar": customerStar == null ? null : Map.from(customerStar!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "hotelType": hotelType == null ? null : hotelType,
        "reviewCount": reviewCount == null ? null : reviewCount,
        "Active": active == null ? null : active,
        "User": user == null ? null : user,
        "_id": id == null ? null : id,
       
    };
}
