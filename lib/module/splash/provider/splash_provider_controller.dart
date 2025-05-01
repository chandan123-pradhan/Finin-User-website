import 'package:flutter/material.dart';
import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/utils/app_routes.dart';

class SplashProviderController extends ChangeNotifier {
  // State variable to track if navigation has occurred
  bool isNavigated = false;

  // Method to trigger navigation (after delay)
  void startSplash(context) async {
    await Future.delayed(const Duration(seconds: 2));
    String value=await SharedPref.getString(key: SharePrefKey.authToken);
    if(value!=''){
      Navigator.pushReplacementNamed(context, AppRoutes.homePage);
    }else{
      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
    }
     
  }
}
