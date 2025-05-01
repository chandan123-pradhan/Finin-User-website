import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/text_field_widgets.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, controller, child) {
      return Container(
        height: displayHeight(context) / 10,
        color: ColorUtils.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displayWeight(context) / 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: displayWeight(context) / 5.5,
                child: Row(
                  children: [
                    ImageUtils.getImage(
                        image: ImageUtils.AppLogoImage, height: 50, width: 50),
                    SizedBox(
                      width: 20,
                    ),
                    headingH2(
                      text: 'FindIn.com',
                      context: context,
                    ),
                  ],
                ),
              ),
              Container(
                width: displayWeight(context) / 3,
                child: TextFieldWidgets.getTextField(
                  context: context,
                  controller: TextEditingController(),
                  onCompleteEditing: () {},
                  title: 'Search job here...',
                ),
              ),
              SizedBox(
                width: displayWeight(context) / 5.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ImageUtils.getImage(
                        image: ImageUtils.NotificationIcon,
                        height: 25,
                        width: 25),
                    SizedBox(
                      width: 15,
                    ),
                    controller.getProfileDetailsApiResponse == null
                        ? SizedBox()
                        : Container(
                            height: 40,
                            width: 40,
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
              )
            ],
          ),
        ),
      );
    });
  }
}
