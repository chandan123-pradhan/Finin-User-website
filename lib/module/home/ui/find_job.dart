import 'dart:math';

import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/search_field.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/module/home/ui/job_card_widget.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart'; // Import Provider package

class FindJobPage extends StatefulWidget {
  const FindJobPage({super.key});

  @override
  State<FindJobPage> createState() => _FindJobPageState();
}

class _FindJobPageState extends State<FindJobPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Color _getRandomPastelColor() {
    final Random _random = Random();
    return Color.fromRGBO(
      _random.nextInt(100) + 50, // Red (50-150)
      _random.nextInt(100) + 80, // Green (80-180)
      _random.nextInt(100) + 100, // Blue (100-200)
      1, // Full opacity
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.lightGray,
        appBar: AppBar(
          backgroundColor: ColorUtils.lightGray,
          elevation: 0,
          centerTitle: true,
          title: headingH4(context: context, text: 'Search your dream job'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<DashboardProvider>(
                    builder: (context, dashboardController, child) {
                  return SearchField(
                    controller: searchController,
                    onChanged: (value) {
                      dashboardController.searchJobs(
                          querry: value, context: context);
                    },
                    onSubmitted: () {
                      print("Search submitted: ${searchController.text}");
                    },
                  );
                }),
              ),
              Expanded(child: _buildRecentJobs())
            ],
          ),
        ));
  }

  Widget _buildRecentJobs() {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardController, child) {
        return dashboardController.isloading
            ? SizedBox(
                height: displayHeight(context) / 1.2,
                child: Center(
                  child: ImageUtils.getLottie(
                      file: ImageUtils.loadingLottie, height: 60, width: 60),
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap:
                    true, // Important: Makes the ListView fit inside Column
                // physics:
                //     NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
                padding: const EdgeInsets.only(left: 15),
                itemCount: dashboardController
                    .searchJobsResult.length, // Use actual data length
                itemBuilder: (context, index) {
                  return JobCardWidget(
                    isRecent: true,
                    getRandomPastelColor: _getRandomPastelColor(),
                    jobModel: dashboardController.searchJobsResult[index],
                  );
                },
              );
      },
    );
  }
}
