import 'dart:math';

import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/text_widgets.dart';
import 'package:naukri_user/models/job_model.dart';
import 'package:naukri_user/services/web_services_constant.dart';
import 'package:naukri_user/utils/app_routes.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/image_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';

class JobCardWidget extends StatelessWidget {
  bool isRecent;
  JobModel jobModel;
  final Color getRandomPastelColor;
  JobCardWidget({
    required this.isRecent,
    required this.jobModel,
    required this.getRandomPastelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: 15.0, top: isRecent ? 0 : 15.0, bottom: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.jobDetailsPage,
              arguments: jobModel.jobId.toString());
        },
        child: Container(
          width: isRecent
              ? displayWeight(context) / 1
              : displayWeight(context) / 1.4,
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.grey[350]!
            ),
            color: getRandomPastelColor ?? Colors.red,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            border: Border.all(
                                width: 0.5, color: Colors.grey[350]!),
                           
                            image: DecorationImage(
                                image: NetworkImage(
                                    WebServicesConstant.companyBaseUrl +
                                        jobModel.companyLogo),
                                fit: BoxFit.fill)),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingH3(
                              text: jobModel.jobTitle,
                              context: context,
                              color: ColorUtils.blackColor),
                          SizedBox(
                            height: 5.0,
                          ),
                          headingH10(
                              text: '${jobModel.noOfRequirements}+ Openings',
                              context: context,
                              color: ColorUtils.blackColor)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: Image.asset(
                          ImageUtils.Experience,
                          height: 10,
                          color: ColorUtils.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                     
                      heading3Custom(
                          text: 'more than 2 years',
                          context: context,
                          color: Colors.black)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            child: Image.asset(
                              ImageUtils.CompanyLogo,
                              height: 15,
                              color: ColorUtils.blackColor,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          heading3Custom(
                              text: jobModel.companyName,
                              context: context,
                              color: Colors.black)
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            child: Image.asset(
                              ImageUtils.StartLogo,
                              height: 15,
                              
                              color: ColorUtils.blackColor,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          heading3Custom(
                              text: '4.5',
                              context: context,
                              
                               color: Colors.black)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: Image.asset(
                          ImageUtils.LocationLogo,
                          height: 15,
                          color: ColorUtils.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      heading3Custom(
                          text: jobModel.jobLocation,
                          context: context,
                          color: Colors.black)
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
