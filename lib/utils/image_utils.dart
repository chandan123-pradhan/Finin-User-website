import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ImageUtils{
  static const String AppLogoImage='assets/icons/app_logo.png';
  static const String SearchIcon='assets/icons/search.png';
  static const String MenuIcon='assets/icons/menu.png';
  static const String HomeIcon='assets/icons/home.png';
  static const String SelectedHome='assets/icons/selected_home.png';
  static const String Applied='assets/icons/apply.png';
  static const String SelectedApplies='assets/icons/selected_applied.png';
  static const String Profile='assets/icons/profile.png';
  static const String SelectedProfile='assets/icons/selected_profile.png';
  static const String NotificationIcon='assets/icons/notification.png';
  static const String SelectedNotificationIcon='assets/icons/selected_notification.png';
  static const String PaytmLogo='assets/icons/paytm_logo.png';
  static const String CompanyLogo='assets/icons/office.png';
  static const String StartLogo='assets/icons/star.png';
  static const String LocationLogo='assets/icons/location.png';
  static const String Experience='assets/icons/experience.png';
  static const String Status='assets/icons/status.png';
  static const String Call='assets/icons/call.png';
  static const String MyPic='assets/icons/my_img.jpeg';
  static const String EditIcon='assets/icons/edit.png';
  static const String HelloIcon='assets/icons/hello.png';
  static const String AddIcon='assets/icons/add.png';
  static const String SelectedAdd='assets/icons/addition.png';
  static const String WorkerIcon='assets/icons/worker.png';
  static const String ViewIcon='assets/icons/view.png';
  static const String Calender='assets/icons/calendar.png';
  static const String ProfileIcon='assets/icons/profile_pic.png';
  static const String authBgImage='assets/images/auth_bg.jpg';
  static const String firstBanner='assets/images/first_banner.png';


  ///----------------------Lottie------------------------------------
  static const String SubmitLottie='assets/lotties/confirmation.json';
  static const String loadingLottie='assets/lotties/loading.json';








  static Widget getImage({required String image,double? height, double? width}){
      return Image.asset(image,
      height: height,
      width: width,
      );
  }


static Widget getLottie({required String file,double? height,double? width}){
  return Lottie.asset(file,
  width: width,
  height: height
  );
}



}