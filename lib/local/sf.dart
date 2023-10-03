
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  // keys
  static String apikey = "APIKEY";
  static String chid = "CHANNELID";
  static String userLoggedInKey = "USERIDKEY";
  static String adminLoggedInKey = "ADMINIDKEY";
  //saving the data to  shared prefrences

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }
  static Future<bool> saveAdminLoggedInStatus(bool isadminLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(adminLoggedInKey, isadminLoggedIn);
  }
  static Future<bool> saveUserapikey(String thisapikey) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(apikey, thisapikey);
  }
  static Future<bool> saveUserchid(String thischid) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(chid, thischid);
  }

  // getting the data from shared prefrences

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
  static Future<bool?> getAdminLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(adminLoggedInKey);
  }
  static Future<String?> getapi() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(apikey);
  }
  static Future<String?> getchid() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(chid);
  }

}