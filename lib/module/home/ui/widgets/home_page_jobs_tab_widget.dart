import 'package:flutter/material.dart';
import 'package:naukri_user/module/dashboard/provider/dashboard_provider.dart';
import 'package:naukri_user/module/home/ui/job_card_widget.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:provider/provider.dart';

class JobTabsWidget extends StatefulWidget {
  const JobTabsWidget({super.key});

  @override
  State<JobTabsWidget> createState() => _JobTabsWidgetState();
}

class _JobTabsWidgetState extends State<JobTabsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardController, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _getTabs(isSelected: true, title: "Recent Jobs"),
                  SizedBox(
                    width: 20,
                  ),
                  _getTabs(isSelected: false, title: "Applied Jobs"),
                  SizedBox(
                    width: 20,
                  ),
                  _getTabs(isSelected: false, title: "Created Alerts")
                ],
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

  Color _getRandomPastelColor() {
    return Colors.white;
  }

  Widget _getTabs({required bool isSelected, required String title}) {
    return InkWell(
      onTap: (){
        
      },
      child: FittedBox(
        child: Container(
          // height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: ColorUtils.primaryBlue),
              color: isSelected ? ColorUtils.primaryBlue : Colors.transparent),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color:
                  isSelected?
                   Colors.white:
                   Colors.black
                   ),
            ),
          ),
        ),
      ),
    );
  }
}
