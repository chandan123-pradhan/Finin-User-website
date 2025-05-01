import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';

class SearchBox extends StatelessWidget {
  double? width;
  double? height;
  SearchBox({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      width: width,
      decoration: BoxDecoration(
        color: ColorUtils.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Icon(Icons.search,color: Colors.black45,),
            SizedBox(
              width: 10,
            ),
            headingH10(text: 'Search for jobs.', context: context)
          ],
        ),
      ),
    );
  }
}
