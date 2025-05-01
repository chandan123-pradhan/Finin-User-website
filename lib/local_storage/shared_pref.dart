import 'package:logger/logger.dart';
import 'package:naukri_user/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> saveString(
      {required String key, required String value}) async {
    try {
    

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(key, value);
    } catch (e) {
       LoggerMsg.showErrorLog(msg: "Couldn't shave data $key please try again");
    }
  }

  static Future<String>getString({required String key})async{
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String value=sharedPreferences.getString(key)??'';
      return value;
  }
  static Future<void>removeData({required String key})async{
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove(key);
      
  }
}
