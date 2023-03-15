// To parse this JSON data, do
//
//     final roomDetailModel = roomDetailModelFromJson(jsonString);

import 'dart:convert';

RoomDetailModel roomDetailModelFromJson(String str) => RoomDetailModel.fromJson(json.decode(str));

String roomDetailModelToJson(RoomDetailModel data) => json.encode(data.toJson());

class RoomDetailModel {
    RoomDetailModel({
        this.success,
        this.message,
        this.room,
    });

    bool? success;
    String? message;
    List<Room>? room;

    factory RoomDetailModel.fromJson(Map<String, dynamic> json) => RoomDetailModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        room: json["room"] == null ? null : List<Room>.from(json["room"].map((x) => Room.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "room": room == null ? null : List<dynamic>.from(room!.map((x) => x.toJson())),
    };
}

class Room {
    Room({
        this.id,
        this.roomName,
        this.availableRoom,
        this.bedType,
        this.roomTariff,
        this.discountApplied,
        this.soldOut,
        this.addOn,
        this.maxGuest,
        this.mealOption,
        this.checkInTime,
        this.checkOutTime,
        this.specialFeature,
        this.amientities,
        this.roomPhoto,
        this.user,
        this.property,
        this.roomCategory,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.additionalBed,
        this.additionalMatress,
        this.extraAdult,
        this.extraAdultPrice,
        this.extraChild,
        this.extraChildPrice,
        this.actualPrice,
        this.discountPrice,
        this.soldPrice,
        
    });

    String? id;
    String? roomName;
    int? availableRoom;
    String? bedType;
    int? roomTariff;
    int? discountApplied;
    bool? soldOut;
    String? addOn;
    int? maxGuest;
    String? mealOption;
    String? checkInTime;
    String? checkOutTime;
    List<String>? specialFeature;
    List<String>? amientities;
    List<String>? roomPhoto;
    String? user;
    String? property;
    RoomCategory? roomCategory;
    String? createdAt;
    String? updatedAt;
    int? v;
    bool? additionalBed;
    bool? additionalMatress;
    int? extraAdult;
    int? extraAdultPrice;
    int? extraChild;
    int? extraChildPrice;
    double? actualPrice;
    double? discountPrice;
    int? soldPrice;
    

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["_id"] == null ? null : json["_id"],
        roomName: json["roomName"] == null ? null : json["roomName"],
        availableRoom: json["availableRoom"] == null ? null : json["availableRoom"],
        bedType: json["bedType"] == null ? null : json["bedType"],
        roomTariff: json["roomTariff"] == null ? null : json["roomTariff"],
        discountApplied: json["discountApplied"] == null ? null : json["discountApplied"],
        soldOut: json["soldOut"] == null ? null : json["soldOut"],
        addOn: json["addOn"] == null ? null : json["addOn"],
        maxGuest: json["maxGuest"] == null ? null : json["maxGuest"],
        mealOption: json["mealOption"] == null ? null : json["mealOption"],
        checkInTime: json["checkInTime"] == null ? null : json["checkInTime"],
        checkOutTime: json["checkOutTime"] == null ? null : json["checkOutTime"],
        specialFeature: json["specialFeature"] == null ? null : List<String>.from(json["specialFeature"].map((x) => x)),
        amientities: json["amientities"] == null ? null : List<String>.from(json["amientities"].map((x) => x)),
        roomPhoto: json["roomPhoto"] == null ? null : List<String>.from(json["roomPhoto"].map((x) => x)),
        user: json["User"] == null ? null : json["User"],
        property: json["Property"] == null ? null : json["Property"],
        roomCategory: json["roomCategory"] == null ? null : RoomCategory.fromJson(json["roomCategory"]),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        additionalBed: json["additionalBed"] == null ? null : json["additionalBed"],
        additionalMatress: json["additionalMatress"] == null ? null : json["additionalMatress"],
        extraAdult: json["extraAdult"] == null ? null : json["extraAdult"],
        extraAdultPrice: json["extraAdultPrice"] == null ? null : json["extraAdultPrice"],
        extraChild: json["extraChild"] == null ? null : json["extraChild"],
        extraChildPrice: json["extraChildPrice"] == null ? null : json["extraChildPrice"],
        actualPrice: json["actualPrice"] == null ? null : json["actualPrice"].toDouble(),
        discountPrice: json["discountPrice"] == null ? null : json["discountPrice"].toDouble(),
        soldPrice: json["soldPrice"] == null ? null : json["soldPrice"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "roomName": roomName == null ? null : roomName,
        "availableRoom": availableRoom == null ? null : availableRoom,
        "bedType": bedType == null ? null : bedType,
        "roomTariff": roomTariff == null ? null : roomTariff,
        "discountApplied": discountApplied == null ? null : discountApplied,
        "soldOut": soldOut == null ? null : soldOut,
        "addOn": addOn == null ? null : addOn,
        "maxGuest": maxGuest == null ? null : maxGuest,
        "mealOption": mealOption == null ? null : mealOption,
        "checkInTime": checkInTime == null ? null : checkInTime!,
        "checkOutTime": checkOutTime == null ? null : checkOutTime!,
        "specialFeature": specialFeature == null ? null : List<dynamic>.from(specialFeature!.map((x) => x)),
        "amientities": amientities == null ? null : List<dynamic>.from(amientities!.map((x) => x)),
        "roomPhoto": roomPhoto == null ? null : List<dynamic>.from(roomPhoto!.map((x) => x)),
        "User": user == null ? null : user,
        "Property": property == null ? null : property,
        "roomCategory": roomCategory == null ? null : roomCategory!.toJson(),
        "createdAt": createdAt == null ? null : createdAt!,
        "updatedAt": updatedAt == null ? null : updatedAt!,
        "__v": v == null ? null : v,
        "additionalBed": additionalBed == null ? null : additionalBed,
        "additionalMatress": additionalMatress == null ? null : additionalMatress,
        "extraAdult": extraAdult == null ? null : extraAdult,
        "extraAdultPrice": extraAdultPrice == null ? null : extraAdultPrice,
        "extraChild": extraChild == null ? null : extraChild,
        "extraChildPrice": extraChildPrice == null ? null : extraChildPrice,
        "actualPrice": actualPrice == null ? null : actualPrice,
        "discountPrice": discountPrice == null ? null : discountPrice,
        "soldPrice": soldPrice == null ? null : soldPrice,
    };
}






class RoomCategory {
    RoomCategory({
        this.id,
        this.name,
       
    });

    String? id;
    String? name;
    
    factory RoomCategory.fromJson(Map<String, dynamic> json) => RoomCategory(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
       
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null :id,
        "name": name == null ? null : name,
       
    };
}

