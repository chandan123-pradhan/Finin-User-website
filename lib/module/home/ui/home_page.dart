import 'dart:math';

import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/common_widgets/home_appbar.dart';
import 'package:naukri_user/common_widgets/text_field_widgets.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/module/home/ui/job_card_widget.dart';
import 'package:naukri_user/module/home/ui/widgets/alert_widget.dart';
import 'package:naukri_user/module/home/ui/widgets/home_page_jobs_tab_widget.dart';
import 'package:naukri_user/module/home/ui/widgets/navbar_widget.dart';
import 'package:naukri_user/module/home/ui/widgets/profile_performance_widget.dart';
import 'package:naukri_user/module/home/widgets/carousel_with_dots.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    _getRandomPastelColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DashboardProvider>(context, listen: false).initConfig(context);
    return Scaffold(
        backgroundColor: ColorUtils.lightGray,
        body:
            Consumer<DashboardProvider>(builder: (context, controller, child) {
          return controller.isloading
              ? SizedBox(
                  height: displayHeight(context) / 1.2,
                  child: Center(
                    child: ImageUtils.getLottie(
                        file: ImageUtils.loadingLottie, height: 60, width: 60),
                  ),
                )
              : Column(
                  children: [
                 NavbarWidget(), 
                  
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: displayWeight(context) / 8),
                      child: Row(
                        children: [
                          _getLeftSideWidget(controller),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CarouselWithDots(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        _recommendedJobs(),
                                       JobTabsWidget()
                                      ],
                                    ),
                                  ))),
                          Column(
                            children: [
                            AlertWidget(),
                              SizedBox(
                                height: 42,
                              ),
                              Container(
                                width: displayWeight(context) / 5.5,
                                height: displayHeight(context) / 4,
                                decoration: BoxDecoration(
                                    color: ColorUtils.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey[350]!)),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
                );
        }));
  }

 
  
  Color _getRandomPastelColor() {
    
    return Colors.white;
  }

  _recommendedJobs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Consumer<DashboardProvider>(
          builder: (context, dashboardController, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Your recommendations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              // const SizedBox(height: 10),
              dashboardController.isloading
                  ? SizedBox(
                      height: displayHeight(context) / 1.2,
                      child: Center(
                        child: ImageUtils.getLottie(
                            file: ImageUtils.loadingLottie,
                            height: 60,
                            width: 60),
                      ),
                    )
                  : SizedBox(
                      height: displayHeight(context) / 3.35,
                      width: displayHeight(context) / 1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap:
                            false, // Makes ListView take only the space it needs
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        itemCount: dashboardController
                            .getJobsApiResponse.data.jobs.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: displayWeight(context) / 4,
                            child: JobCardWidget(
                                isRecent: false,
                                getRandomPastelColor: _getRandomPastelColor(),
                                jobModel: dashboardController
                                    .getJobsApiResponse.data.jobs[index]),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRecentJobs() {
    return 
    Consumer<DashboardProvider>(
      builder: (context, dashboardController, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recent Job Posts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap:
                  true, // Important: Makes the ListView fit inside Column
              physics:
                  NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
              padding: const EdgeInsets.only(left: 15),
              itemCount: dashboardController.getJobsApiResponse.data.jobs
                  .length, // Use actual data length
              itemBuilder: (context, index) {
                return JobCardWidget(
                  getRandomPastelColor: _getRandomPastelColor(),
                  isRecent: true,
                  jobModel:
                      dashboardController.getJobsApiResponse.data.jobs[index],
                );
              },
            ),
          ],
        );
      },
    );
 
 
  }

  Widget _getLeftSideWidget(controller) {
    return Container(
      width: displayWeight(context) / 5.5,
      decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.5, color: Colors.grey[350]!)),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: ColorUtils.green)),
            alignment: Alignment.center,
            child: controller.getProfileDetailsApiResponse == null
                ? SizedBox()
                : Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: ColorUtils.lightGray,
                        ),
                        image: DecorationImage(
                            image: NetworkImage(WebServicesConstant.baseUrl +
                                controller.getProfileDetailsApiResponse!.data
                                    .user.profileImageUrl),
                            fit: BoxFit.fill)),
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          headingH3(
              text: controller.getProfileDetailsApiResponse!.data.user.fullName,
              context: context),
          SizedBox(
            height: 10,
          ),
          controller.getProfileDetailsApiResponse!.data.user.employmentHistory
                  .isEmpty
              ? SizedBox()
              : headingH5(
                  text:
                      "${controller.getProfileDetailsApiResponse!.data.user.employmentHistory[0].designation} @${controller.getProfileDetailsApiResponse!.data.user.employmentHistory[0].employerName}",
                  context: context),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: headingH10(
                  isMultiline: true,
                  text: controller
                      .getProfileDetailsApiResponse!.data.user.description,
                  context: context,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: BottomWidget.getMainBottom(
              color: ColorUtils.primaryBlue,
              context: context,
              title: 'Complete profile',
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child:ProfilePerformanceWidget()
            )
        ],
      ),
    );
  }





}
