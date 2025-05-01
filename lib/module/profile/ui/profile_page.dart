import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naukri_user/common_widgets/get_appbar_with_title.dart';
import 'package:naukri_user/common_widgets/home_appbar.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/local_storage/share_pref_key.dart';
import 'package:naukri_user/local_storage/shared_pref.dart';
import 'package:naukri_user/models/employment_data_model.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/module/splash/provider/splash_provider_controller.dart';
import 'package:naukri_user/services/web_services.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.lightGray,
      body: Consumer<DashboardProvider>(builder: (context, controller, child) {
        return SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: displayWeight(context) / 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: headingH3(
                                  text: controller.getProfileDetailsApiResponse!
                                      .data.user.fullName,
                                  context: context),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: headingH10(
                                  text: controller.getProfileDetailsApiResponse!
                                      .data.user.emailId,
                                  context: context),
                            )
                          ],
                        ),
                        Container(
                          height: 60,
                          width: 60,
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
                  ),
                  Divider(
                    height: 2,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.profileDetailPage);
                      },
                      child: buildRow("Profile details", Icons.person)),
                  Divider(
                    height: 2,
                  ),
                  buildRow("Settings", Icons.settings),
                  Divider(
                    height: 2,
                  ),
                  buildRow(
                      "Notification preference", Icons.notifications_active),
                  Divider(
                    height: 2,
                  ),
                  buildRow("Privacy Policy", Icons.privacy_tip),
                  Divider(
                    height: 2,
                  ),
                  buildRow("Terms & Conditions", Icons.rule),
                  Divider(
                    height: 2,
                  ),
                  buildRow("Ask for Help", Icons.help),
                  Divider(
                    height: 2,
                  ),
                  GestureDetector(
                      onTap: () {
                        _showLDeleteMyAccountDialog(context);
                      },
                      child: buildRow("Delete My Account", Icons.delete,
                          color: Colors.red)),
                  Divider(
                    height: 2,
                  ),
                  GestureDetector(
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                      child:
                          buildRow("Log Out", Icons.logout, color: Colors.red)),
                  Divider(
                    height: 2,
                  ),

                  // Expanded(
                  //   // Wrap Expanded around the ListView
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 0.0),
                  //     child: SingleChildScrollView(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             const SizedBox(
                  //               height: 20,
                  //             ),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(horizontal: 10.0),
                  //               child: Row(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Container(
                  //                     height: 70,
                  //                     width: 70,
                  //                     child: Stack(
                  //                       children: [
                  //                         Container(
                  //                           height: 60,
                  //                           width: 60,
                  //                           decoration: BoxDecoration(
                  //                               shape: BoxShape.circle,
                  //                               border: Border.all(
                  //                                 width: 1,
                  //                                 color: ColorUtils.lightGray,
                  //                               ),
                  //                               image: DecorationImage(
                  //                                   image: NetworkImage(
                  //                                       WebServicesConstant
                  //                                               .baseUrl +
                  //                                           controller
                  //                                               .getProfileDetailsApiResponse
                  //                                               .data
                  //                                               .user
                  //                                               .profileImageUrl),
                  //                                   fit: BoxFit.fill)),
                  //                         ),
                  //                         Positioned(
                  //                             bottom: 10,
                  //                             right: 5,
                  //                             child: ImageUtils.getImage(
                  //                                 image: ImageUtils.EditIcon,
                  //                                 height: 20))
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(top: 10.0),
                  //                         child: headingH5(
                  //                             text: controller
                  //                                 .getProfileDetailsApiResponse
                  //                                 .data
                  //                                 .user
                  //                                 .fullName,
                  //                             context: context),
                  //                       ),
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.only(top: 5.0),
                  //                         child: headingH6(
                  //                             text: controller
                  //                                 .getProfileDetailsApiResponse
                  //                                 .data
                  //                                 .user
                  //                                 .emailId,
                  //                             context: context,
                  //                             color: ColorUtils.darkGray),
                  //                       ),
                  //                       SizedBox(
                  //                         height: 8,
                  //                       ),
                  //                       Container(
                  //                         width: displayWeight(context) / 1.5,
                  //                         height: 1,
                  //                         color: ColorUtils.lightGrey,
                  //                       )
                  //                     ],
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 10.0, vertical: 0),
                  //               child: Container(
                  //                 // height: displayHeight(context)/3.8,
                  //                 width: displayWeight(context),
                  //
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(10.0),
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Colors.grey.withOpacity(0.1),
                  //                       blurRadius: 1.0,
                  //                       spreadRadius: 0.5,
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 child: Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 15, vertical: 15),
                  //                     child: Column(
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             headingH5(
                  //                                 text: 'About me',
                  //                                 context: context),
                  //                             ImageUtils.getImage(
                  //                                 image: ImageUtils.EditIcon,
                  //                                 height: 15)
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: 10,
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.symmetric(
                  //                               horizontal: 0, vertical: 0),
                  //                           child: headingH6(
                  //                               text: controller
                  //                                   .getProfileDetailsApiResponse
                  //                                   .data
                  //                                   .user
                  //                                   .description,
                  //                               context: context,
                  //                               isSelectable: true,
                  //                               color: ColorUtils.blackColor),
                  //                         ),
                  //                       ],
                  //                     )),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 10.0, vertical: 20),
                  //               child: Container(
                  //                 // height: displayHeight(context)/3.8,
                  //                 width: displayWeight(context),
                  //
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(10.0),
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Colors.grey.withOpacity(0.1),
                  //                       blurRadius: 1.0,
                  //                       spreadRadius: 0.5,
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 child: Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 15, vertical: 15),
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             headingH5(
                  //                                 text: 'Career preferences',
                  //                                 context: context),
                  //                             ImageUtils.getImage(
                  //                                 image: ImageUtils.EditIcon,
                  //                                 height: 15)
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: 15,
                  //                         ),
                  //                         Column(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.start,
                  //                           children: [
                  //                             headingH10(
                  //                                 text: 'Preferred Location',
                  //                                 context: context),
                  //                             SizedBox(
                  //                               height: 3,
                  //                             ),
                  //                             headingH6(
                  //                                 text: controller
                  //                                     .getProfileDetailsApiResponse
                  //                                     .data
                  //                                     .user
                  //                                     .prefferedLocation,
                  //                                 context: context)
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: 15,
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               children: [
                  //                                 headingH10(
                  //                                     text:
                  //                                         'Preferred annual salary',
                  //                                     context: context),
                  //                                 SizedBox(
                  //                                   height: 3,
                  //                                 ),
                  //                                 headingH6(
                  //                                     text:
                  //                                         '₹ ${controller.getProfileDetailsApiResponse.data.user.prefferedSallary}',
                  //                                     context: context)
                  //                               ],
                  //                             ),
                  //                             Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               children: [
                  //                                 headingH10(
                  //                                     text: 'Employment type',
                  //                                     context: context),
                  //                                 SizedBox(
                  //                                   height: 3,
                  //                                 ),
                  //                                 headingH6(
                  //                                     text: controller
                  //                                         .getProfileDetailsApiResponse
                  //                                         .data
                  //                                         .user
                  //                                         .employmentType,
                  //                                     context: context)
                  //                               ],
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: 15,
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               children: [
                  //                                 headingH10(
                  //                                     text: 'Job type',
                  //                                     context: context),
                  //                                 SizedBox(
                  //                                   height: 3,
                  //                                 ),
                  //                                 headingH6(
                  //                                     text: controller
                  //                                         .getProfileDetailsApiResponse
                  //                                         .data
                  //                                         .user
                  //                                         .employmentType,
                  //                                     context: context)
                  //                               ],
                  //                             ),
                  //                             Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               children: [
                  //                                 headingH10(
                  //                                     text: 'Preferred shift',
                  //                                     context: context),
                  //                                 SizedBox(
                  //                                   height: 3,
                  //                                 ),
                  //                                 headingH6(
                  //                                     text:
                  //                                         '${controller.getProfileDetailsApiResponse.data.user.prefferedShift}           ',
                  //                                     context: context)
                  //                               ],
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     )),
                  //               ),
                  //             ),
                  //             _buildBasicDetailsCard(context),
                  //             SizedBox(
                  //               height: 20,
                  //             ),
                  //             _buildBasicEmployementCard(context),
                  //             SizedBox(
                  //               height: 20,
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 SharedPref.removeData(
                  //                     key: SharePrefKey.authToken);
                  //                 Navigator.pushReplacementNamed(
                  //                     context, AppRoutes.loginPage);
                  //               },
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.logout,
                  //                     size: 20,
                  //                     color: ColorUtils.darkGray,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   headingH6(text: 'Logout', context: context)
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 20,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
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

  void _showLDeleteMyAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete My Account",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content:
              Text("Are you sure you want to permanently delete your app?"),
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
                "Yes, Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
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
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Container(
          // height: displayHeight(context)/3.8,
          width: displayWeight(context),

          decoration: BoxDecoration(
            color: Colors.white,
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
                      ImageUtils.getImage(
                          image: ImageUtils.EditIcon, height: 15)
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
                              text: controller.getProfileDetailsApiResponse!.data
                                  .user.highestQualification,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Container(
          // height: displayHeight(context)/3.8,
          width: displayWeight(context),

          decoration: BoxDecoration(
            color: Colors.white,
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
                      // controller.getProfileDetailsApiResponse.data.user
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
}
