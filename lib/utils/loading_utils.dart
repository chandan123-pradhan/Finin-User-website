import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/loading_widget.dart';

class LoadingUtils {
  static  showLoadingDialog(BuildContext context) {
    return showDialog(
      
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      context: context,
      builder: (BuildContext context) {
        return const LoadingWidget();
      },
    );
  }

  // Method to dismiss the dialog
  static void dismissLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}