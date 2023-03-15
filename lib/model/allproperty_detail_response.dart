// To parse this JSON data, do
//
//     final allPropertyDetailModel = allPropertyDetailModelFromJson(jsonString?);

import 'dart:convert';

AllPropertyDetailModel allPropertyDetailModelFromJson(String str) => AllPropertyDetailModel.fromJson(json.decode(str));

String? allPropertyDetailModelToJson(AllPropertyDetailModel data) => json.encode(data.toJson());

class AllPropertyDetailModel {
    AllPropertyDetailModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    List<Datum>? data;

    factory AllPropertyDetailModel.fromJson(Map<String?, dynamic> json) => AllPropertyDetailModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.customerStar,
      
        this.guestAllow,
        this.acceptIdentityProofs,
        this.propertyRestriction,
        this.id,
        this.amientities,
        this.photos,
        
        this.reviewCount,
        this.active,
        this.user,
       
        this.hotelContact,
        this.hotelEmail,
        this.otherDetails,
        this.personalContact,
        this.personalEmail,
        this.nearFamousPlace,
        this.totalFloor,
        this.totalRooms,
        this.aadharCardImage1,
        this.aadharCardImage2,
        this.gstNumber,
        this.panCardImage,
        this.address,
        this.area,
        this.city,
        this.hoteStarted,
        this.hotelStar,
        this.landmark,
        this.latitude,
        this.longitude,
        this.name,
       
        this.customerRating,
    });

    Map<String?, int>? customerStar;
   
    GuestAllow? guestAllow;
    AcceptIdentityProofs? acceptIdentityProofs;
    PropertyRestriction? propertyRestriction;
    String? id;
    List<String?>? amientities;
    List<String?>? photos;
   
    int? reviewCount;
    bool? active;
    String? user;
   
    int? v;
    int? hotelContact;
    String? hotelEmail;
    String? otherDetails;
    int? personalContact;
    String? personalEmail;
    String? nearFamousPlace;
    int? totalFloor;
    int? totalRooms;
    String? aadharCardImage1;
    String? aadharCardImage2;
    String? gstNumber;
    String? panCardImage;
    String? address;
    String? area;
    String? city;
    int? hoteStarted;
    int? hotelStar;
    String? landmark;
    double? latitude;
    double? longitude;
    String? name;
   
  
    double? customerRating;

    factory Datum.fromJson(Map<String?, dynamic> json) => Datum(
        customerStar: json["customerStar"] == null ? null : Map.from(json["customerStar"]).map((k, v) => MapEntry<String?, int>(k, v)),
       
        guestAllow: json["guestAllow"] == null ? null : GuestAllow.fromJson(json["guestAllow"]),
        acceptIdentityProofs: json["AcceptIdentityProofs"] == null ? null : AcceptIdentityProofs.fromJson(json["AcceptIdentityProofs"]),
        propertyRestriction: json["propertyRestriction"] == null ? null : PropertyRestriction.fromJson(json["propertyRestriction"]),
        id: json["_id"] == null ? null : json["_id"],
        amientities: json["amientities"] == null ? null : List<String?>.from(json["amientities"].map((x) => x)),
       
        reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
        active: json["Active"] == null ? null : json["Active"],
        user: json["User"] == null ? null : json["User"],
       
        hotelContact: json["hotelContact"] == null ? null : json["hotelContact"],
        hotelEmail: json["hotelEmail"] == null ? null : json["hotelEmail"],
        otherDetails: json["otherDetails"] == null ? null : json["otherDetails"],
        personalContact: json["personalContact"] == null ? null : json["personalContact"],
        personalEmail: json["personalEmail"] == null ? null : json["personalEmail"],
        nearFamousPlace: json["nearFamousPlace"] == null ? null : json["nearFamousPlace"],
        totalFloor: json["totalFloor"] == null ? null : json["totalFloor"],
        totalRooms: json["totalRooms"] == null ? null : json["totalRooms"],
        aadharCardImage1: json["aadharCardImage1"] == null ? null : json["aadharCardImage1"],
        aadharCardImage2: json["aadharCardImage2"] == null ? null : json["aadharCardImage2"],
        gstNumber: json["gstNumber"] == null ? null : json["gstNumber"],
        panCardImage: json["panCardImage"] == null ? null : json["panCardImage"],
        address: json["address"] == null ? null : json["address"],
        area: json["area"] == null ? null : json["area"],
        city: json["city"] == null ? null : json["city"],
        hoteStarted: json["hoteStarted"] == null ? null : json["hoteStarted"],
        hotelStar: json["hotelStar"] == null ? null : json["hotelStar"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        name: json["name"] == null ? null : json["name"],
       
        customerRating: json["customerRating"] == null ? null : json["customerRating"].toDouble(),
    );

    Map<String?, dynamic> toJson() => {
        "customerStar": customerStar == null ? null : Map.from(customerStar!).map((k, v) => MapEntry<String?, dynamic>(k, v)),
        
        "guestAllow": guestAllow == null ? null : guestAllow!.toJson(),
        "AcceptIdentityProofs": acceptIdentityProofs == null ? null : acceptIdentityProofs!.toJson(),
        "propertyRestriction": propertyRestriction == null ? null : propertyRestriction!.toJson(),
        "_id": id == null ? null : id,
        "amientities": amientities == null ? null : List<dynamic>.from(amientities!.map((x) => x)),
        "photos": photos == null ? null : List<dynamic>.from(photos!.map((x) => x)),
       
        "reviewCount": reviewCount == null ? null : reviewCount,
        "Active": active == null ? null : active,
        "User": user == null ? null : user,
       
        "hotelContact": hotelContact == null ? null : hotelContact,
        "hotelEmail": hotelEmail == null ? null : hotelEmail,
        "otherDetails": otherDetails == null ? null : otherDetails,
        "personalContact": personalContact == null ? null : personalContact,
        "personalEmail": personalEmail == null ? null : personalEmail,
        "nearFamousPlace": nearFamousPlace == null ? null : nearFamousPlace,
        "totalFloor": totalFloor == null ? null : totalFloor,
        "totalRooms": totalRooms == null ? null : totalRooms,
        "aadharCardImage1": aadharCardImage1 == null ? null : aadharCardImage1,
        "aadharCardImage2": aadharCardImage2 == null ? null : aadharCardImage2,
        "gstNumber": gstNumber == null ? null : gstNumber,
        "panCardImage": panCardImage == null ? null : panCardImage,
        "address": address == null ? null : address,
        "area": area == null ? null : area,
        "city": city == null ? null : city,
        "hoteStarted": hoteStarted == null ? null : hoteStarted,
        "hotelStar": hotelStar == null ? null : hotelStar,
        "landmark": landmark == null ? null : landmark,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "name": name == null ? null : name,
       
        "customerRating": customerRating == null ? null : customerRating,
    };
}

class AcceptIdentityProofs {
    AcceptIdentityProofs({
        this.passport,
        this.aadharCard,
        this.drivingLicense,
        this.govermentId,
    });

    bool? passport;
    bool? aadharCard;
    bool? drivingLicense;
    bool? govermentId;

    factory AcceptIdentityProofs.fromJson(Map<String?, dynamic> json) => AcceptIdentityProofs(
        passport: json["passport"] == null ? null : json["passport"],
        aadharCard: json["aadharCard"] == null ? null : json["aadharCard"],
        drivingLicense: json["drivingLicense"] == null ? null : json["drivingLicense"],
        govermentId: json["govermentId"] == null ? null : json["govermentId"],
    );

    Map<String?, dynamic> toJson() => {
        "passport": passport == null ? null : passport,
        "aadharCard": aadharCard == null ? null : aadharCard,
        "drivingLicense": drivingLicense == null ? null : drivingLicense,
        "govermentId": govermentId == null ? null : govermentId,
    };
}



class GuestAllow {
    GuestAllow({
        this.unmarriedCouples,
        this.bachelors,
        this.guestBelow18,
    });

    bool? unmarriedCouples;
    bool? bachelors;
    bool? guestBelow18;

    factory GuestAllow.fromJson(Map<String?, dynamic> json) => GuestAllow(
        unmarriedCouples: json["unmarriedCouples"] == null ? null : json["unmarriedCouples"],
        bachelors: json["Bachelors"] == null ? null : json["Bachelors"],
        guestBelow18: json["guestBelow18"] == null ? null : json["guestBelow18"],
    );

    Map<String?, dynamic> toJson() => {
        "unmarriedCouples": unmarriedCouples == null ? null : unmarriedCouples,
        "Bachelors": bachelors == null ? null : bachelors,
        "guestBelow18": guestBelow18 == null ? null : guestBelow18,
    };
}



class PropertyRestriction {
    PropertyRestriction({
        this.smokeAllow,
        this.creaditCardAccept,
    });

    bool? smokeAllow;
    bool? creaditCardAccept;

    factory PropertyRestriction.fromJson(Map<String?, dynamic> json) => PropertyRestriction(
        smokeAllow: json["smokeAllow"] == null ? null : json["smokeAllow"],
        creaditCardAccept: json["creaditCardAccept"] == null ? null : json["creaditCardAccept"],
    );

    Map<String?, dynamic> toJson() => {
        "smokeAllow": smokeAllow == null ? null : smokeAllow,
        "creaditCardAccept": creaditCardAccept == null ? null : creaditCardAccept,
    };
}



