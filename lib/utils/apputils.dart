import 'package:shared_preferences/shared_preferences.dart';

class Apputils {
static Future<String> getTokenAccess()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     final savedaccessToken = prefs.getString("access");
     return savedaccessToken ?? "";
     
  }
   
}