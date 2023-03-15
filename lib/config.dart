import 'package:ghumo_24/services/base_client.dart';

class Config {
  static const String appName = "Ghumo 24";
  static const String apiURL = 'https://ghumo24.booksica.in'; //PROD_URL
  static const loginAPI = "/api/auth/login";
  static const registerAPI = "/api/auth/signup";
  static const otpAPI = "/api/auth/verifyOtp/";
  static const propertyType = "/api/create/property/";
  static const updatePropertyType = "/api/update/property/";
  static const createRoom = "/api/createRoom/";
  static const updateRoom = "/api/updateRoom/";
  static const updateRoomDetail = "/api/updateRoomDetails/";

  static const getCategory = "/api/getAllRoomCategory";
  static const getPropertyByUser = "/api/getAllPropertyByVendor/";
  static const getRoomByPropertId = "/api/getRoomByProperty/";
  static const getdetailByPropertId = "/api/getProperty/";
}
