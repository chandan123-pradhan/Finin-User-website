import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';

class BottomWidget {
  // Main bottom button with customizable color and click handler
  static Widget getMainBottom({
    required BuildContext context,
    required String title,
    Color color = ColorUtils.red,
    double? width,
    required VoidCallback onPressed, // Adding onPressed callback
  }) {
    return GestureDetector(
      onTap: onPressed, // Trigger onTap for the button press
      child: Container(
        height: 40,
        width: width ?? displayWeight(context) / 1,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // Transparent button with border and customizable text color
  static Widget getTransparentBottom({
    required BuildContext context,
    required String title,
    double? width,
    Color textColor = ColorUtils.lightBlue, // Customizable text color
    required VoidCallback onPressed, // Adding onPressed callback
  }) {
    return GestureDetector(
      onTap: onPressed, // Trigger onTap for the button press
      child: Container(
        height: 40,
        width: width ?? displayWeight(context) / 1,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: ColorUtils.primaryBlue,
          ),
          color: ColorUtils.white,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: headingH3(
            text: title,
            context: context,
            color: textColor, // Use the passed custom color
          ),
        ),
      ),
    );
  }

  // Back button icon with customizable color and size
  static Widget getBackBottom({
    double size = 30.0,
    Color color = ColorUtils.darkGray, // Customizable color
    VoidCallback? onPressed, // Optional onPressed callback for back button
  }) {
    return GestureDetector(
      onTap: onPressed, // Trigger onTap for the back button press
      child: Icon(
        Icons.navigate_before,
        size: size, // Customizable size
        color: color, // Customizable color
      ),
    );
  }

  // Back button icon with customizable color and size
  static Widget getAddBottom({
    double size = 25.0,
    Color color = ColorUtils.darkGray, // Customizable color
    VoidCallback? onPressed, // Optional onPressed callback for back button
  }) {
    return GestureDetector(
      onTap: onPressed, // Trigger onTap for the back button press
      child: Icon(
        Icons.add_circle_outline_outlined,
        size: size, // Customizable size
        color: color, // Customizable color
      ),
    );
  }

  static Widget getTextBottom(
      {required String title,
      double size = 25.0,
      Color color = ColorUtils.darkGray, // Customizable color
      VoidCallback? onPressed, // Optional onPressed callback for back button
      required BuildContext context}) {
    return GestureDetector(
        onTap: onPressed, // Trigger onTap for the back button press
        child: headingH10(text: title, context: context, isHyperLink: true));
  }
}
