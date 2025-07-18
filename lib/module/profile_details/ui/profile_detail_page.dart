import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/common_widgets/get_appbar_with_title.dart';
import 'package:naukri_user/common_widgets/home_appbar.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/models/employment_data_model.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/module/home/ui/widgets/navbar_widget.dart';
import 'package:naukri_user/module/home/ui/widgets/profile_performance_widget.dart';
import 'package:naukri_user/module/splash/provider/splash_provider_controller.dart';
import 'package:naukri_user/services/web_services.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      body: Consumer<DashboardProvider>(builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: ColorUtils.lightGray,
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: displayWeight(context) / 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavbarWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: displayWeight(context) / 8,
                        ),
                        child: _getTopProfileBar(
                            context: context, controller: controller)),
                    SizedBox(
                      height: 20,
                    ),
                    aboutMe(context: context, controller: controller),
                    SizedBox(
                      height: 20,
                    ),
                    _careerPrefrences(context: context, controller: controller),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 14.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildBasicDetailsCard(context),
                              SizedBox(
                                height: 20,
                              ),
                              _buildBasicEmployementCard(context),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  SharedPref.removeData(
                                      key: SharePrefKey.authToken);
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.loginPage);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: 20,
                                      color: ColorUtils.darkGray,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    headingH6(text: 'Logout', context: context)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  buildRow(title, icon, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color ?? Colors.black),
              SizedBox(
                width: 15.0,
              ),
              Text(
                title,
                style: TextStyle(color: color ?? Colors.black),
              )
            ],
          ),
          Icon(Icons.keyboard_arrow_right_rounded, color: color ?? Colors.black)
        ],
      ),
    );
  }

  _buildBasicDetailsCard(context) {
    return Consumer<DashboardProvider>(builder: (context, controller, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: displayWeight(context) / 8,
        ),
        child: Container(
          // height: displayHeight(context)/3.8,
          width: displayWeight(context),

          decoration: BoxDecoration(
            color: ColorUtils.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 1.0,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      headingH5(text: 'Career Details', context: context),
                      // ImageUtils.getImage(
                      //     image: ImageUtils.EditIcon, height: 15)
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headingH10(
                              text: 'Total Experience:  ', context: context),
                          SizedBox(
                            height: 3,
                          ),
                          headingH6(text: '1 years 6 months', context: context)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headingH10(text: 'Contact Number', context: context),
                          SizedBox(
                            height: 3,
                          ),
                          headingH6(
                              text:
                                  '+91 ${controller.getProfileDetailsApiResponse!.data.user.mobileNumber}',
                              context: context)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          headingH10(text: 'Qualification', context: context),
                          SizedBox(
                            height: 3,
                          ),
                          headingH6(
                              text: controller.getProfileDetailsApiResponse!
                                  .data.user.highestQualification,
                              context: context)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      headingH10(text: 'Skills', context: context),
                      SizedBox(
                        height: 3,
                      ),
                      headingH6(
                          text: controller
                              .getProfileDetailsApiResponse!.data.user.skills,
                          context: context)
                    ],
                  ),
                ],
              )),
        ),
      );
    });
  }

  _buildBasicEmployementCard(context) {
    return Consumer<DashboardProvider>(builder: (context, controller, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: displayWeight(context) / 8,
        ),
        child: Container(
          // height: displayHeight(context)/3.8,
          width: displayWeight(context),

          decoration: BoxDecoration(
            color: ColorUtils.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 1.0,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      headingH5(text: 'Employment', context: context),
                      // controller.getProfileDetailsApiResponse!.data.user
                      //                 .employmentHistory.isEmpty?

                      InkWell(
                        child: headingH6(text: "more+", context: context),
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.completeProfilePage);
                        },
                      )
                      //         :
                      //             ImageUtils.getImage(
                      // image: ImageUtils.EditIcon, height: 15)
                    ],
                  ),
                  Column(
                    children: [
                      for (int i = 0;
                          i <
                              controller.getProfileDetailsApiResponse!.data.user
                                  .employmentHistory.length;
                          i++)
                        _companyItem(
                            context: context,
                            employmentHistory: controller
                                .getProfileDetailsApiResponse!
                                .data
                                .user
                                .employmentHistory[i])
                    ],
                  )
                ],
              )),
        ),
      );
    });
  }

  _companyItem(
      {required BuildContext context,
      required EmploymentHistory employmentHistory}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: ColorUtils.darkGray),
                    image: DecorationImage(
                        image: AssetImage(ImageUtils.CompanyLogo),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingH5(
                        text: employmentHistory.designation,
                        context: context,
                        color: ColorUtils.darkGray),
                    headingH6(
                        text: employmentHistory.employerName,
                        context: context,
                        color: ColorUtils.darkGray),
                    headingH10(
                        text:
                            '${employmentHistory.startDate}   -   ${employmentHistory.endDate}',
                        context: context,
                        color: ColorUtils.darkGray)
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 0.2,
            width: displayWeight(context),
            color: ColorUtils.darkGray,
          )
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to logout?"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                SharedPref.removeData(key: SharePrefKey.authToken);
                Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
              },
              child: Text(
                "Yes, Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getTopProfileBar(
      {required BuildContext context, required DashboardProvider controller}) {
    return Container(
      height: displayHeight(context) / 3.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: ColorUtils.white),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: displayHeight(context) / 6,
              width: displayHeight(context) / 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: ColorUtils.green),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(WebServicesConstant.baseUrl +
                              controller.getProfileDetailsApiResponse!.data.user
                                  .profileImageUrl),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // width: displayWeight(context)/8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          headingH4(
                            text: controller.getProfileDetailsApiResponse!.data
                                .user.fullName,
                            context: context,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.mode_edit_outline_outlined,
                            size: 20,
                            color: ColorUtils.blackColor,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      controller.getProfileDetailsApiResponse!.data.user
                              .employmentHistory.isEmpty
                          ? SizedBox()
                          : headingH5(
                              text:
                                  "${controller.getProfileDetailsApiResponse!.data.user.employmentHistory.last.designation} @ ${controller.getProfileDetailsApiResponse!.data.user.employmentHistory.last.employerName}",
                              context: context,
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      headingH6(
                          text: "Skills: "
                              "${controller.getProfileDetailsApiResponse!.data.user.skills}",
                          context: context,
                          color: ColorUtils.blackColor),
                      SizedBox(
                        height: 10,
                      ),
                      headingH6(
                          text: "Locations: "
                              "${controller.getProfileDetailsApiResponse!.data.user.prefferedLocation}",
                          context: context,
                          color: ColorUtils.blackColor),
                      SizedBox(
                        height: 10,
                      ),
                      headingH6(
                          text: "Contact No.: "
                              "${controller.getProfileDetailsApiResponse!.data.user.mobileNumber}",
                          context: context,
                          color: ColorUtils.blackColor),
                    ],
                  ),
                ),
                SizedBox(
                    width: displayWeight(context) / 4,
                    child: ProfilePerformanceWidget())
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget aboutMe(
      {required BuildContext context, required DashboardProvider controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: displayWeight(context) / 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: ColorUtils.white),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    headingH5(text: 'About me', context: context),
                    // ImageUtils.getImage(
                    //     image: ImageUtils.EditIcon,
                    //     height: 15)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: headingH6(
                      text: controller
                          .getProfileDetailsApiResponse!.data.user.description,
                      context: context,
                      isSelectable: true,
                      color: ColorUtils.blackColor),
                ),
              ],
            )),
      ),
    );
  }

  Widget _careerPrefrences(
      {required BuildContext context, required DashboardProvider controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: displayWeight(context) / 8,
      ),
      child: Container(
        // height: displayHeight(context)/3.8,
        width: displayWeight(context),

        decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 1.0,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    headingH5(text: 'Career preferences', context: context),
                    // ImageUtils.getImage(
                    //     image: ImageUtils.EditIcon,
                    //     height: 15)
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    headingH10(text: 'Preferred Location', context: context),
                    SizedBox(
                      height: 3,
                    ),
                    headingH6(
                        text: controller.getProfileDetailsApiResponse!.data.user
                            .prefferedLocation,
                        context: context)
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        headingH10(
                            text: 'Preferred annual salary', context: context),
                        SizedBox(
                          height: 3,
                        ),
                        headingH6(
                            text:
                                '₹ ${controller.getProfileDetailsApiResponse!.data.user.prefferedSallary}',
                            context: context)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        headingH10(text: 'Employment type', context: context),
                        SizedBox(
                          height: 3,
                        ),
                        headingH6(
                            text: controller.getProfileDetailsApiResponse!.data
                                .user.employmentType,
                            context: context)
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        headingH10(text: 'Job type', context: context),
                        SizedBox(
                          height: 3,
                        ),
                        headingH6(
                            text: controller.getProfileDetailsApiResponse!.data
                                .user.employmentType,
                            context: context)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        headingH10(text: 'Preferred shift', context: context),
                        SizedBox(
                          height: 3,
                        ),
                        headingH6(
                            text:
                                '${controller.getProfileDetailsApiResponse!.data.user.prefferedShift}           ',
                            context: context)
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
