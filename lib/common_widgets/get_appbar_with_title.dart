import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naukri_user/common_widgets/search_box.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';

Widget getAppBarWithTitle({required BuildContext context,required String title}) {
  return SizedBox(
    width: displayWeight(context) / 1,
    child: Padding(
      padding:  EdgeInsets.only(left: 20, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageUtils.getImage(image: ImageUtils.MenuIcon, height: 20),
          
          Container(
            width: displayWeight(context) / 1.38,
            alignment: Alignment.center,
            child: headingH4(text: title, context: context,
           
            ),
          ),
           ImageUtils.getImage(image: ImageUtils.NotificationIcon, height: 18),

        ],
      ),
    ),
  );
}
