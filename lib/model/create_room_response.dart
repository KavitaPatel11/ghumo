// To parse this JSON data, do
//
//     final createRoomResponse = createRoomResponseFromJson(jsonString);

import 'dart:convert';

CreateRoomResponse createRoomResponseFromJson(String str) => CreateRoomResponse.fromJson(json.decode(str));

String createRoomResponseToJson(CreateRoomResponse data) => json.encode(data.toJson());

class CreateRoomResponse {
    CreateRoomResponse({
        this.success,
        this.message,
        this.room,
    });

    bool? success;
    String? message;
    Room? room;

    factory CreateRoomResponse.fromJson(Map<String, dynamic> json) => CreateRoomResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        room: json["room"] == null ? null : Room.fromJson(json["room"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "room": room == null ? null : room!.toJson(),
    };
}

class Room {
    Room({
        this.roomName,
        this.availableRoom,
        this.bedType,
        this.roomTariff,
        this.discountApplied,
        this.soldPrice,
        this.discountPrice,
        this.actualPrice,
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
        this.id,
        this.roomCategory,
       
    });

    String? roomName;
    int? availableRoom;
    String? bedType;
    int? roomTariff;
    int? discountApplied;
    int? soldPrice;
    int? discountPrice;
    int? actualPrice;
    bool? soldOut;
    String? addOn;
    int? maxGuest;
    String? mealOption;
    String? checkInTime;
    String? checkOutTime;
    List<dynamic>? specialFeature;
    List<dynamic>? amientities;
    List<dynamic>? roomPhoto;
    String? user;
    String? property;
    String? id;
    String? roomCategory;
   

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomName: json["roomName"] == null ? null : json["roomName"],
        availableRoom: json["availableRoom"] == null ? null : json["availableRoom"],
        bedType: json["bedType"] == null ? null : json["bedType"],
        roomTariff: json["roomTariff"] == null ? null : json["roomTariff"],
        discountApplied: json["discountApplied"] == null ? null : json["discountApplied"],
        soldPrice: json["soldPrice"] == null ? null : json["soldPrice"],
        discountPrice: json["discountPrice"] == null ? null : json["discountPrice"],
        actualPrice: json["actualPrice"] == null ? null : json["actualPrice"],
        soldOut: json["soldOut"] == null ? null : json["soldOut"],
        addOn: json["addOn"] == null ? null : json["addOn"],
        maxGuest: json["maxGuest"] == null ? null : json["maxGuest"],
        mealOption: json["mealOption"] == null ? null : json["mealOption"],
        checkInTime: json["checkInTime"] == null ? null : json["checkInTime"],
        checkOutTime: json["checkOutTime"] == null ? null : json["checkOutTime"],
        specialFeature: json["specialFeature"] == null ? null : List<dynamic>.from(json["specialFeature"].map((x) => x)),
        amientities: json["amientities"] == null ? null : List<dynamic>.from(json["amientities"].map((x) => x)),
        roomPhoto: json["roomPhoto"] == null ? null : List<dynamic>.from(json["roomPhoto"].map((x) => x)),
        user: json["User"] == null ? null : json["User"],
        property: json["Property"] == null ? null : json["Property"],
        id: json["_id"] == null ? null : json["_id"],
        roomCategory: json["roomCategory"] == null ? null : json["roomCategory"],
       
    );

    Map<String, dynamic> toJson() => {
        "roomName": roomName == null ? null : roomName,
        "availableRoom": availableRoom == null ? null : availableRoom,
        "bedType": bedType == null ? null : bedType,
        "roomTariff": roomTariff == null ? null : roomTariff,
        "discountApplied": discountApplied == null ? null : discountApplied,
        "soldPrice": soldPrice == null ? null : soldPrice,
        "discountPrice": discountPrice == null ? null : discountPrice,
        "actualPrice": actualPrice == null ? null : actualPrice,
        "soldOut": soldOut == null ? null : soldOut,
        "addOn": addOn == null ? null : addOn,
        "maxGuest": maxGuest == null ? null : maxGuest,
        "mealOption": mealOption == null ? null : mealOption,
        "checkInTime": checkInTime == null ? null : checkInTime,
        "checkOutTime": checkOutTime == null ? null : checkOutTime,
        "specialFeature": specialFeature == null ? null : List<dynamic>.from(specialFeature!.map((x) => x)),
        "amientities": amientities == null ? null : List<dynamic>.from(amientities!.map((x) => x)),
        "roomPhoto": roomPhoto == null ? null : List<dynamic>.from(roomPhoto!.map((x) => x)),
        "User": user == null ? null : user,
        "Property": property == null ? null : property,
        "_id": id == null ? null : id,
        "roomCategory": roomCategory == null ? null : roomCategory,
       
    };
}
