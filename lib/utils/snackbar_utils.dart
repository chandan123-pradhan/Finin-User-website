import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/utils/color_utils.dart';

class SnackbarUtils {
  static void showSuccessMsg(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: headingH10(text: message, context: context,
        color: ColorUtils.white
        ),
        backgroundColor: ColorUtils.green,
        ));
  }
   static void showErrorMsg(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: headingH10(text: message, context: context,
        color: ColorUtils.white
        ),
        backgroundColor: ColorUtils.red,
        ));
  }
}
