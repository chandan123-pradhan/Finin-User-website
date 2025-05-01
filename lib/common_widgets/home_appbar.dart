import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/search_box.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

Widget getHomeAppBar(context) {
  return SizedBox(
      width: displayWeight(context) / 1,
      child: Consumer<DashboardProvider>(builder: (context, controller, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getGreeting(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                            fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: headingH4(
                            text:
                                controller.getProfileDetailsApiResponse == null
                                    ? ''
                                    : controller.getProfileDetailsApiResponse!
                                        .data.user.fullName,
                            context: context),
                      )
                    ],
                  ),
                  controller.getProfileDetailsApiResponse == null
                      ? SizedBox()
                      : Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: ColorUtils.lightGray,
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      WebServicesConstant.baseUrl +
                                          controller
                                              .getProfileDetailsApiResponse!
                                              .data
                                              .user
                                              .profileImageUrl),
                                  fit: BoxFit.fill)),
                        ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.finJobsPage);
                },
                child: SearchBox(),
              ),
            ],
          ),
        );
      }));
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return "Good Morning,";
  } else if (hour < 17) {
    return "Good Afternoon,";
  } else {
    return "Good Evening,";
  }
}
