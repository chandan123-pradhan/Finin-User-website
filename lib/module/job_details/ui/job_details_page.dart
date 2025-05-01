import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/models/job_details_model.dart';
import 'package:naukri_user/module/home/provider/home_provider.dart';
import 'package:naukri_user/module/home/ui/widgets/navbar_widget.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/helper_methods.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';
import 'package:provider/provider.dart';

class JobDetailsPage extends StatelessWidget {
  final String jobId;

  const JobDetailsPage({required this.jobId});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getJobDetails(jobId: jobId, context: context);

    return Scaffold(
      backgroundColor: ColorUtils.lightGray,
      // appBar: AppBar(
      //   backgroundColor: ColorUtils.lightGray,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.navigate_before,
      //         size: 30, color: ColorUtils.darkGray),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   actions:  [
      //     Padding(
      //       padding: EdgeInsets.only(right: 20.0),
      //       child: InkWell(
      //         onTap: (){
      //           HelperMethods.shareLink(
      //             WebServicesConstant.baseUrl+WebServicesConstant.jobDetails+'?jobid='+jobId
      //           );
      //         },
      //         child: Icon(Icons.share_outlined,
      //             size: 20, color: ColorUtils.darkGray),
      //       ),
      //     ),
      //   ],
      // ),
      body: Consumer<HomeProvider>(
        builder: (context, homeController, child) {
          return homeController.isloading
              ? Container(
                  height: displayHeight(context) / 1.2,
                  width: displayWeight(context) / 1,
                  child: Center(child: CircularProgressIndicator()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavbarWidget(),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: displayWeight(context) / 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            _getBanner(context),
                             SizedBox(
                              height: 20,
                            ),
                            _buildCompanyNameAndLogoWidget(context,
                                homeController.getJobDetailsApiResponse!.data),
                            const SizedBox(height: 20),
                            _buildRequirementsWidget(context,
                                homeController.getJobDetailsApiResponse!.data),
                            const SizedBox(height: 10),
                            const Divider(),
                            _buildAboutCompany(context,
                                homeController.getJobDetailsApiResponse!.data),
                                 const SizedBox(height: 20),
                            _getBottons(context,homeProvider),
                                const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ))
                  ],
                );
        },
      ),
     
    );
  }

  Widget _buildAboutCompany(BuildContext context, JobDetails jobDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingH5(text: 'About us', context: context),
        const SizedBox(height: 10),
        headingH6(
          text: jobDetails.jobPost.jobDescription,
          context: context,
          color: ColorUtils.blackColor,
          isSelectable: true,
        ),
      ],
    );
  }


  _getBottons(BuildContext context, HomeProvider homeProvider){
    return   Consumer<HomeProvider>(
        builder: (context, homeController, child) {
          final jobDetails;
          bool isApplied = false;
          if (!homeController.isloading) {
            jobDetails = homeController.getJobDetailsApiResponse!.data;
            isApplied = jobDetails.isApplied;
          }

          return homeController.isloading
              ? SizedBox(
                  height: 10,
                )
              :  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BottomWidget.getTransparentBottom(
                          context: context,
                          onPressed: () {},
                          title: 'Call',
                          width: displayWeight(context) /10,
                        ),
                        SizedBox(width: 20,),
                        BottomWidget.getMainBottom(
                          context: context,
                          color: isApplied
                              ? ColorUtils.disableBottonColor
                              : ColorUtils.green,
                          onPressed: () {
                            if (!isApplied) {
                              homeProvider.applyJob(
                                  jobId: jobId, context: context);
                            }
                          },
                          title: isApplied ? 'Applied' : 'Apply',
                          width: displayWeight(context) / 10,
                        ),
                      ],
                    
                  
                );
        },
      );
  }

  Widget _getBanner(BuildContext context){
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(
          ImageUtils.firstBanner
        ),
        fit: BoxFit.fill
        )
      ),
    );
  }

  Widget _buildRequirementsWidget(BuildContext context, JobDetails jobDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingH5(text: 'Job Description', context: context),
        const SizedBox(height: 10),
        _buildRequirementRow('Required Experience:', '3+ Years', context),
        _buildRequirementRow(
            'Location:', jobDetails.jobPost.jobLocation, context),
        _buildRequirementRow(
            'Qualification:', jobDetails.jobPost.qualification, context),
        _buildRequirementRow('Skills:', jobDetails.jobPost.skills, context),
        _buildRequirementRow('Salary:', '12 LPA', context),
        _buildRequirementRow(
            'Notice Period:', 'Should be less than 30 days', context),
        _buildRequirementRow('No. Of Requirements:',
            jobDetails.jobPost.noOfRequirements.toString(), context),
        Row(
          children: [
            const Icon(Icons.people_alt_outlined,
                size: 20, color: ColorUtils.lightGrey),
            const SizedBox(width: 10),
            headingH6(
              text: '${jobDetails.applicantCount} Applications',
              context: context,
              color: ColorUtils.blackColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRequirementRow(
      String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          headingH6(text: label, context: context, color: ColorUtils.lightGrey),
          const SizedBox(width: 10),
          headingH6(
              text: value, context: context, color: ColorUtils.blackColor),
        ],
      ),
    );
  }

  Widget _buildCompanyNameAndLogoWidget(
      BuildContext context, JobDetails jobDetails) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorUtils.lightGray),
            image: DecorationImage(
              image: NetworkImage(WebServicesConstant.companyBaseUrl +
                  jobDetails.jobPost.companyLogo),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingH5(
                text: jobDetails.jobPost.jobTitle,
                context: context,
                color: ColorUtils.darkGray),
            const SizedBox(height: 5),
            headingH10(text: jobDetails.jobPost.companyName, context: context),
          ],
        ),
      ],
    );
  }
}
