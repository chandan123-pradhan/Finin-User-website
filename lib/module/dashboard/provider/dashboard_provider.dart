import 'package:flutter/material.dart';
import 'package:naukri_user/models/base_response.dart';
import 'package:naukri_user/models/job_model.dart';
import 'package:naukri_user/models/response/get_applied_job_api_response.dart';
import 'package:naukri_user/models/response/get_jobs_api_response.dart';
import 'package:naukri_user/models/response/get_profile_api_response.dart';
import 'package:naukri_user/module/alerts/ui/alers_page.dart';
import 'package:naukri_user/module/applies/ui/applies_page.dart';
import 'package:naukri_user/module/dashboard/repository/dashboard_repository.dart';
import 'package:naukri_user/module/home/ui/home_page.dart';
import 'package:naukri_user/module/profile/ui/profile_page.dart';
import 'package:naukri_user/services/api_state.dart';
import 'package:naukri_user/utils/app_routes.dart';

class DashboardProvider extends ChangeNotifier {
  int currentPage = 0;
  DashboardRepository dashboardRepository = DashboardRepository();
  GetProfileDetailsApiResponse? getProfileDetailsApiResponse;
  late GetJobsApiResponse getJobsApiResponse;
  List<JobModel> searchJobsResult = [];
  late GetAppliedJobApiResponse getAppliedJobApiResponse;
  bool isloading = true;
  bool getAppliedJobLoading = true;

  List<Widget> screens = [
    HomePage(),
    AppliedPage(),
    ProfilePage(),
    AlertsPage()
  ];

  void changePage(int page) {
    currentPage = page;
    notifyListeners();
  }

  initConfig(context) {
    _getProfileDetails(context);
    getJobs(context);
    getAppliedJobs(context);
  }

  _getProfileDetails(context) async {
    BaseResponse baseResponse = await dashboardRepository.getProfileDetails();
    switch (baseResponse.status) {
      case RequestState.success:
        getProfileDetailsApiResponse =
            GetProfileDetailsApiResponse.fromJson(baseResponse.responseBody);
        break;

      default:
        Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
        break;
    }
  }

  getJobs(context) async {
    isloading = true;

    BaseResponse baseResponse = await dashboardRepository.getJobs();
    isloading = false;
    switch (baseResponse.status) {
      case RequestState.success:
        getJobsApiResponse =
            GetJobsApiResponse.fromJson(baseResponse.responseBody);
        searchJobsResult = getJobsApiResponse.data.jobs;
        break;

      default:
        Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
        break;
    }
    notifyListeners();
  }

  getAppliedJobs(context) async {
    // getAppliedJobLoading=true;

    BaseResponse baseResponse = await dashboardRepository.getAppliedJobs();
    getAppliedJobLoading = false;
    switch (baseResponse.status) {
      case RequestState.success:
        getAppliedJobApiResponse =
            GetAppliedJobApiResponse.fromJson(baseResponse.responseBody);
        break;

      default:
        Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
        break;
    }
    notifyListeners();
  }

  void searchJobs(
      {required String querry, required BuildContext context}) async {
    isloading = true;

    notifyListeners();

    BaseResponse baseResponse = await dashboardRepository.searchJobs(querry);
    isloading = false;
    switch (baseResponse.status) {
      case RequestState.success:
        searchJobsResult =
            GetJobsApiResponse.fromJson(baseResponse.responseBody).data.jobs;
        break;

      default:
        // Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
        break;
    }
    notifyListeners();
  }
}
